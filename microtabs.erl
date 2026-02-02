-module(microtabs).
-behaviour(gen_server).

%% API
-export([start_link/0, call_service/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% Start the microtabs
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%% Call the microtabs
call_service(Request) ->
    gen_server:call(?MODULE, {call, Request}).

%% gen_server callback implementations
init([]) ->
    {ok, []}.

handle_call({call, Request}, _From, State) ->
    %% Process request here
    {reply, {ok, process_request(Request)}, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% Process a request
process_request(Request) ->
    %% Simulate processing
    io:format("Processing request: ~p~n", [Request]),
    ok.
