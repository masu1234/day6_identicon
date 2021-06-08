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
    grid = Enum.filter(list, &rem(elem(&1, 0), 2) == 0)
    %Identicon.Image{grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
          Enum.map(grid, fn({_code, index}) ->
            # {top_left, bottom_right} =
              {{rem(index,5)*50, div(index, 5)*50},{rem(index,5)*50+50, div(index, 5)*50+50}}
          end)
    %Identicon.Image{image | pixel_map: pixel_map }
    end

    def build_image(color, pixel_map) do
      # %Identicon.Image{color: color, pixel_map: pixel_map}
      img = :egd.create(250, 250)
      fill = :egd.color(color)
      Enum.each pixel_map, fn({start, stop}) ->
        :egd.filledRectangle(img, start, stop, fill)
      end
      :egd.render(img)
    end
end
