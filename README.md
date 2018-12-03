# openshift-jfrog-xray-example

Create the projects for CI/CD pipeline

Development project, this is where our dev builds will reside
      
      oc new-project dev-user1   --display-name="Dev"

Staging, we will use stage to promote and tag our builds
      
      oc new-project stage-user1 --display-name="Stage"

CI/CD project, this will hold our Jenkins, GOGS and the pipeline
      
      oc new-project cicd-user1  --display-name="CI/CD"


Add roles for dev/stage so jenkins can deploy to them.
      
      oc policy add-role-to-user edit system:serviceaccount:cicd-user1:jenkins -n dev-user1
      oc policy add-role-to-user edit system:serviceaccount:cicd-user1:jenkins -n stage-user1

We are using ephemeral for this demo.
      
      oc new-app jenkins-ephemeral -n cicd-user1

Finally initiate the template with oc new-app
      
      oc new-app -f cicd-template.yaml --param DEV_PROJECT=dev-user1 --param STAGE_PROJECT=stage-user1 --param=EPHEMERAL=true -n cicd-user1 

The above commands can also be found in the file init.sh

Once Jenkins is up an running
Ensure the following
- You have a running Artifactory and Xray instance. 
- This demo was used with the SaaS instance. Which should be similar. 
- Make sure you have the artifactory plugin installed in Jenkins. This can be done through the plugin manager on the Jenkins instance. 
- Setup Maven config files both global and for project, copy the settings.xml provided. Ensure that you have filled in the username/password and url parameters for artifactory in the settings.xml before loading it.
  
  
      <username></username>
      <password></password>

      <url></url>

- Navigate to Global tool config, and add the settings files as provided files. 
- Also name the Maven tool as maven3 in the installed tools options

Now you can initiate the pipeline which will deploy to Dev project, and ask for input on the stage project.


This project is a trim down fork of: https://github.com/siamaksade/openshift-cd-demo



