defmodule MbtaScheduleReaderWeb.PageController do
  use MbtaScheduleReaderWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
