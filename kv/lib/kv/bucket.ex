defmodule KV.Bucket do

    def start_link do 
        Agent.start_link(fn -> HashDict.new end)
    end

    def get(key, bucket) do
        Agent.get(bucket, &HashDict.get(&1, key))
    end

    def put(key, value, bucket) do
        Agent.update(bucket, &HashDict.put(&1, key, value))
    end
end