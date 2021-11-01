defmodule MbtaScheduleReader.MbtaV3Client do
  defmacro __using__(_opts) do
    quote do
      import MbtaScheduleReader.MbtaV3Client
    end
  end

  @spec getPredictions(any) :: any
  def getPredictions(stop) do
    url = "https://api-v3.mbta.com/predictions?filter[stop]=#{stop}"
    response = HTTPoison.get!(url)
    req = Poison.decode!(response.body)
    req
  end
end
