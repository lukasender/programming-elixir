exercise = fn
  name -> IO.puts("\n\n# 👷‍♂️ Exercise #{name}\n")
  _    -> IO.puts("\n\n# 👷‍♂️ Exercise\n")
end

# --------------------------------------
exercise.("fizz-buzz + rem")

fizz_buzz = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, third) -> third
end

IO.puts fizz_buzz.(0, 0, "foo")
IO.puts fizz_buzz.(0, 1, "bar")
IO.puts fizz_buzz.(1, 0, "baz")
IO.puts fizz_buzz.(1, 1, "other")

fun_with_rem = fn n ->
  fizz_buzz.(rem(n, 3), rem(n, 5), n)
end

IO.puts("----------------")
IO.puts(fun_with_rem.(10))
IO.puts(fun_with_rem.(11))
IO.puts(fun_with_rem.(12))
IO.puts(fun_with_rem.(13))
IO.puts(fun_with_rem.(14))
IO.puts(fun_with_rem.(15))
IO.puts(fun_with_rem.(16))


# --------------------------------------
exercise.("prefix functions-4")

prefix = fn pf ->
  fn str ->
    "#{pf}#{str}"
  end
end

ex = prefix.("Elixir ")

IO.puts ex.("Rocks!")
IO.puts ex.("🚀")


# --------------------------------------
exercise.("& function capture functions-5")

add_2 = fn list ->
  IO.inspect(Enum.map(list, fn x -> x + 2 end))
  IO.inspect(Enum.map(list, &(&1 + 2)))
end

add_2.([1, 2, 3, 4])

inspect_all = fn list ->
  IO.inspect(Enum.each(list, fn x -> IO.inspect(x) end))
  IO.inspect(Enum.each(list, &IO.inspect/1))
end

inspect_all.([1, 2, 3, 4])
