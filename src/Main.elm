module Main exposing (..)

import Browser
import Html exposing (Html, button, div, img, span, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, field, string)



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
    }


init : ( Model, Cmd Msg )
init =
    ( { pokemon = Pokemon 0 "" 0 ""
      , pokemonRequestId = 1
      , requestStatus = Loading
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
              }
            , getPokemon (model.pokemonRequestId + 1)
            )

        DecrementId ->
            if model.pokemonRequestId == 1 then
                ( { pokemon = model.pokemon
                  , pokemonRequestId = model.pokemonRequestId
                  , requestStatus = Loading
                  }
                , getPokemon model.pokemonRequestId
                )

            else
                ( { pokemon = model.pokemon
                  , pokemonRequestId = model.pokemonRequestId - 1
                  , requestStatus = Loading
                  }
                , getPokemon (model.pokemonRequestId - 1)
                )

        GotPokemon result ->
            case result of
                Ok pokemon ->
                    ( { pokemon = pokemon
                      , pokemonRequestId = model.pokemonRequestId
                      , requestStatus = Success
                      }
                    , Cmd.none
                    )

                Err _ ->
                    ( { pokemon = model.pokemon
                      , pokemonRequestId = model.pokemonRequestId
                      , requestStatus = Failure
                      }
                    , Cmd.none
                    )



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.requestStatus of
        Failure ->
            div []
                [ div []
                    [ button [ onClick DecrementId ] [ text "-" ]
                    , button [ onClick IncrementId ] [ text "+" ]
                    ]
                , div []
                    [ span [] [ text "Error retrieving sprite url..." ]
                    ]
                ]

        Loading ->
            div []
                [ div [ class "pokedex-container" ]
                    [ div [ class "pokedex" ]
                        [ img [ src "./assets/pokedex.svg" ] []
                        , img [ src model.pokemon.spriteUrl, class "pokedex__pokemon-img" ] []
                        , div [ class "pokedex__pokemon-data" ]
                            [ div [] [ text ("Id = " ++ String.fromInt model.pokemon.id) ]
                            , div [] [ text ("Name = " ++ model.pokemon.name) ]
                            , div [] [ text <| ("Weight = " ++ String.fromInt model.pokemon.weight) ]
                            ]
                        , button [ onClick DecrementId, class "pokedex__btn-decrement" ] [ text "-" ]
                        , button [ onClick IncrementId, class "pokedex__btn-increment" ] [ text "+" ]
                        ]
                    ]
                ]

        Success ->
            div []
                [ div [ class "pokedex-container" ]
                    [ div [ class "pokedex" ]
                        [ img [ src "./assets/pokedex.svg" ] []
                        , img [ src model.pokemon.spriteUrl, class "pokedex__pokemon-img" ] []
                        , div [ class "pokedex__pokemon-data" ]
                            [ div [] [ text ("Id = " ++ String.fromInt model.pokemon.id) ]
                            , div [] [ text ("Name = " ++ model.pokemon.name) ]
                            , div [] [ text <| ("Weight = " ++ String.fromInt model.pokemon.weight) ]
                            ]
                        , button [ onClick DecrementId, class "pokedex__btn-decrement" ] [ text "-" ]
                        , button [ onClick IncrementId, class "pokedex__btn-increment" ] [ text "+" ]
                        ]
                    ]
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


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
