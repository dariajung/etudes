defmodule Cards do
	@spec make_dec() :: list(tuple)
	def make_deck() do
		for suite <- ["Clubs", "Diamonds", "Hearts", "Spades"], 
				card <- ["A", "2", "3", "4", "5", "6", "7", "8", "9",
								 "10", "J", "Q", "K"], do: {card, suite}
	end

	def make_deck(cards, suites) do
		for card <- cards, suite <- suites, do: {card, suite}
	end

	@doc """
  Shuffle a deck of cards.
  """
	@spec shuffle(list(tuple)) :: list(tuple)
	def shuffle(list) do
		:random.seed(:erlang.now())
		shuffle(list, [])
	end
	
	# Helper function. 
	# When list of cards to shuffle is empty, return the accumulator
	# of currently shuffled cards.
	def shuffle([], acc) do
		acc
	end
	
	# Helper function.
	# Take the list of currently unshuffled cards, and accum, the list of 
	# shuffled cards.
	# Split the unshuffled cards at a random point, and take a card from the top
	# of the second half of the split unshuffled cards. Add that card to the acc
	# pile. Merge the first half of the split deck and the second half of the split
	# deck (now less one card), and repeat until no cards are left in the unshuffled
	# pile.
	@spec shuffle(list(tuple), number) :: list(tuple)
	def shuffle(list, acc) do
		{leading, [h | t]} =
    Enum.split(list, :random.uniform(Enum.count(list)) - 1)
    shuffle(leading ++ t, [h | acc])
	end
end
