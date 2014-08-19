defmodule Dates do
	@spec date_parts(String.t()) :: list
	def date_parts(iso) do
		[year, month, date] = String.split(iso, "-")
		Enum.map([year, month, date], fn(x) -> String.to_integer(x) end)
  end
end
