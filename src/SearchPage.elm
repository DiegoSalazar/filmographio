module SearchPage exposing (Model, init, pageSearch)

import Html exposing (Html, text, h2, div)
import Html.Attributes exposing (placeholder, class)
import Bootstrap.Grid as Grid
import Bootstrap.Form as Form
import Bootstrap.Button as Button
import Bootstrap.Form.InputGroup as InputGroup
import Bootstrap.Form.Input as Input

type alias Model =
    { query : String
    , results : List String
    }

init =
    { query = ""
    , results = []
    }

pageSearch : Html msg
pageSearch =
    div []
        [ searchForm
        , searchToolBar
        , resultsList
        , searchFooter
        ]

searchForm =
    Grid.row []
        [ Grid.col []
            [ Form.form [ class "mt-2" ]
                [ InputGroup.config
                    ( InputGroup.text [ Input.placeholder "Actor or Movie..." ] )
                    |> InputGroup.large
                    |> InputGroup.predecessors [ ]
                    |> InputGroup.successors
                        [ InputGroup.button [ Button.primary ]
                            [ text "Search"
                            ]
                        ]
                    |> InputGroup.view
                ]
            ]
        ]

searchToolBar =
    Grid.row []
        [ Grid.col []
            [ h2 [] [ text "search toolbar" ]
            ]
        ]

resultsList =
    Grid.row []
        [ Grid.col []
            [ h2 [] [ text "results list" ]
            ]
        ]

searchFooter =
    Grid.row []
        [ Grid.col []
            [ h2 [] [ text "search footer" ]
            ]
        ]
