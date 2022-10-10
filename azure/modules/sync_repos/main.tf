terraform {
  required_providers {
    databricks = {
      source = "databrickslabs/databricks"
      version = "~>0.4.0"
    }
  }
}

resource "databricks_repo" "nutter_in_home" {
  url = "https://github.com/sprakash277/de_ml-cicd-git-action.git"
  /* 
  path to put the checked out Repo. If not specified, then repo will be created in 
  the user's repo directory (/Repos/<username>/...).
  */
  #path = "/Repos/<username>/"
}