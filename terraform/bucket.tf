resource "yandex_storage_bucket" "diploma-bucket-sp1" {
    bucket = "diploma-bucket-sp1"
    access_key = yandex_iam_service_account_static_access_key.service-diploma.access_key
    secret_key = yandex_iam_service_account_static_access_key.service-diploma.secret_key

    anonymous_access_flags {
      read = false
      list = false
    } 
}
