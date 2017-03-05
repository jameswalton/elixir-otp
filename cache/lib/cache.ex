defmodule Cache do
  use GenServer

  @name Cache

  ## Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: @name])
  end

  def write(key, term) do
    GenServer.call(@name, {:write, key, term})
  end

  def read(key) do
    GenServer.call(@name, {:read, key})
  end

  def delete(key) do
    GenServer.cast(@name, {:delete, key})
  end

  def clear do
    GenServer.cast(@name, :clear)
  end

  def exists?(key) do
    GenServer.call(@name, {:exists?, key})
  end

  ## Server API
  def handle_call({:write, key, term}, _from, state) do
    new_state = Map.put(state, key, term)
    {:reply, :ok, new_state}
  end

  def handle_call({:read, key}, _from, state) do
    val = Map.get(state, key)
    {:reply, val, state}
  end

  def handle_call({:exists?, key}, _from, state) do
    exists? = Map.has_key?(state, key)
    {:reply, exists?, state}
  end

  def handle_cast({:delete, key}, state) do
    new_state = Map.delete(state, key)
    {:noreply, new_state}
  end

  def handle_cast(:clear) do
    {:noreply, %{}}
  end

  ## Callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  ## Helper functions
end
