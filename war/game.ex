defmodule Game do
	
	@doc """ 
	Emulates a game of War. Childhood nostalgia. <3
  
  	"""

	def setup() do
		deck = Cards.make_deck([2, 3, 4, 5], ["Hearts", "Diamonds", "Clubs", "Spades"])
		shuffled = Cards.shuffle(deck)
		half = div(Enum.count(shuffled), 2)
		# split takes an int, can't take float
		{ hand1, hand2 } = Enum.split(shuffled, half)
		# IO.puts("#{inspect(hand1)}")
		# IO.puts("#{inspect(hand2)}")
		player1 = spawn(Player, :begin, [hand1])
		player2 = spawn(Player, :begin, [hand2])
		play([player1, player2], :pre_battle, [], [], 0, [])
	end

	@spec play(list(pid), :atom, list, list, number, list) :: nil
	def play([player1, player2], state, card1, card2, num, pile) do
		players = [player1, player2]
		case state do
			:pre_battle -> 
				IO.puts("Waiting for players to send over cards.\n")
				case pile do
					[] -> 
						IO.puts("Requesting 1 card from players.\n")
						request_cards(1, players)
					_  -> 
						IO.puts("Requesting 3 cards from players.\n")
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
								IO.puts("Received card(s) #{inspect(payload)} from Player #{inspect(player1)}")
								play([player1, player2], state, 
									payload, card2, num + 1, pile)  
							pid == player2 -> 
								IO.puts("Received card(s) #{inspect(payload)} from Player #{inspect(player2)}")
								play([player1, player2], state, 
									card1, payload, num + 1, pile) 
						end
				end
			:evaluate_battle -> 
				cond do
					card1 == [] and card2 == [] -> 
						IO.puts("The game has ended in a draw.\n")
					card1 == [] -> 
						IO.puts("Player #{inspect(player2)} wins the game!\n")
					card2 == [] -> 
						IO.puts("Player #{inspect(player1)} wins the game!\n")
					true ->
						{new_pile, winner} = evaluate([player1, player2], card1, card2, pile)
						if winner do
							IO.puts("Player #{inspect(winner)} wins this round.\n")
							send winner, {:collect_loot, new_pile, self()}
							receive do
								{:received_cards, pid} ->
									IO.puts("\tPlayer #{inspect(pid)} has picked up cards.\n")
									pid
							end
							play([player1, player2], :pre_battle, [], [], 0, [])
						else
							# WAR. WHAT IS IT GOOD FOR. ABSOLUTELY NOTHING.
							IO.puts("GO TO WAR! WHAT IS IT GOOD FOR? ABSOLUTELY NOTHING. Except amassing more cards.\n")
							play([player1, player2], :pre_battle, card1, card2, 0, new_pile)	
						end
				end
		end
	end

	def end_game([p1, p2]) do
		send p1, {:game_over}
		send p2, {:game_over}
	end

	def evaluate([p1, p2], card1, card2, pile) do
		p1_play = get_card_val(List.last(card1))
		p2_play = get_card_val(List.last(card2))
		new_pile = pile ++ card1 ++ card2

		cond do
			p1_play > p2_play ->
				{new_pile, p1}
			p2_play > p1_play -> 
				{new_pile, p2}
			true -> 
				{new_pile, nil}
		end
	end

	defp get_card_val({ value, _suite }) do
		case value do
			"A" -> 14
			"K" -> 13
			"Q" -> 12
			"J" -> 11
			_ -> value
		end
	end
					
	def request_cards(num, [p1, p2]) do
		dealer_pid = self()
		send p1, {:give, num, dealer_pid}
		send p2, {:give, num, dealer_pid}
	end

end
