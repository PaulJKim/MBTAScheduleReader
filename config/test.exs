import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :mbta_schedule_reader, MbtaScheduleReader.Repo,
  username: "postgres",
  password: "postgres",
  database: "mbta_schedule_reader_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mbta_schedule_reader, MbtaScheduleReaderWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "C7qbBS6ADIdc42ofpKjnnIGJSmhEmHYcyLsW+eMPp6x2k216V1twIMYdlVL/WFVY",
  server: false

# In test we don't send emails.
config :mbta_schedule_reader, MbtaScheduleReader.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
