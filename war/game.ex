defmodule Game do
	
	@doc """ 
	Emulates a game of War. Childhood nostalgia. <3
  
  	"""

	def setup() do
		deck = Cards.make_deck(["2", "3", "4", "5"], ["Hearts", "Diamonds", "Clubs", "Spades"])
		shuffled = Cards.shuffle(deck)
		{ hand1, hand2 } = Enum.split(deck, Enum.count(deck) / 2)
		player1 = spawn(Player, :start, hand1)
		player2 = spawn(Player, :start, hand2)
		play([player1, player2], :pre_battle, [], [], 0, [])
	end

	@spec play(list(pid), :atom, list, list, number, list) :: nil

	def play([player1, player2], state, card1, card2, num, pile) do
		dealer_pid = self()
		players = [player1, player2]
		case state do
			:pre_battle -> 
				IO.puts("Waiting for players to send over cards.\n")
				case pile do
					[] -> 
						IO.puts("Requesting 1 card from players.")
						request_cards(1, players)
					_  -> 
						IO.puts("WAR! Requesting 3 cards from players.")
						request_cards(3, players)
				end
				play([player1, player2], :await_battle, card1, card2, num, pile)
			:await_battle when num == 2 -> 
				play([player1, player2], :evaluate_battle, card1, card2, num, pile)
			:await_battle -> 
				receive do
					{:take, payload, pid} -> 
						cond do
							pid == player1 -> 
								IO.puts("Received card from Player #{inspect(player1)}")
								play([player1, player2], state, 
									payload, card2, num + 1, pile)  
							pid == player2 -> 
								IO.puts("Received card from Player #{inspect(player2)}")
								play([player1, player2], state, 
									card1, payload, num + 1, pile) 
						end
				end
			:evaluate_battle -> 
				cond do
					card1 == [] and card2 == [] -> IO.puts("Game has ended in a draw.\n")
					card1 == [] -> IO.puts("Player #{inspect(player2)} wins the game!\n")
					card2 == [] -> IO.puts("Player #{inspect(player1)} wins the game!\n")
					true ->
						{new_pile, winner} = evaluate([player1, player2], card1, card2, pile)
						if winner do
							IO.puts("Player #{inspect(winner)} wins this round.\n")
							send winner, {:take, new_pile, self()}
							await_ack(winner)
							play([player1, player2], :pre_battle, [], [], 0, [])
						else
							# WAR. WHAT IS IT GOOD FOR. ABSOLUTELY NOTHING.
							play([player1, player2], :pre_battle, card1, card2, 0, new_pile)	
						end
				end
		end
	end

	def await_ack(winner_pid) do
		receive do
			{:received_cards, pid} ->
				IO.puts("Player #{inspect(pid)} has picked up cards.\n")
				pid
		end
	end

	def evaluate([p1, p2], card1, card2, pile) do
		p1_play = List.last(card1)
		p2_play = List.last(card2)
		new_pile = pile ++ card1 ++ card2

		cond do
			card1 > card2 ->
				{new_pile, p1}
			card2 > card1 -> 
				{new_pile, p2}
			true -> 
				{new_pile, nil}
		end
	end
					
	def request_cards(num, [p1, p2]) do
		dealer_pid = self()
		send p1, {:give, num, dealer_pid}
		send p2, {:give, num, dealer_pid}
	end

end
