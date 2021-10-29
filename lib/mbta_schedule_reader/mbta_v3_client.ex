defmodule MbtaScheduleReader.MbtaV3Client do
  @spec getPredictions(any) :: any
  def getPredictions(stop) do
    url = "https://api-v3.mbta.com/predictions?filter[stop]=#{stop}"
    response = HTTPoison.get!(url)
    req = Poison.decode!(response.body)
    req
  end
end
