defmodule Math do
  def sum([]), do: 0
  def sum([ head | tail ]), do: head + sum(tail)
end

defmodule Stuff do
  Enum.map(Enum.reverse(List.flatten([1,[[2],3]])), fn x -> x * x end)

  [1,[[2],3]] |> List.flatten |> Enum.reverse |> Enum.map(fn x -> x * x end)

  :crypto.md5("Tales from the Crypt")
end
