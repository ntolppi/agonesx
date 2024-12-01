# Agonesx

This is the Elixir version of the Agones Game Server Client SDK.<br>
Fork of [shikanime/Agonex](https://github.com/shikanime/Agonex).

## Installation

```elixir
def deps do
  [
    {:agonesx, github: "ntolppi/agonesx"}
  ]
end
```

## Generate Protobuf

```bash
protoc -I=./proto/agones/dev/sdk/sdk.proto -I=./proto/allocation/allocation.proto -I=./proto/googleapis/google/api/annotations.proto -I=./proto/googleapis/google/api/client.proto -I=./proto/googleapis/google/api/field_behavior.proto -I=./proto/googleapis/google/api/http.proto -I=./proto/googleapis/google/api/launch_stage.proto -I=./proto/googleapis/google/api/resource.proto -I=./proto/grpc-gateway/protoc-gen-openapiv2/options/annotations.proto -I=./proto/grpc-gateway/protoc-gen-openapiv2/options/openapiv2.proto --elixir_out=plugins=grpc:./lib/agones/dev/sdk ./proto/agones/dev/sdk/sdk.proto
```
