class Dice
  def initialize(faces_count)
    @faces_count = faces_count
  end
  
  
  def roll
    SecureRandom.random_number(@faces_count) + 1
  end
end
