
-module(manderl).





-export([

    start/0,
    endpoint/1

]).





start() ->

    inets:start(),
    ssl:start(),
    ok.





endpoint(X) ->

    endpoint(X, json).





endpoint(X, json) when is_list(X) ->

    "https://mandrillapp.com/api/1.0/" ++ X ++ ".json".
