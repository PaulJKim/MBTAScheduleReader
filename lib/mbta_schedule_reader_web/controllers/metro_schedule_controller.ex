defmodule MbtaScheduleReaderWeb.MetroScheduleController do
  use MbtaScheduleReaderWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  @spec getNextTime(Plug.Conn.t(), any) :: Plug.Conn.t()
  def getNextTime(conn, %{"line" => line, "stop" => stop, "direction" => direction} = params) do
    json(conn, params)
  end
end
