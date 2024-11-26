defmodule HelloAgones.ListenerSup do
  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args)
  end

  @impl true
  def init({}) do
    children = [
      {HelloAgones.Listeners.Echo, [{:port, 7654}]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
