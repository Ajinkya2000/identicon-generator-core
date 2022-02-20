defmodule Identicon do
  def hash_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list()
  end

  def main(input) do
    input
    |> hash_input
  end
end
