defmodule Stats do
	@spec minimum(list) :: number()
	def minimum(list) when list != [] do
		minimum(tl(list), hd(list))
	end

	@spec minimum(list, number()) :: number()
	def minimum(list, current) do
		cond do
			list == [] -> current
			hd(list) < current -> minimum(tl(list), hd(list))
			:true -> minimum(tl(list), current)
		end
	end

	def maximum(list) do
		maximum(tl(list), hd(list))
	end

	def maximum(list, current) do
		cond do
			list == [] -> current
			hd(list) > current -> maximum(tl(list), hd(list))
			:true -> maximum(tl(list), current)
		end
	end
	
end
