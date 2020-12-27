defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "state is not changed for a :won and :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)

      assert {^game, _tally} = game |> Game.make_move("x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"b", :already_used},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")

    fun = fn {guess, state}, game ->
      {game, _tally} = Game.make_move(game, guess)
      assert game.game_state == state
      game
    end

    Enum.reduce(moves, game, fun)
  end

  test "bad guess is recognized" do
    {game, _tally} =
      Game.new_game("wibble")
      |> Game.make_move("x")

    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "exhausting all moves results in a loss" do
    moves = [
      {"a", :bad_guess},
      {"z", :bad_guess},
      {"c", :bad_guess},
      {"d", :bad_guess},
      {"t", :bad_guess},
      {"f", :bad_guess},
      {"r", :lost}
    ]

    game = Game.new_game("wibble")

    fun = fn {guess, state}, game ->
      {game, _tally} = Game.make_move(game, guess)
      assert game.game_state == state
      game
    end

    Enum.reduce(moves, game, fun)
  end
end
