%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Нояб. 2018 22:19
%%%-------------------------------------------------------------------
{application, app, [
  {description, "test"},
  {vsn, "0.9"},
  {modules, [app, my_supervisor, factorial, server]},
  {registered, [server, my_supervisor]},
  {applications, [kernel, stdlib]},
  {mod, {app, []}},
  {env, []},
  {start_phases, []}
]}.