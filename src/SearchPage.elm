module SearchPage exposing (Model, init, pageSearch)

import Html exposing (Html, text, h2, h5, div, p, small)
import Html.Attributes exposing (placeholder, class, href)
import Bootstrap.Grid as Grid
import Bootstrap.Form as Form
import Bootstrap.Button as Button
import Bootstrap.Form.InputGroup as InputGroup
import Bootstrap.Form.Input as Input
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Utilities.Flex as Flex
import Bootstrap.Utilities.Spacing as Spacing
import Bootstrap.Utilities.Size as Size

import ResultItem exposing (view)


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
    let
        results =
            [ { heading = "Audrey Hepburn", detail = "3 days ago", text = "Donec id elit non mi porta", footer = "Thats the best" }
            , { heading = "Dolly Parton", detail = "2 days ago" , text = "Maecenas sed diam eget risus varius blandit.", footer = "Oh yea that's neat" }
            , { heading = "Natalie Portman", detail = "1 days ago" , text = "Mi porta gravida at eget maecenas sed diam eget risus varius blandit.", footer = "What else" }
            ]

    in
    div []
        [ searchForm
        , searchToolBar
        , resultsList results
        , searchFooter
        ]

searchForm : Html msg
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

searchToolBar : Html msg
searchToolBar =
    Grid.row []
        [ Grid.col []
            [ h2 [] [ text "results toolbar" ]
            ]
        ]

resultsList : List ResultItem.Model -> Html msg
resultsList results =
    Grid.row []
        [ Grid.col [] <| resultsListContent results
        ]

resultsListContent : List ResultItem.Model -> List(Html msg)
resultsListContent results =
    [ ListGroup.custom <| List.map ResultItem.view results
    ]

searchFooter : Html msg
searchFooter =
    Grid.row []
        [ Grid.col []
            [ h2 [] [ text "results footer" ]
            ]
        ]
