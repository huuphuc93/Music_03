namespace :clear do
  desc "Clear your data expired"
  task :lyric => :environment do
    puts "You will deleted all data expired"
    Lyric.where("created_at >= ? and accepted = ?", Time.now - 1.month,
      false).destroy_all
  end
end
