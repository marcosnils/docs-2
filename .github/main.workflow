workflow "Build and Index Files" {
  on       = "push"
  resolves = ["Install"]
}

action "Print env" {
  uses = "docker://mhart/alpine-node:10"
  runs = "sh -c"
  args = ["env"]
}

action "Master and not deleted" {
  needs = ["Print env"]
  uses  = "actions/bin/filter@master"
  args  = "branch master && not deleted"
}

action "Install" {
  needs = ["Master and not deleted"]
  uses  = "docker://mhart/alpine-node:10"
  runs  = "sh -c"
  args  = ["yarn install --production"]
}
