
defmodule Geom do
	@moduledoc """
  Provides functions for calculating areas of geometric shapes.
  """
	@doc """
  Calculates the area of a rectangle given w, width, and l, length. 
  Default values are provided in cases no parameters are passed into
  the area function.
  """
	def area(:rectangle, w, h) when w >= 0 and h >= 0 do
		w * h
	end

	@doc """
  Calculates the area of a triangle given a, base, and b, height.
  """
  def area(:triangle, a, b) when a >= 0 and b >= 0 do
		a * b / 2.0
	end
	
	@doc """
  Calculates the area of an ellipse given a, the major radius, and b,
  the minor radius 
  """
	def area(:ellipse, a, b) when a >= 0 and b >= 0 do
		a * b * :math.pi()
  end
end
