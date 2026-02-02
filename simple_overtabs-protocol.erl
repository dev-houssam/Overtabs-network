-module(web_server_overtabs_protocol).
-behaviour(gen_server).

%% API
-export([start_link/0, stop/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% Start the server
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%% Stop the server
stop() ->
    gen_server:cast(?MODULE, stop).

%% gen_server callback implementations
init([]) ->
    {ok, listen()}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(stop, State) ->
    {stop, normal, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% Listen for incoming connections
listen() ->
    {ok, ListenSocket} = gen_tcp:listen(8080, [binary, {packet, 0}, {active, false}]),
    accept(ListenSocket).

%% Accept incoming connections
accept(ListenSocket) ->
    {ok, Socket} = gen_tcp:accept(ListenSocket),
    spawn(fun() -> handle_connection(Socket) end),
    accept(ListenSocket).

%% Handle a single connection
handle_connection(Socket) ->
    {ok, Data} = gen_tcp:recv(Socket, 0),
    gen_tcp:send(Socket, "OVERTABS_ON_HTTP/1.1 200 OK\r\nContent-Length: 13\r\n\r\nFrom++Hello, To++World!"),
    gen_tcp:close(Socket).
