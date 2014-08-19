import Kernel, except: [raise: 2]

defmodule Powers do
	def raise(x, n) do
		cond do
			n == 0 -> 1
			n == 1 -> x
			n > 0 -> x * raise(x, n - 1)
			true -> 1.0 / (raise(x, -n))
		end
	end
end
