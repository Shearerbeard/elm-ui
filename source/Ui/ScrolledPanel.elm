module Ui.ScrolledPanel exposing (view)

{-| This module provides a view for scrolled panels.

@docs view
-}
import Html exposing (node)

import Ui.Styles.ScrolledPanel exposing (defaultStyle)
import Ui.Styles

{-| Renders a panel that have scrolling content.

    Ui.ScrolledPanel.view [ text "Long scrollable text..." ]
-}
view : List (Html.Html msg) -> Html.Html msg
view contents =
  node
    "ui-scrolled-panel"
    (Ui.Styles.apply defaultStyle)
    [ node "ui-scrolled-panel-wrapper" [] contents ]