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
  html.div([], [
    html.p([], [element.text("Hello, " <> name <> "!")]),
    html.input([
      attribute.value(model.value),
      event.on_input(UserEnteredName),
      attribute.class(
        "block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6",
      ),
    ]),
    html.button(
      [
        event.on_click(UserClickedGreet),
        attribute.class(
          "inline-flex items-center rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500",
        ),
      ],
      [element.text("Greet")],
    ),
  ])
}
