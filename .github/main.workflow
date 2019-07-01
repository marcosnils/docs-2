workflow "Build and Index Files" {
  on       = "push"
  resolves = ["Install"]
}

action "Master" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Install" {
  needs = ["Master"]
  uses  = "docker://mhart/alpine-node:10"
  runs  = "sh -c"
  args  = ["yarn install --production"]
}
