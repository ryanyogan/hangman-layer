defmodule Hangman.Game do
  defstruct turns_left: 7,
            game_state: :initializing,
            letters: []

  def new_game() do
    %__MODULE__{
      letters: Dictionary.random_word() |> String.codepoints()
    }
  end
end
