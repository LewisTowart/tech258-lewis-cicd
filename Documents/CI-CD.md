- [CI/CD](#cicd)
  - [What is CI/CD?](#what-is-cicd)
    - [CI](#ci)
    - [CD](#cd)
  - [What is a Webhook?](#what-is-a-webhook)
  - [Why, when and where do we create a CI/CD pipeline?](#why-when-and-where-do-we-create-a-cicd-pipeline)
    - [Nodes](#nodes)
  - [Difference between Delivery and Deployment in prod?](#difference-between-delivery-and-deployment-in-prod)
  - [Create a Jenkins Build](#create-a-jenkins-build)
    - [Step 1.](#step-1)
    - [Step 2.](#step-2)
    - [Step 3.](#step-3)
    - [Step 4.](#step-4)
    - [Step 5.](#step-5)
    - [Step 6.](#step-6)
    - [Step 7.](#step-7)
    - [Step 8.](#step-8)
    - [Step 9.](#step-9)
  - [Creating a Github and Jenkins webhook](#creating-a-github-and-jenkins-webhook)
    - [Step 1.](#step-1-1)
    - [Step 2.](#step-2-1)
    - [Step 3.](#step-3-1)


# CI/CD

## What is CI/CD?

![alt text](<Markdown_Images/cicd diagram.png>)

CI/CD stand for continuous integration continuous delivery/deployment

It is the process of automating the steps contained within the software development life cycle; Plan, Design, Develop, Test and Deploy

CI/CD is about automating key aspects of the software development lifecycle, from integrating code changes to deploying them to production. It helps teams deliver high-quality software more efficiently by reducing manual effort, speeding up feedback loops, and increasing deployment frequency.

### CI

This involves automatically building and testing code changes frequently, typically multiple times a day or whenever changes are pushed to the version control repository. The goal of CI is to catch integration errors early in the development process, ensuring that new code additions don't break the existing codebase.

### CD

This is the process of automatically deploying code changes to production or staging environments after they pass through the CI pipeline. The goal of CD is to streamline the deployment process, making it fast, reliable, and repeatable. With continuous deployment, code changes can be released to users quickly and frequently.

## What is a Webhook?

A webhook is a mechanism for automatically triggering an action or notifying an external system when a certain event occurs.

An example of this would be on Amazing when you add an item to the basket it is checking first is that item in stock? If yes allow the item to be added to the basket. Then at the payment stage has the payment gone through? If yes send an email to notify the user of this. Has the item then been sent out for delivery? If yes notify the user that their item is on it's way.

A webhook is what allows all of these actions to me automated without this it wouldn't feasibly be possible for someone to do this for the billions of orders amazon gets each year.

## Why, when and where do we create a CI/CD pipeline?

![alt text](Markdown_Images/jenkins.jpg)

A CI/CD pipeline is present in every role containing DevOps and is one of the core principles. This is because implementing a CI/CD allows you to release software faster. In turn this saves time doing these steps manually and it also saves money.

This process also allows for a consistent feedback loop. At the testing stage if something is wrong with the code such as a function being missing a log will be created. This log can then be sent back to the development team for them to fix.

### Nodes

We are going to set up a Jenkins master node which will be responsible for the automatic deployment of our code assuming it passes testing. This tells the agent node to do the tests and the log file can be accessed from here.

We are also going to set up a Jenkins agent node that will responsible for that testing and creating the log file. If any issues arise this log file can be looped back for the developers to fix.

## Difference between Delivery and Deployment in prod?

When the new code has been tested and is ready to be sent into the production environment you can either deliver this or deploy it.

If you were to deliver the new code it will not be live for the user to have access to. You would need to manually do this yourself by going into the app and doing npm start for example to get it running.

As for deployment this can be done automatically within the CI/CD pipeline with Jenkins. The code will be deployed and would be live within the prod environment with users being able to access it. This could be something along the lines of a new feature or bug fix.

A real life example would be when a movie has released they are delivered to the cinema weeks before they are actually airing. This can be helpful to check if there are an unforeseen issues with them. When the time comes they will then say this movie is airing come and see if so the user/member of the public can come and watch the film.

jenkins is an open source automation server i

http://3.9.14.9:8080/login?from=%2F

## Create a Jenkins Build

### Step 1.

Login using the below link.

http://3.9.14.9:8080/login?from=%2F

### Step 2.

Click on create new items and select free style project. Name it something sensible like lewis-ci then click okay.

### Step 3.

Now continue down to Office 365 Connector and select restrict where this project can be run. Then in the search box look for sparta-ubuntu-node. You will want to delete the empty space at the end and select the option again for a second time.


### Step 4.

Move down to Source code management and select git. Here you want to add the http link from your git repo into the repositry URL box.

You will also need to links the correct credentials mine being lewis-jenkins.

Change the branch specifier to main which is where the app is located.

### Step 5.

Moving onto build triggers this is where we are automating the response form the webhook. You are going to want to follow the step in the webhook section and then return to this part. Now select the box that says Github hook trigger.

### Step 6.

Now scrolling down to build environment we want to select the tick box for provide node and npm bin. This is so that node will be installed on our virtual machine.

### Step 7.

Next we are adding in the build section, click the add option and select excute shell. The below code need to go in the command box to test the app.

```
cd app
npm install
npm test
```

### Step 8.

Now you can click save to move to the next screen.

Here we want to first manually test our build by clicking the build now option. If everything has worked you should see a #1 with a blue dot next to it to indicate a success with no issues.

You can check this by click the arrow next to the #1 which appears when you hover over it and selecting console output.

### Step 9.

To test that our webhook is working we need to make a change to our local repo that is assocaited with out Jenkins build.

Once we have made this change push the new changes to the remote repo on github

If done correct similar to before a #2 build should appear on the Jenkins UI and should also have a successful blue dot next to it.

## Creating a Github and Jenkins webhook

### Step 1.

First we are going to head over to our github repo that we want to associate the webhook with.

Once we are there we are going to click on settings.

### Step 2.

In this list we can see webhooks on the left side click on this option. Next you want to click on the option near the top right that says add webhook.

### Step 3.

In the payload URL box you are going to want to paste the link of your build/Jenkins environment URL with /github-webhook/ at the end. An example link can be seen below.

http://3.9.14.9:8080/github-webhook/

Finally you are going to want to select when you want this webhook to trigger in this case just select push event for now. Also select the box that says active to deliver event deatils when the hook is triggered.

You can now return to creating your Jenkins build as the webhook will be assocaited with it if you've used the corresponding link.