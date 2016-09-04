module Main exposing (..)

import Html exposing (Html, Attribute, button, input, div, text)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String


main : Program Never
main =
    App.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { content : String
    }


model : Model
model =
    { content = ""
    }



-- UPDATE


type Msg
    = AddExclamationPoint
    | Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddExclamationPoint ->
            { model | content = model.content ++ "!" }

        Change newContent ->
            { model | content = newContent }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input
            [ onInput Change
            , value model.content
            , placeholder "Text to reverse"
            ]
            []
        , button [ onClick AddExclamationPoint ] [ text "Yell" ]
        , div [] [ text (String.reverse model.content) ]
        ]
