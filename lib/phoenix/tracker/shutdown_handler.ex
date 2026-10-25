defmodule Phoenix.Tracker.ShutdownHandler do
  @moduledoc false
  use GenServer

  def start_link(tracker_name) do
    GenServer.start_link(__MODULE__, tracker_name, name: __MODULE__)
  end

  @impl GenServer
  def init(tracker_name) do
    Process.flag(:trap_exit, true)
    {:ok, tracker_name}
  end

  @impl GenServer
  def terminate(_reason, tracker_name) do
    Phoenix.Tracker.graceful_permdown(tracker_name)
    :ok
  end
end
