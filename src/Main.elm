port module Main exposing (..)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser)


type alias Flags =
    { storedToken : Maybe String }


type Token
    = Token String


type alias Model =
    { token : Maybe Token, navigationKey : Key }


type Msg
    = NoOp


type Route
    = Signin String
    | NotFound



-- functions --


routeParser : Parser (Route -> a) a
routeParser =
    Parser.oneOf
        [ Parser.map Signin (Parser.s "signin" </> Parser.string)
        ]


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    let
        parsedUrl =
            Maybe.withDefault NotFound (Parser.parse routeParser url)

        _ =
            Debug.log "flags" flags

        token =
            case parsedUrl of
                Signin githubToken ->
                    Just (Token githubToken)

                _ ->
                    Maybe.map Token flags.storedToken

        newModel =
            { token = token
            , navigationKey = key
            }

        commands =
            case token of
                Just (Token tok) ->
                    sendTokenToStorage tok

                Nothing ->
                    Cmd.none

        _ =
            Debug.log "newModel" newModel
    in
    ( newModel, commands )



-- VIEW --


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



-- UPDATE --


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



---- PROGRAM ----
-- main : Program () Model Msg


main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = onUrlRequest
        , onUrlChange = onUrlChange
        }


port sendTokenToStorage : String -> Cmd msg
