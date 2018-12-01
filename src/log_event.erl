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

-compile(export_all).
-define(SERVER, ?MODULE).

-record(state, {}).

start_link() ->
  {ok, Pid} = gen_event:start_link({local, ?MODULE}),
  gen_event:add_handler(?SERVER, ?MODULE, []), {ok, Pid}.

init([]) ->
  error_logger:logfile({open, "log.txt"}),
  {ok, #state{}}.

handle_event({windSend}, State) -> error_logger:info_msg("Sending wind to tree ~n", []), {ok, State};
handle_event({windReceived}, State) -> error_logger:info_msg("Received wind from tree ~n", []), {ok, State};
handle_event({leavesSend}, State) -> error_logger:info_msg("Sending leaves to street ~n", []), {ok, State};
handle_event({leavesReceived}, State) -> error_logger:info_msg("Recived leaves from street ~n", []), {ok, State};
handle_event({fanticReceived}, State) -> error_logger:info_msg("Received fantic from student ~n", []), {ok, State};
handle_event({cleanSend}, State) -> error_logger:info_msg("Send clean to street ~n", []), {ok, State};
handle_event({cleanReceived}, State) -> error_logger:info_msg("Received clean from janitor ~n", []), {ok, State};
handle_event({isCleanSend}, State) -> error_logger:info_msg("Send isClean to street ~n", []), {ok, State};
handle_event({noReceived}, State) -> error_logger:info_msg("Received no from street ~n", []), {ok, State};
handle_event({yesReceived}, State) -> error_logger:info_msg("Received yes from street ~n", []), {ok, State};
handle_event({fanticSend}, State) -> error_logger:info_msg("Send fantic to street ~n", []), {ok, State};
handle_event({gotNothing}, State) -> error_logger:info_msg("Got nothing from policeman~n", []), {ok, State};
handle_event({isFanticSend}, State) -> error_logger:info_msg("Send isFantic to street~n", []), {ok, State};
handle_event({sendPenalty}, State) -> error_logger:info_msg("Send penalty to student~n", []), {ok, State};
handle_event({penaltyReceived}, State) -> error_logger:info_msg("Received penalty from police~n", []), {ok, State};
handle_event({fakePolice}, State) -> error_logger:info_msg("Fake police... doing nothing!~n", []), {ok, State};
handle_event({code_change, Version}, State) ->
  error_logger:info_msg("User changes the code of the server to aversion =~p~n", [Version]), {ok, State};
handle_event(_Event, State) -> {ok, State}.

handle_call(_Request, State) ->
  {ok, State}.

terminate(_Arg, _State) ->
  error_logger:logfile(close),
  ok.


