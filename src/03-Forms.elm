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
    { name : String
    , password : String
    , passwordAgain : String
    }


model : Model
model =
    { name = ""
    , password = ""
    , passwordAgain = ""
    }



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name newContent ->
            { model | name = newContent }

        Password newContent ->
            { model | password = newContent }

        PasswordAgain newContent ->
            { model | passwordAgain = newContent }



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ classList [ ( "container", True ) ]
        ]
        [ Html.h1 [] [ text "Enter your credentials" ]
        , viewInput
            model.name
            "text"
            Name
            "Name"
        , div [] []
        , viewInput
            model.password
            "password"
            Password
            "Password"
        , div [] []
        , viewInput
            model.passwordAgain
            "password"
            PasswordAgain
            "Password Again"
        , div [] []
        , viewValidation model
        ]


viewInput : String -> String -> (String -> msg) -> String -> Html msg
viewInput val inputType oninput place =
    input
        [ onInput oninput
        , value val
        , type' inputType
        , placeholder place
        , classList [ ( "form-control", True ) ]
        ]
        []


viewValidation : Model -> Html msg
viewValidation model =
    let
        ( color, message ) =
            if model.password == model.passwordAgain then
                ( "green", "OK" )
            else
                ( "red", "Passwords do not match!" )
    in
        div [ style [ ( "color", color ) ] ] [ text message ]
