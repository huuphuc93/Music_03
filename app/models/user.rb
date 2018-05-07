class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favorite_lists, dependent: :destroy
  has_many :lyrics, dependent: :destroy
  has_many :rates, dependent: :destroy
  enum role: [:user, :admin]
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: {maximum: Settings.user.maximum_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.maximum_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.user.minimum_password}, allow_nil: true

  def remember
    self.remember_token = User.new_token
    update_attributes(remember_digest: User.digest(remember_token))
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attributes(remember_digest: nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attributes(reset_digest: User.digest(reset_token))
    update_attributes(reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  class << self
    def digest string
      if ActiveModel::SecurePassword.min_cost
        cost = BCrypt::Engine::MIN_COST
      else
        cost = BCrypt::Engine.cost
      end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.uid = auth.uid
        user.email = auth.info.email
        user.name = auth.info.name
        user.activated = true
        user.password_digest = auth.credentials.token
        user.activation_digest = auth.credentials.token
        user.activated_at = Time.now
      end
    end

    def new_with_session params
      if session["user_attributes"]
        new(session["user_attributes"]) do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
