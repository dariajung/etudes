defmodule AskArea do
	
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
		String.to_integer(String.strip(input))
	end

	def get_dimensions(prompt1, prompt2) do
		{ get_number(prompt1), get_number(prompt2) }
	end

end
