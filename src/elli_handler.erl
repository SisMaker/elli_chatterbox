-module(elli_handler).

-export([handle/2,
         handle_event/3]).

-include_lib("elli_chatterbox/include/elli_chatterbox.hrl").
-include_lib("elli/include/elli.hrl").

handle(#req{method = Method,
            path = Path,
            args = Args,
            raw_path = RawPath,
            version = Version,
            headers = Headers,
            body = Body,
            socket = Socket}, [Handler]) ->
    Req = #ec_req{method = Method,
                  path = Path,
                  args = Args,
                  raw_path = RawPath,
                  version = Version,
                  headers = Headers,
                  body = Body,
                  socket = Socket},
    {ok, Status, RespHeaders, RespBody} = Handler:handle(erlang:atom_to_binary(Method, latin1), Path, Req),
    {Status, RespHeaders, RespBody}.

handle_event(_, _, _) -> ok.
