%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Нояб. 2018 21:38
%%%-------------------------------------------------------------------
-module(janitor).
-author("Макс").

-behaviour(gen_server).
-compile(export_all).
-define(SERVER, ?MODULE).
-record(state, {}).

-define(INTERVAL, 5000).

start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

handle_cast(_Request, State) ->
  {noreply, State}.

handle_call(_Request, _From, State) ->
  {reply, ok, State}.


%%%----------------------------Main Logic---------------------------------------
init([]) ->
  set_timer(),
  {ok, #state{}}.

handle_info(checkClean, State) ->
  gen_event:notify(log_event, {isCleanSend}),
  parseAnswer(gen_server:call(street, {isClean})),
  set_timer(),
  {noreply, State}.

parseAnswer(no) ->
  gen_event:notify(log_event, {noReceived}),
  gen_server:cast(street, {clean});
parseAnswer(yes) ->
  gen_event:notify(log_event, {yesReceived}),
  wait.

set_timer() -> erlang:send_after(?INTERVAL, self(), checkClean).






