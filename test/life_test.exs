defmodule LifeTest do
  use ExUnit.Case
  doctest Life

  test "gets neighbors" do
    board = [
      {1, 1},
      {2, 2},
      {3, 1}
    ]

    assert Life.neighbors(board, {2, 1}) == [
             {1, 2},
             {1, 1},
             {1, 0},
             {2, 2},
             {2, 1},
             {2, 0},
             {3, 2},
             {3, 1},
             {3, 0}
           ]
  end

  test "gets live neighbors" do
    board = [
      {1, 1},
      {2, 2},
      {3, 1}
    ]

    assert Life.live_neighbors(board, {2, 1}) == [
             {1, 1},
             {2, 2},
             {3, 1}
           ]
  end

  test "counts live neighbors" do
    board = [
      {1, 1},
      {2, 1},
      {2, 2},
      {3, 1}
    ]

    assert Life.count_live_neighbors(board, {2, 1}) == 3
  end

  test "live cell dies from underpopulation" do
    board = [
      {1, 1},
      {2, 2},
      {3, 1}
    ]

    assert Life.will_live?(board, {1, 1}) == false
  end

  test "live cell lives to the next generation" do
    board = [
      {1, 1},
      {2, 1},
      {2, 2},
      {3, 1}
    ]

    assert Life.will_live?(board, {2, 1}) == true
  end

  test "live cell dies from overpopulation" do
    board = [
      {2, 0},
      {1, 1},
      {2, 1},
      {2, 2},
      {3, 1}
    ]

    assert Life.will_live?(board, {2, 1}) == false
  end

  test "advances to the next state" do
    board = [
      {1, 1},
      {2, 2},
      {3, 1}
    ]

    assert Life.advance(board) == [{2, 2}, {2, 1}]
  end

  test "makes a spinner" do
    board = [
      {1, 2},
      {1, 1},
      {1, 0}
    ]

    result = Life.advance(board)

    assert result == [
             {0, 1},
             {1, 1},
             {2, 1}
           ]

    assert Life.advance(result) == board

    result =
      Life.advance(board)
      |> Life.advance()
      |> Life.advance()
      |> Life.advance()

    assert result == board
  end

  test "a block is stable" do
    board = [{1, 2}, {1, 1}, {2, 2}, {2, 1}]

    assert Life.advance(board) == board
  end

  test "a glider" do
    board = [
      {0, 2},
      {1, 0},
      {1, 2},
      {2, 1},
      {2, 2}
    ]

    assert Life.advance(board) == [{0, 1}, {1, 3}, {1, 2}, {2, 1}, {2, 2}]
    assert Life.advance(board) |> Life.advance() == [{0, 2}, {1, 3}, {2, 3}, {2, 2}, {2, 1}]
  end
end
