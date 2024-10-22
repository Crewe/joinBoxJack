defmodule JoinBoxJack.Players.Player do
  @doc """
  A Player, able to join and create lobbies
  """
  defstruct [:id, :name]
  @type t :: %__MODULE__{id: String.t(), name: String.t()}
end
