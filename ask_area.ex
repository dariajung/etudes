defmodule AskArea do

	@spec area() :: number()
	def area() do
		inp = IO.gets("R)ectangle T)riangle or E)llipse: ")
		shape = char_to_shape(String.first(inp))

		{d1, d2} = case shape do
								 :rectangle -> get_dimensions("length", "width")
								 :triangle -> get_dimensions("base", "height")
								 :ellipse -> get_dimensions("major radius", "minor radius")
								 :unknown -> {0, 0}
								end
		calculate(shape, d1, d2)
	end
	
	@spec char_to_shape(char()) :: atom()
	def char_to_shape(input) do
		fchar = String.upcase input
		cond do
			fchar == "R" -> :rectangle
			fchar == "T" -> :triangle
			fchar == "E" -> :ellipse
			true -> :unknown
		end
	end
	
	@spec get_number(String.t()) :: number()
	def get_number(prompt) do
		input = IO.gets("Enter #{prompt} > ")
		_input = String.strip(input)
		cond do
			 Regex.match?(~r/^[+-]?\d+$/, _input) -> String.to_integer(_input)
			 Regex.match?(~r/^[+-]\d+\.\d+$/, _input) -> String.to_float(_input)
			 true -> :error
		end
	end

	def get_dimensions(prompt1, prompt2) do
		{ get_number(prompt1), get_number(prompt2) }
	end

	def calculate(s, d1, d2) do
		cond do
			s == :unknown -> IO.puts("No matching shape, #{s}")
			d1 < 0 or d2 < 0 -> IO.puts("Can't have negative numbers")
			true -> Geom.area(s, d1, d2)
		end
	end
end
