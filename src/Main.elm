module Main exposing (main)

import Html exposing (Html, text, div, h1, h2, img, span)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Browser.Navigation as Navigation
import Browser exposing (UrlRequest)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, s, top)
import Bootstrap.CDN as CDN
import Bootstrap.Navbar as Navbar
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Modal as Modal
import Bootstrap.Button as Button

import SearchPage exposing (pageSearch)
import ActorsPage exposing (pageActors)
import MoviesPage exposing (pageMovies)

type alias Flags = {}

type alias Model =
    { navKey : Navigation.Key
    , page : Page
    , navState : Navbar.State
    , modalVisibility : Modal.Visibility
    , searchPage : SearchPage.Model
    }

type Page
    = Search
    | Actors
    | Movies
    | NotFound


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChange
        }

init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg

        ( model, urlCmd ) =
            urlUpdate url { navKey = key, navState = navState, page = Search, modalVisibility = Modal.hidden, searchPage = SearchPage.init }
    in
        ( model, Cmd.batch [ urlCmd, navCmd ] )




type Msg
    = UrlChange Url
    | ClickedLink UrlRequest
    | NavMsg Navbar.State

subscriptions : Model -> Sub Msg
subscriptions model =
    Navbar.subscriptions model.navState NavMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink req ->
             case req of
                 Browser.Internal url ->
                     ( model, Navigation.pushUrl model.navKey <| Url.toString url )

                 Browser.External href ->
                     ( model, Navigation.load href )

        UrlChange url ->
            urlUpdate url model

        NavMsg state ->
            ({ model | navState = state }, Cmd.none )


urlUpdate : Url -> Model -> ( Model, Cmd Msg )
urlUpdate url model =
    case decode url of
        Nothing ->
            ( { model | page = NotFound }, Cmd.none )

        Just route ->
            ( { model | page = route }, Cmd.none )


decode : Url -> Maybe Page
decode url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
    |> UrlParser.parse routeParser


routeParser : Parser (Page -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Search top
        , UrlParser.map Actors (s "actors")
        , UrlParser.map Movies (s "movies")
        ]


view : Model -> Browser.Document Msg
view model =
    { title = "Filmographio"
    , body =
        [ navigation model
        , mainContent model
        , footer
        ]
    }


navigation : Model -> Html Msg
navigation model =
    Navbar.config NavMsg
        |> Navbar.dark
        |> Navbar.withAnimation
        |> Navbar.brand [ href "/" ] [ text "Filmograph.io" ]
        |> Navbar.items
            [ Navbar.itemLink [ href "#actors" ] [ text "Actors" ]
            , Navbar.itemLink [ href "#movies" ] [ text "Movies" ]
            ]
        |> Navbar.view model.navState


mainContent : Model -> Html msg
mainContent model =
    let
        page = case model.page of
            Search -> pageSearch
            Actors -> pageActors
            Movies -> pageMovies
            NotFound -> pageNotFound
    in
    Grid.containerFluid [] [ page ]


pageNotFound : Html msg
pageNotFound =
    div []
        [ h1 [] [ text "Not found" ]
        , text "Sorry couldn't find that page"
        ]


footer : Html Msg
footer =
    Html.footer [ class "footer mt-auto" ]
        [
            div [ class "container-fluid" ]
                [ span [ class "text-muted" ] [ text "Footer" ] ]
        ]
