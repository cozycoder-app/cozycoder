# Cozy Coder

Your cozy space for coding with AI.

## Prerequisites

* Elixir 1.17
* Erlang 27
* Docker compose

### Installation

* Docker compose: [Install Docker Desktop](https://www.docker.com/products/docker-desktop/)
* Elixir and Erlang:
  * Recommended: Use [`mise`](https://mise.jdx.dev) with the provided
    `.mise.toml` file:

    ```sh
    mise install
    ```

  * Alternatively, follow the [official Elixir installation guide](https://elixir-lang.org/install.html)

## Usage

1. Clone the repository:

   ```sh
   git clone https://github.com/yourusername/cozy-coder.git
   cd cozy-coder
   ```

2. Launch Postgres:

   ```sh
   docker compose up -d
   ```

3. Install dependencies:

   ```sh
   mix setup
   ```

4. Start the Phoenix server:

   ```sh
   mix phx.server
   ```

   Or inside IEx:

   ```sh
   iex -S mix phx.server
   ```

5. Visit [`localhost:4000`](http://localhost:4000) in your browser.
