
-module(manderl).





-export([
    start/0
]).





start() ->

    inets:start(),
    ssl:start(),
    ok.
