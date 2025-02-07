defmodule Chain do
  """
  Run `$ elixir -r chain.exs -e "Chain.run(10)"`
  """

  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n + 1
    end
  end

  def create_processes(n) do
    code_to_run = fn send_to ->
      # Create the next process
      spawn(Chain, :counter, [send_to])
    end

    last =
      Stream.repeatedly(fn -> self() end)
      |> Enum.take(n)
      |> Enum.each(code_to_run)

    IO.inspect(last, label: "last")

    send(last, 0) # Start the count by sending a zero to the last process

    receive do # and wait for the result to come back to us
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    :timer.tc(Chain, :create_processes, [n])
    |> IO.inspect()
  end
end
