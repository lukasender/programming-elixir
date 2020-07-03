defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1, sort_desc: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args([]) == :help
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
    assert parse_args(["user", "--help", "anything"]) == :help
    assert parse_args(["user", "project", "--help", "anything"]) == :help
  end

  test "three values returned if thre given" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "count is defaulted if two values given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

  test "sort descending orders the correct way" do
    result = sort_desc(fake_list(["c", "a", "b"]))
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues == ~w{ c b a }
  end

  defp fake_list(values) do
    for value <- values,
    do: %{"created_at" => value}
  end
end
