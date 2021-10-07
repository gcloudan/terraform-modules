locals {
  name = format("%s-%s", var.name, random_id.cmek_suffix.hex)
}
