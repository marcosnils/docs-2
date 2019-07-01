workflow "Build and Index Files" {
  on       = "push"
  resolves = ["Install"]
}

action "Print env" {
  uses = "docker://mhart/alpine-node:10"
  runs = "sh -c"
  args = ["env"]
}

action "Master" {
  needs = ["Print env"]
  uses  = "actions/bin/filter@master"
  args  = "branch master"
}

action "Install" {
  needs = ["Master"]
  uses  = "docker://mhart/alpine-node:10"
  runs  = "sh -c"
  args  = ["yarn install --production"]
}
