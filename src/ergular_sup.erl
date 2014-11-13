-module(ergular_sup).
-behaviour(supervisor).

-export([start_link/1]).
-export([init/1]).

start_link(Dispatch) ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, [Dispatch]).

init([Dispatch]) ->
	Procs = [{cowboy,{cowboy,start_http,[http, 100, [{port, 8080}], 
                     [{env, [{dispatch, Dispatch}]}]]},
              permanent,5000,worker,[cowboy]}],
	{ok, {{one_for_one, 1, 5}, Procs}}.
