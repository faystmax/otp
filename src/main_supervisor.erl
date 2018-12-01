%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Нояб. 2018 21:19
%%%-------------------------------------------------------------------
-module(main_supervisor).
-author("Макс").

-behaviour(supervisor).

-compile(export_all).
-define(SERVER, ?MODULE).


start_link() ->
  supervisor:start_link({local, ?SERVER}, ?MODULE, []).


init([]) ->
  RestartStrategy = one_for_one,
  MaxRestarts = 10,
  MaxSecondsBetweenRestarts = 1,

  SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

  Restart = permanent,
  Shutdown = 2000,
  Type = worker,

  Wind = {wind, {wind, start_link, []}, Restart, Shutdown, Type, [wind]},
  Tree = {tree, {tree, start_link, []}, Restart, Shutdown, Type, [tree]},
  Street = {street, {street, start_link, []}, Restart, Shutdown, Type, [street]},
  Janitor = {janitor, {janitor, start_link, []}, Restart, Shutdown, Type, [janitor]},
  Student = {student, {student, start_link, []}, Restart, Shutdown, Type, [janitor]},
  Police = {police, {police, start_link, []}, Restart, Shutdown, Type, [police]},
  Logger = {log_event, {log_event, start_link, []}, Restart, Shutdown, Type, [log_event]},

  {ok, {SupFlags, [Logger, Street, Tree, Wind, Janitor, Student, Police]}}.
