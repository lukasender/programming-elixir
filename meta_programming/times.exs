defmodule Times do
  defmacro times_n(number) do
    IO.inspect(number, label: "number")
    quote do
      def unquote(:"times_#{number}")(value) do
        value * unquote(number)
      end
    end
  end
end

defmodule Test do
  require Times

  Times.times_n(2)
  Times.times_n(3)
  Times.times_n(4)
end

import IO.ANSI

IO.puts [white(), green_background(), "--------", reset(), green()]
IO.puts Test.times_2(4)
IO.puts Test.times_2(5)
IO.puts [reset()]

IO.puts [white(), red_background(), "--------", reset(), red()]
IO.puts Test.times_3(4)
IO.puts Test.times_3(5)
IO.puts [reset()]

IO.puts [white(), blue_background(), "--------", reset(), blue()]
IO.puts Test.times_4(4)
IO.puts Test.times_4(5)
IO.puts [reset()]
