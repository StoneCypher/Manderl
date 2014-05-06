
-module(manderl).





-export([

    start/0,

    endpoint/1,
      endpoint/2,

    htpost/2,

    post_proplist_to_string/1,

    to_kv_string/2,

    post_encode/1,

    rfc_1738_encode/1

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
% probably just switch to hackney or lhttpc

htpost(Target, [ {_Key,_Val} | _ ] = PostBody) ->

    htpost(Target, post_proplist_to_string(PostBody));





htpost(Target, PostBody) when is_list(PostBody) ->

    Options     = [],
    ContentType = "application/x-www-form-urlencoded",

    case httpc:request(post, {Target, Options, ContentType, PostBody}, [], []) of
        
        {ok,{{_,RCode,_},_,Ret}} -> {RCode, Ret};
        Other                    -> {error, Other}

    end.





post_proplist_to_string(PP) ->

    sc:implode("&", [ to_kv_string(K,V) || {K,V} <- PP ]).





to_kv_string(K,V) ->

    post_encode(K) ++ "=" ++ post_encode(V).





post_encode(X) when is_list(X) ->

    X.  % todo lol so wrong whargarbl





rfc_1738_encode(List) when is_list(List) -> 

    lists:flatten([ rfc_1738_encode(Ch) || Ch <- List ]);





rfc_1738_encode($")  -> "%22";
rfc_1738_encode($#)  -> "%23";
rfc_1738_encode($%)  -> "%25";

rfc_1738_encode($<)  -> "%3C";
rfc_1738_encode($>)  -> "%3E";

rfc_1738_encode($[)  -> "%5B";
rfc_1738_encode($\\) -> "%5C";
rfc_1738_encode($])  -> "%5D";
rfc_1738_encode($^)  -> "%5E";

rfc_1738_encode($`)  -> "%60";

rfc_1738_encode(${)  -> "%7B";
rfc_1738_encode($|)  -> "%7C";
rfc_1738_encode($})  -> "%7D";
rfc_1738_encode($~)  -> "%7E";





rfc_1738_encode(Ch) when Ch >= 16#20, Ch < 16#7F -> 

    Ch;





rfc_1738_encode(Ch) when is_integer(Ch) -> 

    "%" ++ sc:byte_to_hex(Ch).
