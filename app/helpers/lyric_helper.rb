module LyricHelper
  def activate_lyric lyric
    lyric.accepted ? "Accepted" : "Not Accepted"
  end
end