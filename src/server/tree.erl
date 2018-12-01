%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Нояб. 2018 21:38
%%%-------------------------------------------------------------------
-module(tree).
-author("Макс").

-behaviour(gen_server).
-compile(export_all).
-define(SERVER, ?MODULE).
-record(state, {}).

start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init([]) ->
  {ok, #state{}}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

handle_call(_Request, _From, State) ->
  {reply, ok, State}.

%%%----------------------------Main Logic---------------------------------------

handle_cast({wind}, State) ->
  gen_event:notify(log_event, {windReceived}),
  gen_event:notify(log_event, {leavesSend}),
  gen_server:cast(street, {leaves}),
  {noreply, State}.



