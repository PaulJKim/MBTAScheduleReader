defmodule MbtaScheduleReader.NextTrainCalculator do
  defmacro __using__(_opts) do
    quote do
      import MbtaScheduleReader.NextTrainCalculator
    end
  end

  def filterForDepartureTimeExists(data) do
    Enum.reject(data["data"], fn e -> e["attributes"]["departure_time"] == nil end)
  end

  @spec filterForDirection(nil | maybe_improper_list | map) :: list
  def filterForDirection(data) do
    Enum.filter(data, fn e -> e["attributes"]["direction_id"] == 0 end)
  end

  def iterateOverPredictions([head | tail]) do
    IO.inspect(head)
    iterateOverPredictions(tail)
  end

  def iterateOverPredictions([]), do: nil

  def calculateNextTrain(data) do
    Enum.sort_by(data, &sortByDepartureTime/1)
  end

  def sortByDepartureTime(prediction) do
    prediction["attributes"]["departure_time"]
  end
end
