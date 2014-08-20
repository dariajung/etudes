defmodule Calculus do
	@spec derivative(fn, number) :: number
	def derivative(g, x) do
		delta = 1.0e-10
		(g.(x + delta) - g.(x)) / delta
	end
end
