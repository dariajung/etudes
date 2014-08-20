defmodule Teeth do
	def pocket_depths do
		[[0], [2,2,1,2,2,1], [3,1,2,3,2,3],
		 [3,1,3,2,1,2], [3,2,3,2,2,1], [2,3,1,2,1,1],
		 [3,1,3,2,3,2], [3,3,2,1,3,1], [4,3,3,2,3,3],
		 [3,1,1,3,2,2], [4,3,4,3,2,3], [2,3,1,3,2,2],
		 [1,2,1,1,3,2], [1,2,2,3,2,3], [1,3,2,1,3,3], [0],
		 [3,2,3,1,1,2], [2,2,1,1,3,2], [2,1,1,1,1,2],
		 [3,3,2,1,1,3], [3,1,3,2,3,2], [3,3,1,2,3,3],
		 [1,2,2,3,3,3], [2,2,3,2,3,3], [2,2,2,4,3,4],
		 [3,4,3,3,3,4], [1,1,2,3,1,2], [2,2,3,2,1,3],
		 [3,4,2,4,4,3], [3,3,2,1,2,3], [2,2,2,2,3,3],
		 [3,2,3,2,3,2]]
	end

	def alert(list) do
		alert(1, list, [])
	end

	def alert(tooth_num, list, accum) do
		cond do
			list == [] -> Enum.reverse accum
			Stats.maximum(hd(list)) >= 4 ->
				alert(tooth_num + 1, tl(list), [tooth_num | accum])
			true -> alert(tooth_num + 1, tl(list), accum)
		end
	end

end
