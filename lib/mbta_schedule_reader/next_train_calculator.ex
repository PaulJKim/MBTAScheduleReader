defmodule MbtaScheduleReader.NextTrainCalculator do
  defmacro __using__(_opts) do
    quote do
      import MbtaScheduleReader.NextTrainCalculator
    end
  end

  def filterForDepartureTimeExists(data) do
    Enum.reject(data["data"], fn e -> e["attributes"]["departure_time"] == nil end)
  end

  @spec filterForDirection(nil | maybe_improper_list | map, charlist) :: list
  def filterForDirection(data, direction) do
    Enum.filter(data, fn e -> e["attributes"]["direction_id"] == elem(Integer.parse(direction), 0) end)
  end

  def iterateOverPredictions([head | tail]) do
    IO.inspect(head)
    iterateOverPredictions(tail)
  end

  def iterateOverPredictions([]), do: nil

  def calculateNextTrain(data) do
    current_datetime = DateTime.from_iso8601((DateTime.to_iso8601(DateTime.now!("US/Eastern"))))
    Enum.filter(data, &compareDateTimes(&1, current_datetime)) |>
    Enum.sort_by(&sortByDepartureTime/1)
  end

  def compareDateTimes(first, second) do
    DateTime.compare(elem(DateTime.from_iso8601(first["attributes"]["departure_time"]), 1) , elem(second, 1)) == :gt
  end

  def sortByDepartureTime(prediction) do
    prediction["attributes"]["departure_time"]
  end
end
