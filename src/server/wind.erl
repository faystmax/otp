%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Нояб. 2018 21:38
%%%-------------------------------------------------------------------
-module(wind).
-author("Макс").

-behaviour(gen_server).
-compile(export_all).
-define(SERVER, ?MODULE).
-record(state, {}).

-define(INTERVAL, 10000).

start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

handle_call(_Request, _From, State) ->
  {reply, ok, State}.

handle_cast(_Request, State) ->
  {noreply, State}.


%%%----------------------------Main Logic---------------------------------------

init([]) ->
  set_timer(),
  {ok, #state{}}.

handle_info(sendWind, State) ->
  gen_event:notify(log_event, {windSend}),
  gen_server:cast(tree, {wind}),
  set_timer(),
  {noreply, State}.

set_timer() -> erlang:send_after(?INTERVAL, self(), sendWind).


