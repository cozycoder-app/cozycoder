import gleam/option.{type Option, None, Some}
import lustre
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

type Msg {
  UserEnteredName(name: String)
  UserClickedGreet
}

type Model {
  Model(person: Option(Person), value: String)
}

type Person {
  Person(name: String)
}

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn init(_flags) -> #(Model, Effect(Msg)) {
  #(Model(None, ""), effect.none())
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    UserEnteredName(name) -> #(Model(model.person, name), effect.none())
    UserClickedGreet -> #(Model(Some(Person(model.value)), ""), effect.none())
  }
}

fn view(model: Model) -> Element(Msg) {
  let name = case model.person {
    Some(person) -> person.name
    _ -> "developers"
  }
  html.div([attribute.class("max-w-3xl mx-auto p-5")], [
    html.div(
      [
        attribute.class(
          "border border-rosepine-overlay rounded-lg overflow-hidden flex flex-col h-screen bg-rosepine-surface",
        ),
      ],
      [
        html.div(
          [attribute.class("bg-rosepine-overlay p-4 text-center font-bold")],
          [element.text("Rose Pine Chat")],
        ),
        html.div([attribute.class("flex-grow overflow-y-auto p-4 space-y-4")], [
          html.div([], [
            html.div(
              [attribute.class("bg-rosepine-highlightMed p-3 rounded-lg")],
              [element.text("What's special about the Rose Pine theme?")],
            ),
          ]),
          html.div([], [
            html.div([attribute.class("bg-rosepine-overlay p-3 rounded-lg")], [
              element.text(
                "Rose Pine is a color scheme known for its soothing and sophisticated palette. It uses muted, earthy tones that are easy on the eyes, making it popular for user interfaces and code editors.",
              ),
            ]),
          ]),
          html.div([], [
            html.div(
              [attribute.class("bg-rosepine-highlightMed p-3 rounded-lg")],
              [element.text("How does it improve user experience?")],
            ),
          ]),
          html.div([], [
            html.div([attribute.class("bg-rosepine-overlay p-3 rounded-lg")], [
              element.text(
                "The Rose Pine theme can enhance user experience by reducing eye strain with its soft colors. It creates a calm, focused environment that's particularly suitable for long coding sessions or extended use of applications.",
              ),
            ]),
          ]),
        ]),
        html.div([attribute.class("flex p-4 bg-rosepine-overlay")], [
          html.input([
            attribute.type_("text"),
            attribute.placeholder("Type your message..."),
            attribute.class(
              "flex-grow mr-2 p-2 rounded bg-rosepine-surface border border-rosepine-muted text-rosepine-text focus:outline-none focus:border-rosepine-pine",
            ),
          ]),
          html.button(
            [
              attribute.class(
                "w-10 h-10 bg-rosepine-pine text-rosepine-text rounded flex items-center justify-center hover:bg-rosepine-foam hover:text-rosepine-base transition-colors",
              ),
            ],
            [element.text("Send")],
          ),
        ]),
      ],
    ),
  ])
}
