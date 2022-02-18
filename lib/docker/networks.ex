defmodule Docker.Networks do
  @base_uri "/networks"

  @doc """
  List all existing networks.
  """
  def list do
    "#{@base_uri}/" |> Docker.Client.get
  end

  @doc """
  Inspect a network by ID.
  """
  def inspect(id) do
    "#{@base_uri}/#{id}" |> Docker.Client.get
  end

  @doc """
  Remove a network.
  """
  def remove(id) do
    "#{@base_uri}/#{id}" |> Docker.Client.delete
  end

  @doc """
  Create a network. "Name" is required in conf
  """
  def create(conf) do
    "#{@base_uri}/create" |> Docker.Client.post(conf)
  end

  @doc """
  Connect a container to a network.
  """
  def connect(id, container, conf) do
    Docker.Client.post(
      "#{@base_uri}/#{id}/connect",
      %{
        "Container" => container,
        "EndpointConfig" => conf
      })
  end

  @doc """
  Disconnect a container to a network.
  """
  def disconnect(id, container, force = false) do
    Docker.Client.post(
      "#{@base_uri}/#{id}/connect",
      %{
        "Container" => container,
        "Force" => force
      })
  end

  @doc """
  Delete unused networks.
  """
  def prune do
    "#{@base_uri}/prune" |> Docker.Client.post
  end
end
