
-module(manderl).





-export([

    start/0,

    endpoint/1,
      endpoint/2

]).





start() ->

    application:start(inets),
    application:start(crypto),
    application:start(public_key),
    application:start(ssl),

    ok.





endpoint(X) ->

    endpoint(X, json).





endpoint(X, xml) when is_list(X) ->

    "https://mandrillapp.com/api/1.0" ++ X ++ ".xml";





endpoint(X, yaml) when is_list(X) ->

    "https://mandrillapp.com/api/1.0" ++ X ++ ".yaml";





endpoint(X, php) when is_list(X) ->

    "https://mandrillapp.com/api/1.0" ++ X ++ ".php";





endpoint(X, json) when is_list(X) ->

    "https://mandrillapp.com/api/1.0" ++ X ++ ".json".





% todo move this to scutil?

htpost(Target, PostData) ->

    case httpc:request(post, Thing, Options, ) of
        
        {ok,{{_,RCode,_},_,Ret}} -> {RCode, Ret};
        Other                    -> {error, Other}

    end.
