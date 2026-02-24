variable "name_s3_state_backend" {
  description = "the name of the state s3 backend"
  type = string
}

variable "name_dynamodb_lock_table" {
  description = "the name of the dynamodb table for terraform state locking"
  type = string
}

variable "project_name" {
  description = "the name of the project for tagging purposes"
  type = string
}