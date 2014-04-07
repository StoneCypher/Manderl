
-module(manderl_tests).

-compile(export_all).

-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").





start_test_() ->

    { "Start tests", [ 
        { "starts correctly", ?_assert(ok =:= manderl:start()) }
    ] }.