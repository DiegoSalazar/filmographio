module ActorsPage exposing (pageActors)

import Html exposing (Html, text, h2, div)
import Html.Events exposing (onClick)
import Bootstrap.Button as Button

pageActors : Html msg
pageActors =
    div []
        [ h2 [] [ text "Actors" ]
        , Button.button
            [ Button.success
            , Button.large
            , Button.block
            ]
            [ text "Click me" ]
        ]
