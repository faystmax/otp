%%%-------------------------------------------------------------------
%%% @author Макс
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. Дек. 2018 1:27
%%%-------------------------------------------------------------------
-module(parsePoliceBribe).
-author("Макс").

-compile(export_all).

parse(_) ->
  gen_event:notify(log_event, {fakePolice}).