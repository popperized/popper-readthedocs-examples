workflow "Run Benchmarks" {
  resolves = "analyse"
}
action "lint" {
  uses = "actions/bin/shellcheck@master"
  args = "-x ./pipelines/pgbench/benchmark.sh ./pipelines/pgbench/analyze.sh"
}
action "benchmark" {
  needs= "lint"
  uses = "actions/docker/cli@master"
  runs = ["./pipelines/pgbench/analyze.sh"]
  env = {
    PG_IMAGES = "pg9.6,pg9.3"
  }
}
action "analyse" {
  needs = "benchmark"
  uses = "actions/docker/cli@master"
  runs = [./pipelines/pgbench/analyze.sh"]
}