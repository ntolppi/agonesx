defmodule Agones.Dev.Sdk.Empty do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"
end

defmodule Agones.Dev.Sdk.KeyValue do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Agones.Dev.Sdk.Duration do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :seconds, 1, type: :int64
end

defmodule Agones.Dev.Sdk.GameServer.ObjectMeta.AnnotationsEntry do
  @moduledoc false

  use Protobuf, map: true, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Agones.Dev.Sdk.GameServer.ObjectMeta.LabelsEntry do
  @moduledoc false

  use Protobuf, map: true, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Agones.Dev.Sdk.GameServer.ObjectMeta do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :name, 1, type: :string
  field :namespace, 2, type: :string
  field :uid, 3, type: :string
  field :resource_version, 4, type: :string, json_name: "resourceVersion"
  field :generation, 5, type: :int64
  field :creation_timestamp, 6, type: :int64, json_name: "creationTimestamp"
  field :deletion_timestamp, 7, type: :int64, json_name: "deletionTimestamp"

  field :annotations, 8,
    repeated: true,
    type: Agones.Dev.Sdk.GameServer.ObjectMeta.AnnotationsEntry,
    map: true

  field :labels, 9,
    repeated: true,
    type: Agones.Dev.Sdk.GameServer.ObjectMeta.LabelsEntry,
    map: true
end

defmodule Agones.Dev.Sdk.GameServer.Spec.Health do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :disabled, 1, type: :bool, deprecated: false
  field :period_seconds, 2, type: :int32, json_name: "periodSeconds"
  field :failure_threshold, 3, type: :int32, json_name: "failureThreshold"
  field :initial_delay_seconds, 4, type: :int32, json_name: "initialDelaySeconds"
end

defmodule Agones.Dev.Sdk.GameServer.Spec do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :health, 1, type: Agones.Dev.Sdk.GameServer.Spec.Health
end

defmodule Agones.Dev.Sdk.GameServer.Status.Address do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :type, 1, type: :string
  field :address, 2, type: :string
end

defmodule Agones.Dev.Sdk.GameServer.Status.Port do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :name, 1, type: :string
  field :port, 2, type: :int32
end

defmodule Agones.Dev.Sdk.GameServer.Status.PlayerStatus do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :count, 1, type: :int64
  field :capacity, 2, type: :int64
  field :ids, 3, repeated: true, type: :string
end

defmodule Agones.Dev.Sdk.GameServer.Status.CounterStatus do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :count, 1, type: :int64
  field :capacity, 2, type: :int64
end

defmodule Agones.Dev.Sdk.GameServer.Status.ListStatus do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :capacity, 1, type: :int64
  field :values, 2, repeated: true, type: :string
end

defmodule Agones.Dev.Sdk.GameServer.Status.CountersEntry do
  @moduledoc false

  use Protobuf, map: true, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :key, 1, type: :string
  field :value, 2, type: Agones.Dev.Sdk.GameServer.Status.CounterStatus
end

defmodule Agones.Dev.Sdk.GameServer.Status.ListsEntry do
  @moduledoc false

  use Protobuf, map: true, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :key, 1, type: :string
  field :value, 2, type: Agones.Dev.Sdk.GameServer.Status.ListStatus
end

defmodule Agones.Dev.Sdk.GameServer.Status do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :state, 1, type: :string
  field :address, 2, type: :string
  field :addresses, 7, repeated: true, type: Agones.Dev.Sdk.GameServer.Status.Address
  field :ports, 3, repeated: true, type: Agones.Dev.Sdk.GameServer.Status.Port
  field :players, 4, type: Agones.Dev.Sdk.GameServer.Status.PlayerStatus

  field :counters, 5,
    repeated: true,
    type: Agones.Dev.Sdk.GameServer.Status.CountersEntry,
    map: true

  field :lists, 6, repeated: true, type: Agones.Dev.Sdk.GameServer.Status.ListsEntry, map: true
end

defmodule Agones.Dev.Sdk.GameServer do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :object_meta, 1, type: Agones.Dev.Sdk.GameServer.ObjectMeta, json_name: "objectMeta"
  field :spec, 2, type: Agones.Dev.Sdk.GameServer.Spec
  field :status, 3, type: Agones.Dev.Sdk.GameServer.Status
end

defmodule Agones.Dev.Sdk.SDK.Service do
  @moduledoc false

  use GRPC.Service, name: "agones.dev.sdk.SDK", protoc_gen_elixir_version: "0.13.0"

  rpc :Ready, Agones.Dev.Sdk.Empty, Agones.Dev.Sdk.Empty

  rpc :Allocate, Agones.Dev.Sdk.Empty, Agones.Dev.Sdk.Empty

  rpc :Shutdown, Agones.Dev.Sdk.Empty, Agones.Dev.Sdk.Empty

  rpc :Health, stream(Agones.Dev.Sdk.Empty), Agones.Dev.Sdk.Empty

  rpc :GetGameServer, Agones.Dev.Sdk.Empty, Agones.Dev.Sdk.GameServer

  rpc :WatchGameServer, Agones.Dev.Sdk.Empty, stream(Agones.Dev.Sdk.GameServer)

  rpc :SetLabel, Agones.Dev.Sdk.KeyValue, Agones.Dev.Sdk.Empty

  rpc :SetAnnotation, Agones.Dev.Sdk.KeyValue, Agones.Dev.Sdk.Empty

  rpc :Reserve, Agones.Dev.Sdk.Duration, Agones.Dev.Sdk.Empty
end

defmodule Agones.Dev.Sdk.SDK.Stub do
  @moduledoc false

  use GRPC.Stub, service: Agones.Dev.Sdk.SDK.Service
end