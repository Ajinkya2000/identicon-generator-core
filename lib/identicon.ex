defmodule Identicon do
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  def pick_color(image) do
    %Identicon.Image{hex: hex_list} = image

    # Get first 3 values from the list
    [r, g, b | _tail] = hex_list

    # Create a new struct with all properties from above struct + color property
    %Identicon.Image{image | color: {r, g, b}}
  end

  def build_grid(image) do
    %Identicon.Image{hex: hex} = image

    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row

    row ++ [second, first]
  end

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end
end
