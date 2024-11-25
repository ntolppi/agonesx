defmodule Agonesx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @config_schema [
    health_interval: [
      type: :pos_integer
    ],
    grpc_options: [
      type: :keyword_list
    ]
  ]

  def start(_type, _args) do
    config =
      Application.get_all_env(:agonesx)
      |> NimbleOptions.validate!(@config_schema)

    client_opts =
      config
      |> Keyword.take([:grpc_options, :health_interval])
      |> Keyword.put(:watcher_supervisor, Agonesx.WatcherSupervisor)
      |> Keyword.put(:name, Agonesx.Client)

    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: Agonesx.WatcherSupervisor},
      {Agonesx.Client, client_opts}
    ]

    opts = [strategy: :one_for_one, name: Agonesx.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
