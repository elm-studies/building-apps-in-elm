module Main exposing (..)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Url exposing (Url)



---- MODEL ----


type alias Flags =
    {}


type Token
    = Token String


type alias Model =
    { token : Maybe Token, navigationKey : Key }


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    let
        token =
            String.split "/" url.path
                |> List.reverse
                |> List.head
                |> Maybe.map Token

        newModel =
            { token = token
            , navigationKey = key
            }

        _ =
            Debug.log "log: " <| newModel
    in
    ( newModel, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp



---- VIEW ----


view : Model -> Document Msg
view model =
    { title = "Distinctly Average"
    , body = [ div [] [ text "hello world" ] ]
    }


onUrlRequest : UrlRequest -> Msg
onUrlRequest urlRequest =
    NoOp


onUrlChange : Url -> Msg
onUrlChange url =
    NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



---- PROGRAM ----
--main : Program () Model Msg


main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = onUrlRequest
        , onUrlChange = onUrlChange
        }
