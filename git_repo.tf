hcl
resource "google_developer_connect_repository" "my-repository" {
  git_repository_link_id = "my-repo-id"
  parent_connection      = google_developer_connect_connection.my-connection.connection_id
  clone_uri              = "https://github.com/myuser/myrepo.git"
}