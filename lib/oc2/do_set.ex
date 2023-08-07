defmodule Openc2.Oc2.DoSet do
  require Logger

  alias Openc2.Oc2.Command

  @colors ["violet", "indigo", "blue", "green", "yellow", "orange", "red"]

  @topic "leds"

  @doc """
  do_cmd executes the action
  matching on action/target
  end
  """
  def do_cmd(%Command{error?: true} = command) do
    ## something went wrong upstream, pass along
    command
  end

  def do_cmd(%Command{action: action}) when action != "set" do
    ## should always be action=set
    Command.return_error("wrong action in command")
  end

  def do_cmd(%Command{target_specifier: color, target: "led"} = command) do
    set_color(color, command)
  end

  def do_cmd(command) do
    ## should not have gotten here
    Logger.debug("do_cmd #{inspect(command)}")
    Command.return_error("invalid action/target or target/specifier pair")
  end

  defp set_color("rainbow", command) do
    %Command{command | response: %{status: 200}}
  end

  defp set_color("off", command) do
    %Command{command | response: %{status: 200}}
  end

  defp set_color("on", command) do
    %Command{command | response: %{status: 200}}
  end

  defp set_color(color, command) do
    if color in @colors do
      %Command{command | response: %{status: 200}}
    else
      Command.return_error("invalid color")
    end
  end
end
