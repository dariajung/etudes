defmodule Game do
	
	@doc """ 
  
  """

	def setup() do
		deck = Cards.make_deck(["2", "3", "4", "5"],
															 ["Hearts", "Diamonds", "Clubs", "Spades"])
		shuffled = Cards.shuffle(deck)
		{ hand1, hand2 } = Enum.split(deck, Enum.count(deck) / 2)
		player1 = spawn(Player, :start, hand1)
		player2 = spawn(Player, :start, hand2)
		
	end
	
	
end
