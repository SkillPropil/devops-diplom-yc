# Первое задание - подготовка инфры
##На данном этапе в облачном провайдере YandexCloud будет развернута инфрастура из нескольких виртуальных машин при помощи Terraform.
 1) В первую очередь необходимо создать сервисный аккаунт [sa.tf](sa.tf)  
 2) Создаем бакет [bucket.tf](bucket.tf)
 3) Создаем VPC и VM's [vpc.tf](vpc.tf)  [vm.tf](vm.tf)

```
yandex_iam_service_account.service-diploma: Creating...
yandex_vpc_network.subnet: Creating...
yandex_vpc_network.subnet: Creation complete after 1s [id=enpg18o6brce8q4rnla7]
yandex_vpc_subnet.subnet[2]: Creating...
yandex_vpc_subnet.subnet[0]: Creating...
yandex_vpc_subnet.subnet[1]: Creating...
yandex_vpc_subnet.subnet[2]: Creation complete after 1s [id=fl8p648pkfcu60ej2r9a]
yandex_iam_service_account.service-diploma: Creation complete after 2s [id=ajevqdlngopmkl8689oe]
yandex_resourcemanager_folder_iam_member.edit: Creating...
yandex_resourcemanager_folder_iam_member.view: Creating...
yandex_iam_service_account_static_access_key.service-diploma: Creating...
yandex_vpc_subnet.subnet[1]: Creation complete after 1s [id=e2lbch8c8vqrm100gdel]
yandex_vpc_subnet.subnet[0]: Creation complete after 2s [id=e9bcfbc5ghhhkt6qj6r7]
yandex_compute_instance.master[0]: Creating...
yandex_compute_instance.work[0]: Creating...
yandex_compute_instance.work[1]: Creating...
yandex_iam_service_account_static_access_key.service-diploma: Creation complete after 1s [id=aje79kofhb515mi8bj97]
yandex_storage_bucket.diploma-bucket-sp1: Creating...
yandex_resourcemanager_folder_iam_member.edit: Creation complete after 2s [id=b1g73kf911qh20t72eeb/editor/serviceAccount:ajevqdlngopmkl8689oe]
yandex_resourcemanager_folder_iam_member.view: Creation complete after 6s [id=b1g73kf911qh20t72eeb/viewer/serviceAccount:ajevqdlngopmkl8689oe]
yandex_storage_bucket.diploma-bucket-sp1: Creation complete after 5s [id=diploma-bucket-sp1]
yandex_compute_instance.master[0]: Still creating... [10s elapsed]
yandex_compute_instance.work[0]: Still creating... [10s elapsed]
yandex_compute_instance.work[1]: Still creating... [10s elapsed]
yandex_compute_instance.work[0]: Still creating... [20s elapsed]
yandex_compute_instance.master[0]: Still creating... [20s elapsed]
yandex_compute_instance.work[1]: Still creating... [20s elapsed]
yandex_compute_instance.master[0]: Still creating... [30s elapsed]
yandex_compute_instance.work[0]: Still creating... [30s elapsed]
yandex_compute_instance.work[1]: Still creating... [30s elapsed]
yandex_compute_instance.work[0]: Still creating... [40s elapsed]
yandex_compute_instance.master[0]: Still creating... [40s elapsed]
yandex_compute_instance.work[1]: Still creating... [40s elapsed]
yandex_compute_instance.master[0]: Creation complete after 48s [id=fhm3jdot5c0a57ncmcjg]
yandex_compute_instance.work[0]: Creation complete after 48s [id=fhmeb1uf7sa0psafme6t]
yandex_compute_instance.work[1]: Still creating... [50s elapsed]
yandex_compute_instance.work[1]: Still creating... [1m0s elapsed]
yandex_compute_instance.work[1]: Creation complete after 1m3s [id=epdp73fts73g2ma8q1j5]

Apply complete! Resources: 12 added, 0 changed, 0 destroyed.
```
<img width="1397" alt="terra_VM's" src="https://github.com/user-attachments/assets/38346fa5-2aac-4b5b-bbd2-ec51e8828128">

