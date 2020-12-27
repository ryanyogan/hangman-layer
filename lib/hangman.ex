defmodule Hangman do
  @moduledoc """
  API Interface for the Hangman game.
  """
  alias Hangman.Game

  defdelegate new_game(), to: Game
  defdelegate tally(game), to: Game

  defdelegate make_move(game, guess), to: Game
end
