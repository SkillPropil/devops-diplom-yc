// создание сервисного аккаунта 
resource "yandex_iam_service_account" "service-diploma" {
    folder_id = var.yandex_folder_id
    name = "service-diploma"
  
}

//Присвоение прав достаточного для пользования 

resource "yandex_resourcemanager_folder_iam_member" "view" {
    folder_id   = var.yandex_folder_id
    role        = "viewer"
    member      = "serviceAccount:${yandex_iam_service_account.service-diploma.id}"
  
}


resource "yandex_resourcemanager_folder_iam_member" "edit" {
    folder_id   = var.yandex_folder_id
    role        = "editor"
    member      = "serviceAccount:${yandex_iam_service_account.service-diploma.id}"
  
}

resource "yandex_iam_service_account_static_access_key" "service-diploma" {
    service_account_id      = "${yandex_iam_service_account.service-diploma.id}"
    description             = "Статичный ключ для хранилища бакета"
}
