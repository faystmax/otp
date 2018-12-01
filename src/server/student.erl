%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Нояб. 2018 21:38
%%%-------------------------------------------------------------------
-module(student).
-author("Макс").

-behaviour(gen_server).
-compile(export_all).
-define(SERVER, ?MODULE).
-record(state, {penalty}).

-define(INTERVAL, 5000).

start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

handle_call(_Request, _From, State) ->
  {reply, ok, State}.

%%%----------------------------Main Logic---------------------------------------

init([]) ->
  set_timer(),
  {ok, #state{penalty = no}}.

handle_info(sendPenalty, State = #state{penalty = no}) ->
  gen_event:notify(log_event, {gotNothing}),
  repeat(), {noreply, #state{penalty = no}};
handle_info(sendPenalty, State = #state{penalty = yes}) ->
  repeat(), {noreply, #state{penalty = no}}.

handle_cast({penalty}, _State) ->
  gen_event:notify(log_event, {penaltyReceived}),
  {noreply, #state{penalty = yes}}.

repeat() ->
  gen_event:notify(log_event, {fanticSend}),
  gen_server:cast(street, {fantic}),
  set_timer().

set_timer() -> erlang:send_after(?INTERVAL, self(), sendPenalty).

