%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Нояб. 2018 22:13
%%%-------------------------------------------------------------------
-module(factorial).
-author("Макс").

%% API
-export([factorial/1]).

factorial(N) ->
  gen_event:notify(log_event, {calculate, N}),
  factor(N).
factor(0) -> 1;
factor(N) -> N * factor(N - 1).
