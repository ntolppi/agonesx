defmodule HelloAgones do
  # Our module is going to use the DSL (Domain Specific Language) for Gen(eric) Servers
  use GenServer

  # We need a factory method to create our server process
  # it takes a single parameter `port` which defaults to `2052`
  # This runs in the caller's context
  def start_link(port \\ 7654) do
    GenServer.start_link(__MODULE__, port) # Start 'er up
    |> IO.inspect(label: "start_link/1")
  end

  # Initialization that runs in the server context (inside the server process right after it boots)
  def init(port) do
    # Use erlang's `gen_udp` module to open a socket
    # With options:
    #   - binary: request that data be returned as a `String`
    #   - active: gen_udp will handle data reception, and send us a message `{:udp, socket, address, port, data}` when new data arrives on the socket
    # Returns: {:ok, socket}
    {:ok, _socket} = :gen_udp.open(port, [:binary, active: true])
    |> IO.inspect(label: "init/0")
  end

  # define a callback handler for when gen_udp sends us a UDP packet
  def handle_info({:udp, socket, address, port, data}, _state) do
    # punt the data to a new function that will do pattern matching
    IO.puts("#{address |> Tuple.to_list |> Enum.join(".")} #{port}")
    handle_packet(data, socket)
    send_response(socket, address, port, data)
  end

  ### ALERT: you may not want to support the quit message in a production UDP server ###
  # pattern match the "quit" message
  defp handle_packet("quit\n", socket) do
    IO.puts("Received: quit. Closing down...")

    # close the socket
    :gen_udp.close(socket)

    # GenServer will understand this to mean we want to stop the server
    # action: :stop
    # reason: :normal
    # new_state: nil, it doesn't matter since we're shutting down :(
    {:stop, :normal, nil}
  end

  # fallback pattern match to handle all other (non-"quit") messages
  defp handle_packet(data, socket) do
    # print the message
    IO.puts("Received: #{String.trim data}")

    # IRL: do something more interesting...

    # GenServer will understand this to mean "continue waiting for the next message"
    # parameters:
    # :noreply - no reply is needed
    # new_state: keep the socket as the current state
    {:noreply, socket}
  end

  defp send_response(socket, address, port, data) do
    IO.puts "Sending #{String.trim data}"
    :gen_udp.send(socket, address, port, "Echo: #{data}")
    {:noreply, socket}
  end
end
