import Config

config :logger,
  level: :error

config :unlib,
  ecto_repos: [UnLib.Repo]

config :unlib, UnLib.Repo,
  migration_primary_key: [
    name: :id,
    type: :uuid
  ]

config :unlib, UnLib.Repo,
  database: "undb",
  hostname: "localhost",
  username: "postgres",
  password: "postgres",
  log: false
