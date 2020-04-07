module Main exposing (..)

import Browser
import Html exposing (Html, button, div, img, span, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, field, string)



---- MODEL ----


type HttpRequestStatus
    = Failure
    | Loading
    | Success


type alias Model =
    { pokemonId : Int
    , pokemonSpriteUrl : String
    , requestStatus : HttpRequestStatus
    }


init : ( Model, Cmd Msg )
init =
    ( { pokemonId = 1, pokemonSpriteUrl = "", requestStatus = Loading }, getPokemon 1 )



---- UPDATE ----


type Msg
    = IncrementId
    | DecrementId
    | GotPokemon (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        IncrementId ->
            ( { pokemonId = model.pokemonId + 1
              , pokemonSpriteUrl = model.pokemonSpriteUrl
              , requestStatus = Loading
              }
            , getPokemon (model.pokemonId + 1)
            )

        DecrementId ->
            if model.pokemonId == 1 then
                ( { pokemonId = model.pokemonId, pokemonSpriteUrl = model.pokemonSpriteUrl, requestStatus = Loading }, getPokemon model.pokemonId )

            else
                ( { pokemonId = model.pokemonId - 1, pokemonSpriteUrl = model.pokemonSpriteUrl, requestStatus = Loading }, getPokemon (model.pokemonId - 1) )

        GotPokemon result ->
            case result of
                Ok url ->
                    ( { pokemonId = model.pokemonId, pokemonSpriteUrl = url, requestStatus = Success }, Cmd.none )

                Err _ ->
                    ( { pokemonId = model.pokemonId, pokemonSpriteUrl = "", requestStatus = Failure }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.requestStatus of
        Failure ->
            div []
                [ div []
                    [ button [ onClick DecrementId ] [ text "-" ]
                    , span [] [ text <| String.fromInt model.pokemonId ]
                    , button [ onClick IncrementId ] [ text "+" ]
                    ]
                , div []
                    [ span [] [ text "Error retrieving sprite url..." ]
                    ]
                ]

        Loading ->
            div []
                [ div []
                    [ button [ onClick DecrementId ] [ text "-" ]
                    , span [] [ text <| String.fromInt model.pokemonId ]
                    , button [ onClick IncrementId ] [ text "+" ]
                    ]
                , div [] []
                ]

        Success ->
            div []
                [ div []
                    [ button [ onClick DecrementId ] [ text "-" ]
                    , span [] [ text <| String.fromInt model.pokemonId ]
                    , button [ onClick IncrementId ] [ text "+" ]
                    ]
                , div []
                    [ img [ src model.pokemonSpriteUrl ] []
                    ]
                ]



-- Http


getPokemon : Int -> Cmd Msg
getPokemon pokemonId =
    Http.get
        { url = "https://pokeapi.co/api/v2/pokemon/" ++ String.fromInt pokemonId
        , expect = Http.expectJson GotPokemon pokemonDecoder
        }


pokemonDecoder : Decoder String
pokemonDecoder =
    field "sprites" (field "front_default" string)



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
