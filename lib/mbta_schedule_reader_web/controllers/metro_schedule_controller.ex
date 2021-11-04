defmodule MbtaScheduleReaderWeb.MetroScheduleController do
  use MbtaScheduleReaderWeb, :controller
  use MbtaScheduleReader.MbtaV3Client
  use MbtaScheduleReader.NextTrainCalculator

  def index(conn, _params) do
    render(conn, "index.html")
  end

  @spec getNextTime(Plug.Conn.t(), any) :: Plug.Conn.t()
  def getNextTime(conn, %{"line" => line, "stop" => stop, "direction" => direction} = params) do
    # Idea: Separate service for translating stop name (ex. Harvard Ave) to parent stop id (ex. place-harvd)
    # Would probably require us to maintain a mapping of stop name to parent stop id.
    # Alexa could maybe handle accounting for different variations of "Harvard Avenue", for example

    # How to pass direction variable to filter for direction??
    IO.inspect(params)
    predictions =
      getPredictions(stop) |>
      filterForDepartureTimeExists() |>
      filterForDirection(direction) |>
      calculateNextTrain()
    json(conn, List.first(predictions))
  end
end
