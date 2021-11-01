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

    # How to pass direction to filter for direction??
    predictions = getPredictions(stop) |> filterForDepartureTimeExists() |> filterForDirection() |> calculateNextTrain()
    json(conn, List.first(predictions))
  end
end
