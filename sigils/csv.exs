defmodule CSVSigil do
  def sigil_v(content, []), do: _parse(content, :default)
  def sigil_v(content, 'h'), do: _parse(content, :has_header)

  defp _parse(lines, opts) when is_binary(lines) do
    lines
    |> String.trim_trailing()
    |> String.split("\n")
    |> _parse(opts)
  end

  defp _parse(lines, opts) when is_list(lines) do
    lines
    |> _lines_to_list()
    |> _result(opts)
  end

  defp _lines_to_list(lines) do
    lines
    |> Enum.map(fn line -> String.split(line, ",") end)
  end

  defp _result(lines, :default), do: lines
  defp _result(lines, :has_header) do
    [head | tail] = lines
    tail
    |> Enum.map(fn line ->
      line
      |> Enum.with_index()
      |> Enum.map(fn {val, idx} ->
        {
          Enum.at(head, idx) |> String.to_atom(),
          val
        }
      end)
      |> Keyword.new()
    end)
  end
end

defmodule Test do
  import CSVSigil

  def run() do
    IO.puts("--------------")
    list = ~v"""
    foo,bar
    boing,flip
    """
    IO.inspect(list, label: "list 1")

    IO.puts("--------------")
    list = ~v"""
    foo,bar
    boing,flip
    """h
    IO.inspect(list, label: "list 2")

    true
  end
end
