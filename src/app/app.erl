%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Нояб. 2018 21:17
%%%-------------------------------------------------------------------
-module(app).
-author("Макс").

-behaviour(application).

-compile(export_all).

start(_StartType, _StartArgs) ->
  case main_supervisor:start_link() of
    {ok, Pid} ->
      {ok, Pid};
    Error ->
      Error
  end.

stop(_State) ->
  ok.

%%  start App
%%  application:start(app).

%%  code change
%%  sys:suspend(police).
%%  code:purge(police).
%%  code:load_file(police).
%%  sys:change_code(police, police, "1.0", parsePoliceBribe).
%%  sys:resume(police).

