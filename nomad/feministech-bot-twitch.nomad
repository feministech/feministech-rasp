job "feministech-bot-twitch" {
  datacenters = ["dc1"]
  type = "service"

  group "feministech-bot-twitch" {
    count = 4

    update {
      max_parallel = 2
      min_healthy_time = "30s"
      healthy_deadline = "5m"
    }

    service {
      name = "feministech-bot-twitch"
      tags = ["urlprefix-/post"]
      port = "http"
      check {
        name     = "alive"
        type     = "http"
        path     = "/post"
        interval = "10s"
        timeout  = "2s"
      }
    }

    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    task "feministech-bot-twitch" {
      env {
      }

      driver = "docker"

      config {
        image = "lissatransborda/feministech-bot"
        ports = ["http"]
      }
    }
  }
}
