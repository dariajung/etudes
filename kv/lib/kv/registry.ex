defmodule KV.Registry do
    use GenServer

    ### Client API

    @doc """
    Starts registry.
    """
    def start_link(opts \\ []) do
        GenServer.start_link(__MODULE__, :ok, opts)
    end

    @doc """
    Looks up bucket PID for `name` stored in `server`.

    Returns `{:ok, pid}` if bucket exists, `:error` otherwise.
    """
    def lookup(server, name) do
        GenServer.call(server, {:lookup, name})
    end

    @doc """
    Ensures that there is a bucket associated to the given
    `name` in the `server`.
    """

    def create(server, name) do
        GenServer.cast(server, {:create, name})
    end

    ### Server Callbacks

    def init(:ok) do 
        {:ok, HashDict.new}
    end

    def handle_call({:lookup, name}, _from, names) do
        {:reply, HashDict.fetch(names, name), names}
    end

    def handle_cast({:create, name}, names) do 
        if HashDict.get(names, name) do 
            {:noreply, names}
        else
            {:ok, bucket} = KV.Bucket.start_link()
            {:noreply, HashDict.put(names, name, bucket)}
        end
    end

end