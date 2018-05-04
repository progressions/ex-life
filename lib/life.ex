defmodule Life do
  @moduledoc """
  Documentation for Life.
  """

  @doc """
  Hello world.

  """
  def neighbors(board, {col, row}) do
    Enum.reduce((col - 1)..(col + 1), [], fn c, acc ->
      acc ++
        Enum.reduce((row - 1)..(row + 1), [], fn r, acc ->
          [{c, r} | acc]
        end)
    end)
  end

  def live_neighbors(board, {col, row}) do
    neighbors(board, {col, row})
    |> Enum.filter(fn {c, r} ->
      {c, r} != {col, row} && alive?(board, {c, r})
    end)
  end

  def count_live_neighbors(board, {col, row}) do
    live_neighbors(board, {col, row})
    |> length
  end

  def alive?(board, {col, row}), do: Enum.member?(board, {col, row})

  def will_live?(board, {col, row}) do
    count = count_live_neighbors(board, {col, row})
    (alive?(board, {col, row}) && (count == 2 || count == 3)) || count == 3
  end

  def advance(board) do
    board
    |> Enum.flat_map(fn {col, row} ->
      neighbors(board, {col, row})
      |> Enum.filter(fn {col, row} ->
        will_live?(board, {col, row})
      end)
    end)
    |> Enum.uniq
  end
end
