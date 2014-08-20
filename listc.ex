defmodule ListComp do
	
	def get_people() do
		[{"Federico", "M", 22}, {"Kim", "F", 45}, {"Hansa", "F", 30},
		 {"Tran", "M", 47}, {"Cathy", "F", 32}, {"Elias", "M", 50}]
	end

	def male_over_40(list) do
		for {name, gender, age} <- list, age > 40, gender == "M", do: {name, gender, age}
	end
end
		
