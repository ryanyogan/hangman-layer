defmodule Hangman.Application do
  use Application

  @impl true
  def start(_type, _args) do
    options = [strategy: :one_for_one, name: Hangman.Supervisor]

    DynamicSupervisor.start_link(options)
  end
end
