# Docker Tutorial 
[Reference Link Follwed](https://www.youtube.com/playlist?list=PLS1QulWo1RIbLUTUpy-nEHwMJAjcfVXqP)

---
## Docker search, docker images, docker pull

How does Docker work?
- You can build docker images that hold your applications
- You can create Docker containers from those Docker images to run your applications
- You can share those Docker images via Docker Hub or your own registry.

![image](https://user-images.githubusercontent.com/64950661/147757317-662e3243-2450-4132-8f24-9ea4c29b8cad.png)

- Search for a docker image : `docker search ubuntu` <br>
- Search with filters : `docker search --filter stars=3 ubuntu` <br>
- If you want to provide multiple filters then do this : `docker search --filter stars=100 --filter is-official=true ubuntu` <br>
- If you want to see the description without any trucations do this : <br>
  `docker search -f stars=100 -f is-official=true --no-trunc ubuntu` <br>
- List all the images that you have on host : `docker images` <br>
- Pull an  img from dockerhub : `docker pull java` <br>
- To check fo r particular type of img present on ur system : `docker images java` <br>
- You can also provide tag while you provide name : `docker images java:latest` <br>

Dokcer commads rquire root prieges. for more info - https://docs.docker.com/engine/install/linux-postinstall/ <br>

Note : you can also use sudo instead of going into root

---
## Fundamentals of DockerFile
Dokcerfile - docker can build imgs automatically by reading the instructions given in the docker file
its a text file in which terminal based commands are written
When you build a dockerfile you get a docker image, when you run an image you get a contianer.

you name a dockerfile as `Dockerfile` and it is without an extension

- To build a dockerfile : `sudo docker build .`<br>

The current working directory is called the build context and the dockerfile is assumed to be present in thos directory <br>
Everytime you change smthing in the dockerfile and build it, a new img is created <br>

if you want to build the docker file from other directory , you simply provide the path woith `-f` <br>
`sudo docker build -f /home/tejal/docker/D1/Dockerfile .` <br>

- To provide name the repo and tag : `sudo docker build -t my_app:1 .` <br>
where my_app represents the repo name and 1 represnts the tag

---
## Docker Contianer Basics
- To get the list of all the running contianer : `sudo docker ps` <br>
- To get the list of all the contianer that you have on your system use `-a` <br>
`sudo docker ps -a` <br>

- To run a contianer : `sudo docker run options image_name commands args` <br>
`sudo docker run IMAGE_ID` <br>

- To name the contianer so here `--name` is a flag : `sudo docker run --name my_ubuntu_contianer 54f852336194` <br>
when you run docker contianer it could run in atttched mode/ detached mode (in the background)<br>

- If you want to run in detached mode then : `sudo docker run --name my_ubuntu_contianer_1 -d 54f852336194` <br>

- The bada sa ID defines the contianer ID of the container <br>
you can us the short container ID that you se wile you list down the container list or you can  this bada sa contianer id to work with the containers to delete it or do smthing shit <br>
![image](https://user-images.githubusercontent.com/64950661/147760970-515cdf06-ee8b-4da9-a407-b13707088fe5.png)

- To run the container interactively, you can do the below shit in the interactive mode so that you can run comamnds inside the container <br>
![image](https://user-images.githubusercontent.com/64950661/147761259-f85b8cf9-0020-432d-895b-e7e065667b09.png) <br>
now when we run `sudo docker ps` we get a running contianer

- Yaha pe echo " .." is basically the command that is run inside the busybox contianer <br>
![image](https://user-images.githubusercontent.com/64950661/147761757-57cbee29-3895-4c86-ba80-d5581e527539.png)

- this runs the shell inside the contianer <br>
![image](https://user-images.githubusercontent.com/64950661/147761903-4ba661ef-fa35-43c6-9d42-cd3ed1d576d1.png)

- To remove a container just give the container ID of the contianer to be removed : `sudo docker rm CONTAINDER_ID` <br>
you can also rm multiple continers in 1 go just give `CONTAINR_ID_1 CONTIANER_ID_2 ..`

- you can stop a runnig  contianer by : `sudo docker stop CONTAINER_ID`

---
## Build and run C++ applications in a docker container
To run the docker container and remove the alrady running one : <br>
`sudo docker run --rm -it cpp_test_tejal:1`


## Docker commit 
Create a new image by committing the changes : `sudo docker commit [CONTAINER_ID] [new_image_name]`

[Reference](https://phoenixnap.com/kb/how-to-commit-changes-to-docker-image)

## Doubts
- when i pull an img where is it stored?
- 
