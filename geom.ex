
defmodule Geom do
	@moduledoc """
  Provides functions for calculating areas of geometric shapes.
  """
	def area(shape, a, b) when a >= 0 and b >= 0 do
		case shape do
			:rectangle -> a * b
			:triangle -> a * b / 2.0
			:ellipse -> a * b * :math.pi()
			_ -> 0
		end
	end
end
