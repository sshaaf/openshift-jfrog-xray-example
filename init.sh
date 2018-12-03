#!/bin/bash


  oc new-project dev-user1   --display-name="Dev"
  oc new-project stage-user1 --display-name="Stage"
  oc new-project cicd-user1  --display-name="CI/CD"

  sleep 2

  oc policy add-role-to-user edit system:serviceaccount:cicd-user1:jenkins -n dev-user1
  oc policy add-role-to-user edit system:serviceaccount:cicd-user1:jenkins -n stage-user1

  sleep 2

  oc new-app jenkins-ephemeral -n cicd-user1

  sleep 2

  oc new-app -f cicd-template.yaml --param DEV_PROJECT=dev-user1 --param STAGE_PROJECT=stage-user1 --param=EPHEMERAL=true -n cicd-user1 

