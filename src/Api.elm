module Api exposing (..)

import Http
import HttpBuilder
import Json.Decode as D exposing (Decoder)
import Types exposing (..)


userInformationDecoder : Decoder String
userInformationDecoder =
    D.succeed "user information"


handleFetchUserRequest : Result Http.Error String -> Msg
handleFetchUserRequest result =
    NoOp



-- fetchUserInformation : Token -> Cmd Msg


fetchUserInformation (Token token) =
    HttpBuilder.get "http://localhost:3500/api/user/"
        |> HttpBuilder.withHeader "Authorization" ("Bearer " ++ token)
        -- |> HttpBuilder.withExpect userInformationDecoder
        -- |> handleFetchUserRequest
        |> HttpBuilder.request
