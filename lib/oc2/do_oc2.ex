defmodule Openc2.Oc2.DoOc2 do
  @moduledoc """
  `Openc2.Oc2.DoOc2` contains routines to execute the OpenC2 command,
  calling helper routines for the different OpenC2  commands
  (e.g. do_query for the OpenC2 'query' command )
  """

  require Logger

  alias Openc2.Oc2.Command

  @doc """
  do_cmd executes the action
  matching on action/target
  """
  def do_cmd(%Command{error?: true} = command) do
    ## upstream error, pass it on
    command
  end

  def do_cmd(%Command{action: "set"} = command) do
    Openc2.Oc2.DoSet.do_cmd(command)
  end

  def do_cmd(%Command{action: "query"} = command) do
    Openc2.Oc2.DoQuery.do_cmd(command)
  end

  def do_cmd(command) do
    # reached wo matching so error
    e1 = "no match on action/target pair: "
    e2 = inspect(command.action)
    e3 = inspect(command.target)
    error_msg = e1 <> e2 <> "" <> e3
    Command.return_error(error_msg)
  end
end
