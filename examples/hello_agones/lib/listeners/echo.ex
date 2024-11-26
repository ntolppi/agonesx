defmodule HelloAgones.Listeners.Echo do
  def child_spec(opts) do
    :ranch.child_spec(__MODULE__, :ranch_tcp, opts, HelloAgones.Protocols.Echo, [])
  end
end
