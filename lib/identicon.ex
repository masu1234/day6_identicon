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
    Enum.drop(list, -1)
  end
end
