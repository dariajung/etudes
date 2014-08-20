defmodule Dates do
	@spec date_parts(String.t()) :: list
	def date_parts(iso) do
		[year, month, date] = String.split(iso, "-")
		Enum.map([year, month, date], fn(x) -> String.to_integer(x) end)
  end

	def julian(list) do
		[year, month, date] = date_parts(list)
		feb = case is_leap_year(year) do
						true -> 29
						false -> 28
					end
		days_month = [31, feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
		month_total(month, days_month, date)
	end

	def month_total(month, month_list, accum) do
		cond do
			month > 1 -> month_total(month - 1, tl(month_list), accum + (hd(month_list)))
			true -> accum
		end
	end

	defp is_leap_year(year) do
		(rem(year,4) == 0 and rem(year,100) != 0)
		or (rem(year, 400) == 0)
	end
end
