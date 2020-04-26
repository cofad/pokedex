module Main exposing (..)

import Browser
import Html exposing (Html, button, div, img, span, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, field, string)
import String.Extra exposing (toTitleCase)



---- MODEL ----


type HttpRequestStatus
    = Failure
    | Loading
    | Success


type alias Pokemon =
    { id : Int
    , name : String
    , weight : Int
    , spriteUrl : String
    }


type alias Model =
    { pokemon : Pokemon
    , pokemonRequestId : Int
    , requestStatus : HttpRequestStatus
    , version : String
    }


init : String -> ( Model, Cmd Msg )
init version =
    ( { pokemon = Pokemon 0 "" 0 ""
      , pokemonRequestId = 1
      , requestStatus = Loading
      , version = version
      }
    , getPokemon 1
    )



---- UPDATE ----


type Msg
    = IncrementId
    | DecrementId
    | GotPokemon (Result Http.Error Pokemon)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        IncrementId ->
            ( { pokemon = model.pokemon
              , pokemonRequestId = model.pokemonRequestId + 1
              , requestStatus = Loading
              , version = model.version
              }
            , getPokemon (model.pokemonRequestId + 1)
            )

        DecrementId ->
            if model.pokemonRequestId == 1 then
                ( { pokemon = model.pokemon
                  , pokemonRequestId = model.pokemonRequestId
                  , requestStatus = Loading
                  , version = model.version
                  }
                , getPokemon model.pokemonRequestId
                )

            else
                ( { pokemon = model.pokemon
                  , pokemonRequestId = model.pokemonRequestId - 1
                  , requestStatus = Loading
                  , version = model.version
                  }
                , getPokemon (model.pokemonRequestId - 1)
                )

        GotPokemon result ->
            case result of
                Ok pokemon ->
                    ( { pokemon = pokemon
                      , pokemonRequestId = model.pokemonRequestId
                      , requestStatus = Success
                      , version = model.version
                      }
                    , Cmd.none
                    )

                Err _ ->
                    ( { pokemon = model.pokemon
                      , pokemonRequestId = model.pokemonRequestId
                      , requestStatus = Failure
                      , version = model.version
                      }
                    , Cmd.none
                    )



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.requestStatus of
        Failure ->
            div [ class "app-container" ]
                [ div []
                    [ button [ onClick DecrementId ] [ text "-" ]
                    , button [ onClick IncrementId ] [ text "+" ]
                    ]
                , div []
                    [ span [] [ text "Error retrieving sprite url..." ]
                    ]
                , div [ class "version-container" ] [ text ("v" ++ model.version) ]
                ]

        Loading ->
            div [ class "app-container" ]
                [ div [ class "pokedex" ]
                    [ img [ src "./assets/pokedex.svg" ] []
                    , img [ src model.pokemon.spriteUrl, class "pokedex__pokemon-img" ] []
                    , div [ class "pokedex__pokemon-data" ]
                        [ div [] [ text ("Id = " ++ String.fromInt model.pokemon.id) ]
                        , div [] [ text ("Name = " ++ toTitleCase model.pokemon.name) ]
                        , div [] [ text <| ("Weight = " ++ String.fromInt model.pokemon.weight) ]
                        ]
                    , button [ onClick DecrementId, class "pokedex__btn-decrement" ] [ text "-" ]
                    , button [ onClick IncrementId, class "pokedex__btn-increment" ] [ text "+" ]
                    ]
                , div [ class "version-container" ] [ text ("v" ++ model.version) ]
                ]

        Success ->
            div [ class "app-container" ]
                [ div [ class "pokedex" ]
                    [ img [ src "./assets/pokedex.svg" ] []
                    , img [ src model.pokemon.spriteUrl, class "pokedex__pokemon-img" ] []
                    , div [ class "pokedex__pokemon-data" ]
                        [ div [] [ text ("Id = " ++ String.fromInt model.pokemon.id) ]
                        , div [] [ text ("Name = " ++ toTitleCase model.pokemon.name) ]
                        , div [] [ text <| ("Weight = " ++ String.fromInt model.pokemon.weight) ]
                        ]
                    , button [ onClick DecrementId, class "pokedex__btn-decrement" ] [ text "-" ]
                    , button [ onClick IncrementId, class "pokedex__btn-increment" ] [ text "+" ]
                    ]
                , div [ class "version-container" ] [ text ("v" ++ model.version) ]
                ]



-- Http


getPokemon : Int -> Cmd Msg
getPokemon pokemonRequestId =
    Http.get
        { url = "https://pokeapi.co/api/v2/pokemon/" ++ String.fromInt pokemonRequestId
        , expect = Http.expectJson GotPokemon pokemonDecoder
        }


pokemonDecoder : Decoder Pokemon
pokemonDecoder =
    Json.Decode.map4 Pokemon
        (field "id" Json.Decode.int)
        (field "name" string)
        (field "weight" Json.Decode.int)
        (field "sprites" (field "front_default" string))



---- PROGRAM ----


main : Program String Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
