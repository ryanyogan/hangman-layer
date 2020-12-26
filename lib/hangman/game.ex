defmodule Hangman.Game do
  defstruct turns_left: 7,
            game_state: :initializing,
            letters: [],
            used: MapSet.new()

  @doc """
  Game.new_game/0 will take a random word from the Dictionary
  module, create new game, and split the letters into the game's
  state.
  """
  def new_game() do
    new_game(Dictionary.random_word())
  end

  @doc """
  Game.new_game/1 makes testing easier as testing random
  anything is not a safe test.
  """
  def new_game(word) do
    %__MODULE__{
      letters: word |> String.codepoints()
    }
  end

  def make_move(%{game_state: state} = game, _guess) when state in [:won, :lost] do
    {game, tally(game)}
  end

  def make_move(game, guess) do
    game = accept_move(game, guess, MapSet.member?(game.used, guess))
    {game, tally(game)}
  end

  defp accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  defp accept_move(game, guess, _already_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _good_guess = true) do
    new_state =
      MapSet.new(game.letters)
      |> MapSet.subset?(game.used)
      |> maybe_won?()

    Map.put(game, :game_state, new_state)
  end

  defp score_guess(game, _bad_guess) do
    game
  end

  defp tally(_game) do
    123
  end

  defp maybe_won?(true), do: :won
  defp maybe_won?(_), do: :good_guess
end
