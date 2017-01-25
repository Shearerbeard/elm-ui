import Spec exposing (..)

import Html exposing (div, text, button)
import Html.Events exposing (onClick)

import Ui.NotificationCenter

import Ui.Styles.Theme exposing (default)
import Ui.Styles.NotificationCenter
import Ui.Styles

import Steps exposing (..)

type alias Model =
  { notifications : Ui.NotificationCenter.Model Msg
  }

type Msg
  = NotificationCenter Ui.NotificationCenter.Msg
  | Notify

init : () -> Model
init _ =
  { notifications = Ui.NotificationCenter.init ()
  }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg_ model =
  case msg_ of
    Notify ->
      let
        ( notifications, cmd ) =
          Ui.NotificationCenter.notify (text "Hello") model.notifications
      in
        ( { model | notifications = notifications }
        , Cmd.map NotificationCenter cmd )

    NotificationCenter msg ->
      let
        ( notifications, cmd ) =
          Ui.NotificationCenter.update msg model.notifications
      in
        ( { model | notifications = notifications }
        , Cmd.map NotificationCenter cmd )

view : Model -> Html.Html Msg
view { notifications } =
  div
    [ ]
    [ Ui.Styles.embedSome
      [ Ui.Styles.NotificationCenter.style
      ] default
    , Ui.NotificationCenter.view NotificationCenter notifications
    , button [ onClick Notify ] [ text "Notify" ]
    ]

assertValue value =
  assert.containsText
    { selector = "ui-number-pad-value"
    , text = toString value
    }

specs : Node
specs =
  describe "Ui.NotificationCenter"
    [
    ]

main =
  runWithProgram
    { subscriptions = \_ -> Sub.none
    , update = update
    , init = init
    , view = view
    } specs
