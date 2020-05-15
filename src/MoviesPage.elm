module MoviesPage exposing (pageMovies)

import Html exposing (Html, h1, text, div)
import Html.Events exposing (onClick)
import Bootstrap.ListGroup as Listgroup
import Bootstrap.Button as Button

pageMovies : Html msg
pageMovies =
    div []
        [ h1 [] [ text "Movies" ]
        , Listgroup.ul
            [ Listgroup.li [] [ text "Alert" ]
            , Listgroup.li [] [ text "Badge" ]
            , Listgroup.li [] [ text "Card" ]
            ]
        ]
