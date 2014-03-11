defmodule Emanatio.Stream do

  alias Emanatio.Stream.Actor

  defrecord EventSource, pid: nil

  def new do
    {:ok, pid} = Actor.start
    EventSource.new(pid: pid)
  end

  def get EventSource[pid: pid] = e do
    {Actor.get(pid), e}
  end

  def push EventSource[pid: pid] = e, value do
    Actor.push(pid, value)
    e
  end

  def foreach(EventSource[pid: pid] = e, f)
  when is_function(f, 1) do
    :ok = Actor.foreach(pid, f)
    e
  end

end


defmodule Emanatio.Stream.Actor do

  use ExActor.GenServer

  defrecord State, value: nil,
                   foreach: nil

  definit do: initial_state(State.new)

  defcast push(value), state: s do
    value |> s.value |> notify |> new_state
  end

  defcall get, state: s, do: reply(s.value)

  defcall foreach(f), state: s, when: is_function(f, 1),
  do: f |> s.foreach |> set_and_reply :ok

  defp notify(State[foreach: nil] = s), do: s
  defp notify(State[value: v, foreach: f] = s) do
    f.(v)
    s
  end

end