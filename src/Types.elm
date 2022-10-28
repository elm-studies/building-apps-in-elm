module Types exposing (..)

import Browser.Navigation exposing (Key)


type Token
    = Token String


type alias Model =
    { token : Maybe Token, navigationKey : Key }


type Msg
    = NoOp
