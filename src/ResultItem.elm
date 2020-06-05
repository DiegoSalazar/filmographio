module ResultItem exposing (Model, view)

import Html exposing (Html, text, h5, div, p, small)
import Html.Attributes exposing (href)
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Utilities.Flex as Flex
import Bootstrap.Utilities.Spacing as Spacing
import Bootstrap.Utilities.Size as Size

type alias Model =
    { heading : String
    , detail : String
    , text : String
    , footer : String
    }

-- ListGroup.anchor
--     [ ListGroup.attrs [ href "#", Flex.col, Flex.alignItemsStart ] ]
--     [ div [ Flex.block, Flex.justifyBetween, Size.w100 ]
--         [ h5 [ Spacing.mb1 ] [ text model.heading ]
--         , small [] [ text "3 days ago" ]
--         ]
--     , p [ Spacing.mb1 ] [ text "Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit." ]
--     , small [] [ text "Oh yea that's neat" ]
--     ]
-- ListGroup.anchor
--     [ ListGroup.active
--     , ListGroup.attrs [ href "#", Flex.col, Flex.alignItemsStart ]
--     ]
--     [ div [ Flex.block, Flex.justifyBetween, Size.w100 ]
--         [ h5 [ Spacing.mb1 ] [ text "List group heading" ]
--         , small [] [ text "3 days ago" ]
--         ]
--     , p [ Spacing.mb1 ] [ text "Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit." ]
--     , small [] [ text "Oh yea that's neat" ]
--     ]

view : Model -> ListGroup.CustomItem msg
view model =
    ListGroup.anchor
        [ ListGroup.attrs [ href "#", Flex.col, Flex.alignItemsStart ] ]
        [ div [ Flex.block, Flex.justifyBetween, Size.w100 ]
            [ h5 [ Spacing.mb1 ] [ text model.heading ]
            , small [] [ text model.detail ]
            ]
        , p [ Spacing.mb1 ] [ text model.text ]
        , small [] [ text model.footer ]
        ]
