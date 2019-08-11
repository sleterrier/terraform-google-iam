/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  version = "~> 2.7"
}

provider "google-beta" {
  version = "~> 2.7"
}

/******************************************
  Module folder_iam_binding calling
 *****************************************/
module "folder-iam" {
  source  = "../../"
  folders = ["${var.folder_one}", "${var.folder_two}"]

  mode = "additive"

  bindings = {
    "roles/resourcemanager.folderEditor" = [
      "serviceAccount:${var.sa_email}",
      "group:${var.group_email}",
    ]

    "roles/resourcemanager.folderViewer" = [
      "user:${var.user_email}",
    ]
  }
}
