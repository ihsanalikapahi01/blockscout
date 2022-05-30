defmodule Explorer.Chain.Import.Stage.BlockFollowing do
  @moduledoc """
  Imports any tables that follows and cannot be imported at the same time as
  those imported by `Explorer.Chain.Import.Stage.Addresses`,
  `Explorer.Chain.Import.Stage.AddressReferencing`,
  `Explorer.Chain.Import.Stage.BlockReferencing` and
  `Explorer.Chain.Import.Stage.BlockTransactionTokenReferencing`.
  """

  alias Explorer.Chain.Import.{Runner, Stage}

  @behaviour Stage

  @impl Stage
  def runners,
    do: [
      Runner.Block.SecondDegreeRelations,
      Runner.Block.Rewards,
      Runner.Address.CurrentTokenBalances
    ]

  @impl Stage
  def multis(runner_to_changes_list, options) do
    Stage.split_multis(runners(), runner_to_changes_list, options)
  end
end
