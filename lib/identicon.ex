defmodule Identicon do
  def main do
    str = "Elixir"
    hashList = hash_input(str)
    getThree(hashList)
  end

  def hash_input(str) do
    hash = :crypto.hash(:md5, str)
      |>:binary.bin_to_list

    %Identicon.Image{hex: hash}
  end

  def getThree(list) do
    Enum.take(list, 3)
  end
end
