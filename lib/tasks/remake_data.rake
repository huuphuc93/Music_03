namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    %w[db:drop db:create db:migrate].each do |task|
      Rake::Task[task].invoke
    end
    puts "You will be prompted to create data for project"
    
    require "faker"
    
    14.times do
      Category.create do |category|
        category.name = Faker::HarryPotter.location
      end
    end
    
    20.times do
      Artist.create do |artist|
        artist.name = Faker::Kpop.ii_groups
        artist.cover_image = open(Rails.root.join("app/assets/audio/artist.jpg"))
        artist.describe = Faker::Lorem.paragraph(20)
      end
    end
    
    @i = 1
    while @i < 14 do
      10.times do
        Album.create do |album|
          album.name = Faker::OnePiece.location
          album.category_id = @i
          album.artist_id = @i
          album.cover_image = open(Rails.root.join("app/assets/audio/album.jpg"))
        end
      end
      @i += 1
    end
    
    @i = 1
    while @i < 140 do
      20.times do
        Song.create do |song|
          song.name = Faker::Superhero.name
          song.album_id = @i
          song.audio = open(Rails.root.join("app/assets/audio/Co-Gai-M52-Huy-Tung-Viu.mp3"))
          song.cover_image = open(Rails.root.join("app/assets/audio/download.png"))
        end
      end
      @i += 1
    end
    
    Settings.users.each do |user|
      User.create name: user.name, email: user.email, password: user.password,
        password_confirmation: user.password_confirmation, activated: user.activated,
        role: user.role
    end
    
    50.times do
      User.create do |user|
        user.name = Faker::Name.name
        user.email = Faker::Internet.email
        user.password = "123456"
        user.password_confirmation = "123456"
        user.role = 0
        user.activated = true
      end
    end
    
    @i = 1
    while @i < 40 do
      5.times do
        FavoriteList.create do |fl|
          fl.name = Faker::LordOfTheRings.character
          fl.user_id = @i
        end
      end
      
      Favorite.create do |favorite|
        favorite.favorite_list_id = @i
        favorite.song_id = @i
      end
      @i += 1
    end
    
    @i = 1
    while @i < 50
      5.times do 
        Lyric.create do |lyric|
          lyric.content = Faker::Lorem.paragraph(50)
          lyric.song_id = @i
          lyric.user_id = @i
          lyric.accepted = true
        end
      end
      @i += 1
    end
  end
end