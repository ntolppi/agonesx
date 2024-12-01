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

Generate Elixir code fro sdk.proto:
```bash
protoc -I ./googleapis -I ./allocation -I ./grpc-gateway -I ./agones --elixir_out=plugins=grpc:../lib ./agones/dev/sdk/sdk.proto
```
