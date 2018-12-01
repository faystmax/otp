%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Нояб. 2018 21:38
%%%-------------------------------------------------------------------
-module(street).
-author("Макс").

-behaviour(gen_server).
-compile(export_all).
-define(SERVER, ?MODULE).
-record(state, {leaves, fantic}).

start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.


%%%----------------------------Main Logic---------------------------------------

init([]) ->
  {ok, #state{leaves = no, fantic = no}}.

handle_cast({fantic}, State) ->
  gen_event:notify(log_event, {fanticReceived}),
  NewState = State#state{fantic = yes},
  {noreply, NewState};
handle_cast({leaves}, State) ->
  gen_event:notify(log_event, {leavesReceived}),
  NewState = State#state{leaves = yes},
  {noreply, NewState};
handle_cast({clean}, State) ->
  gen_event:notify(log_event, {cleanReceived}),
  NewState = State#state{leaves = no, fantic = no},
  {noreply, NewState}.

handle_call({isFantic}, _From, State) ->
  {reply, isFantic(State), State};
handle_call({isClean}, _From, State) ->
  {reply, isClean(State), State}.


isClean(#state{leaves = no, fantic = no}) -> yes;
isClean(_State) -> no.


isFantic(#state{fantic = no}) -> no;
isFantic(_State) -> yes.