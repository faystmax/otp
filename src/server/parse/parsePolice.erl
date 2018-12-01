%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. Дек. 2018 1:26
%%%-------------------------------------------------------------------
-module(parsePolice).
-author("Макс").

-compile(export_all).

parse(yes) ->
  gen_event:notify(log_event, {yesReceived}),
  gen_event:notify(log_event, {sendPenalty}),
  gen_server:cast(student, {penalty});
parse(no) ->
  gen_event:notify(log_event, {noReceived}).
