# This is the TFVars for the instance that is built during the CI Pipeline
# Put here the configurations that you want to consider for this instance
groups = {
  "azure-groups-management-stack-ci" : ["your@email.com"],
}

environments = {
  environment : [
    { resource : "ci", name : "test", groups : ["azure-groups-management-stack-ci"], emails : ["your@email.com"] },
  ],
}