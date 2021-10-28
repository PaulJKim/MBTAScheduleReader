defmodule MbtaScheduleReader.Repo do
  use Ecto.Repo,
    otp_app: :mbta_schedule_reader,
    adapter: Ecto.Adapters.Postgres
end
