defmodule HelloworldWeb.PageController do
  use HelloworldWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
