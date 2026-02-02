-module(kv_store).
-export([start/0, put/2, get/1, delete/1]).

%% Start the key-value store
start() ->
    register(kv_store, spawn(fun loop/0)).

%% Put a key-value pair
put(Key, Value) ->
    kv_store ! {put, Key, Value}.

%% Get a value by key
get(Key) ->
    kv_store ! {get, Key, self()},
    receive
        {ok, Value} -> Value;
        {error, not_found} -> not_found
    end.

%% Delete a key
delete(Key) ->
    kv_store ! {delete, Key}.

%% Internal loop to handle messages
loop() ->
    receive
        {put, Key, Value} ->
            put_data(Key, Value),
            loop();
        {get, Key, Caller} ->
            Caller ! {ok, get_data(Key)},
            loop();
        {delete, Key} ->
            delete_data(Key),
            loop()
    end.

%% Internal functions to manage data
put_data(Key, Value) ->
    ets:insert(kv_store, {Key, Value}).

get_data(Key) ->
    case ets:lookup(kv_store, Key) of
        [{_, Value}] -> Value;
        [] -> not_found
    end.

delete_data(Key) ->
    ets:delete(kv_store, Key).
