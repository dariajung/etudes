defmodule Stats do
	@spec minimum(list) :: number()
	def minimum(list) when list != [] do
		minimum(tl(list), hd(list))
	end

	@spec minimum(list, number()) :: number()
	def minimum(list, current) do
		try do
			cond do
				list == [] -> current
				hd(list) < current -> minimum(tl(list), hd(list))
				:true -> minimum(tl(list), current)
			end
		rescue
			error -> error
		end
	end

	def maximum(list) do
		maximum(tl(list), hd(list))
	end

	def maximum(list, current) do
		try do
			cond do
				list == [] -> current
				hd(list) > current -> maximum(tl(list), hd(list))
				:true -> maximum(tl(list), current)
			end
		rescue
			error -> error
		end
	end
	
	@spec mean(list(number)) :: number()
	def mean(list) do
		try do
			sum = List.foldl(list, 0, fn (x, acc) -> x + acc end)
			sum / Enum.count(list)
		rescue
			error -> error
		end
	end

	def stdv(list) do
		try do
			{sum, sum_of_squares} = List.foldl(list, {0, 0}, 
													 fn (x, {s, sum_sq}) -> {x + s, x * x + sum_sq} end)
			n = Enum.count(list)
			temp = (n * sum_of_squares) - (sum * sum)
			:math.sqrt(temp / (n * (n - 1)))
		rescue
			error -> error
		end
	end
end
