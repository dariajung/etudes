defmodule Player do

	def begin(hand) do
		play(hand)
	end
	
	def play(hand) do
		# receive action, give x cards, have PID of dealer
		player_pid = self()
		receive do
			{:give, num_cards, dealer_pid} -> 
				{ payload, new_hand } = Enum.split(hand, num_cards)
			  send dealer_pid, {:take, payload, player_pid }
			{:take, loot, dealer_pid} -> 
					new_hand = hand ++ loot
			    send dealer_pid, {:received_cards, player_pid}
					IO.puts("New hand for Player #{inspect(player_pid)} is #{inspect(new_hand)}")
					play(new_hand)
			:game_over -> IO.puts("Player # {inspect(player_pid)} has left the game.")
		end
	end
end
