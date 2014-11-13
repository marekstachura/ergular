-module(ergular_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
                      {'_', [
                         {"/", cowboy_static,{priv_file,ergular, "index.html"}}
                        ]}
                     
                     ]),
	ergular_sup:start_link(Dispatch).

stop(_State) ->
	ok.
