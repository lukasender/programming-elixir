defmodule Issues.CLI do

  @default_count 4

  def main(argv) do
    argv
    |> parse_args()
    |> process()
  end

  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> to_internal_representation()
  end

  defp to_internal_representation({ [help: true] , _, _}), do: :help
  defp to_internal_representation({_, [ user, project, count ], _}) do
    { user, project, String.to_integer(count) }
  end
  defp to_internal_representation({_, [ user, project ], _}) do
    { user, project, @default_count }
  end
  defp to_internal_representation(_), do: :help

  def process(:help) do
    IO.puts """
    usage: issues <user> <projcet> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_desc()
    |> Enum.take(count)
    |> Enum.reverse()
    |> display()
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    IO.puts "Error fetching from Github: #{error["message"]}"
    System.halt(2)
  end

  def sort_desc(github_issues) do
    github_issues
    |> Enum.sort(fn element1, element2 ->
        element1["created_at"] >= element2["created_at"]
      end)
  end

  def display(github_issues) do
    IO.puts "Github Issues"
    IO.puts "-------------\n"
    Enum.each(github_issues, fn element ->
      title = Map.get(element, "title")
      url = Map.get(element, "url")
      user = Map.get(element, "user")
      user_name = Map.get(user, "login")
      IO.puts """
      #{title}
      #{url}
      - by #{user_name}
      """
    end)
  end

end
