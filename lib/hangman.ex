defmodule Hangman do
  @moduledoc """
  API Interface for the Hangman game.
  """
  alias Hangman.Game

  defdelegate new_game(), to: Game
end
