
-module(manderl).





-export([

    start/0,

    endpoint/1,
      endpoint/2

]).





start() ->

    inets:start(),
    ssl:start(),
    ok.





endpoint(X) ->

    endpoint(X, json).





endpoint(X, xml) when is_list(X) ->

    "https://mandrillapp.com/api/1.0/" ++ X ++ ".xml";





endpoint(X, yaml) when is_list(X) ->

    "https://mandrillapp.com/api/1.0/" ++ X ++ ".yaml";





endpoint(X, json) when is_list(X) ->

    "https://mandrillapp.com/api/1.0/" ++ X ++ ".json".
