defmodule Identicon do
  def main do
    str = "Elixir"
    image = hash_input(str)
    pick_color(image)
  end

  def hash_input(str) do
    hash = :crypto.hash(:md5, str)
      |>:binary.bin_to_list

    %Identicon.Image{hex: hash}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail ]} = image) do
    %Identicon.Image{image | color: [r, g, b]}
  end

  def build_grid(list) do
    list
    |> Enum.drop(-1)
    |> Enum.chunk_every(3)
    |> Enum.map(&mirror_row(&1))
    |> List.flatten()
    |> Enum.with_index()
  end

  def mirror_row(row) do
    reversed_row =
    row
    |> Enum.reverse()
    |> Enum.drop(1)
    row ++ reversed_row
  end

  def filter_add_cells(list) do
    Enum.filter(list, &rem(elem(&1, 0), 2) == 0)
  end
end
