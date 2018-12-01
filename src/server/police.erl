%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Нояб. 2018 21:38
%%%-------------------------------------------------------------------
-module(police).
-author("Макс").

-behaviour(gen_server).
-compile(export_all).
-define(SERVER, ?MODULE).
-record(state, {module}).

-define(INTERVAL, 4000).

start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

terminate(_Reason, _State) ->
  ok.

handle_call(_Request, _From, State) ->
  {reply, ok, State}.

handle_cast(_Request, State) ->
  {noreply, State}.

%%%----------------------------Main Logic---------------------------------------


init([]) ->
  set_timer(),
  {ok, #state{module = parsePolice}}.

handle_info(checkFantic, State) ->
  gen_event:notify(log_event, {isFanticSend}),
  Mod = State#state.module,
  Mod:parse(gen_server:call(street, {isFantic})),
  set_timer(),
  {noreply, State};
handle_info(_Info, State) ->
  {_Info, State}.

set_timer() -> erlang:send_after(?INTERVAL, self(), checkFantic).

code_change(OldVsn, _State, NewModule) ->
  gen_event:notify(log_event, {code_change, OldVsn}),
  {ok, #state{module = NewModule}}.

