%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 01. Дек. 2018 0:20
%%%-------------------------------------------------------------------
-module(log_event).
-author("Макс").

-behaviour(gen_event).

%% API
-export([start_link/0]).

%% gen_statem callbacks
-export([init/1,
  handle_event/2,
  terminate/2]).
-define(SERVER, ?MODULE).

-record(state, {}).

start_link() ->
  {ok, Pid} = gen_event:start_link({local, ?MODULE}),
  gen_event:add_handler(?SERVER, ?MODULE, []), {ok, Pid}.

init([]) ->
  error_logger:logfile({open, "log.txt"}),
  {ok, #state{}}.

handle_event({calculate, N}, State) ->
  error_logger:info_msg("user calculates factorial with n=~p~n", [N]),
  {ok, State};
handle_event(Event, State) ->
  {ok, State}.

terminate(_Arg, _State) ->
  error_logger:logfile(close),
  ok.
