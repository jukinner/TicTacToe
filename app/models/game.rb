class Game < ApplicationRecord
  def self.start(player1, player2)
    # Randomly choses who gets to be noughts or crosses
    cross, nought = [player1, player2].shuffle

    # Broadcast back to the players subscribed to the channel that the game has started
    ActionCable.server.broadcast "player_#{cross}", {action: "game_start", msg: "X's"}
    ActionCable.server.broadcast "player_#{nought}", {action: "game_start", msg: "O's"}

    # Store the details of each opponent
    REDIS.set("opponent_for:#{cross}", nought)
    REDIS.set("opponent_for:#{nought}", cross)
  end
end
