defmodule NonFP do
	
	@spec generate_pockets(list, number) :: list(list)
	def generate_pockets(t_list, p) do
		generate_pockets(t_list, p, [])
	end

	defp generate_pockets([], _, accum) do
		Enum.reverse accum
	end

	defp generate_pockets([head | tail], p, accum) when head == ?T do
		generate_pockets(tail, p, [generate_tooth(p) | accum ])
	end

	defp generate_pockets([head | tail], p, accum) do
		generate_pockets(tail, p, [[0] | accum])
	end

	@spec generate_tooth(number) :: list(number)
	def generate_tooth(p) do
		rand_p = :random.uniform()
		base_depth = cond do
			             rand_p < p -> 2
			             true -> 3
		             end
		generate_tooth(base_depth, 6, [])
	end
	
	@spec generate_tooth(number, number, list) :: list(number)
	def generate_tooth(base, num, accum) do
		rand_int = :random.uniform(3) - 2
		cond do
			num == 0 -> accum
			true -> generate_tooth(base, num - 1, [rand_int + base | accum])
		end
	end
end
