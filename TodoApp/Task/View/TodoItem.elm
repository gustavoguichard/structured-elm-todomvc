module TodoApp.Task.View.TodoItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import TodoApp.Msg as Main exposing (..)
import TodoApp.Task.Msg exposing (..)
import TodoApp.TaskList.Msg exposing (..)
import TodoApp.Task.Model as Task
import TodoApp.Task.View.Events exposing (onEnter)


todoItem : Task.Model -> Html Main.Msg
todoItem todo =
  li
    [ classList [ ( "completed", todo.completed ), ( "editing", todo.editing ) ] ]
    [ div
        [ class "view" ]
        [ input
            [ class "toggle"
            , type' "checkbox"
            , checked todo.completed
            , onClick (MsgForTask todo.id <| Check (not todo.completed))
            ]
            []
        , label
            [ onDoubleClick (MsgForTask todo.id <| Editing True) ]
            [ text todo.description ]
        , button
            [ class "destroy"
            , onClick (MsgForTaskList <| Delete todo.id)
            ]
            []
        ]
    , input
        [ class "edit"
        , value todo.description
        , name "title"
        , id ("todo-" ++ toString todo.id)
        , onInput (MsgForTask todo.id << Update)
        , onBlur (MsgForTask todo.id <| Editing False)
        , onEnter NoOp (MsgForTask todo.id <| Editing False)
        ]
        []
    ]
