%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Нояб. 2018 22:19
%%%-------------------------------------------------------------------
{application, app, [
  {description, "otpLab"},
  {vsn, "1.0"},
  {modules, [app, main_supervisor, log_event, tree, wind, street, janitor, student, police]},
  {registered, [tree, main_supervisor, log_event, tree, wind, street, janitor, student, police]},
  {applications, [kernel, stdlib]},
  {mod, {app, []}},
  {env, []},
  {start_phases, []}
]}.