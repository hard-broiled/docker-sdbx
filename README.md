<a id="readme-top"></a>
<!-- docker-c++-example 
C++ codebase pulled from Docker example guide
-->

<!-- Shields Section -->
[![LinkedIn][linkedin-shield]][linkedin-url]

<div align="center">
    <h2 align="center">C++ Dockerized Workflow Example w/ Notes on Optmization</h2>
    <p align="center">
        Feature branch utilized for rapid prototyping and testing of C++ specific Docker functionality, with emphasis on optimized CI practices and corresponding GHA CI support.
    </p>
</div>


<!-- TABLE OF CONTENTS -->
<div>
    <details>
    <summary>Table of Contents</summary>
    <ul>
        <li>
        <a href="#overview">Project Overview</a>
        <ul>
            <li><a href="#contrsuc">Under Construction</a></li>
        </ul>
        </li>
    </ul>
    </details>
</div>


# Overview <a id="overview"></a>

README is currently **Under Construction**

The contained application is a simple C++ web application pulled from [C++ Language Guide](https://docs.docker.com/language/cpp/).

Initial versions of Docker related files generated via ```docker init```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- Links, etc. -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/jonathan-boyle/



# General Info
This quick project serves as a very light example of utilizing Docker and GitHub Actions as a part of a development workflow for a C++ API server. The contents below preserve the original readme information related to the project and associated tutorial.

This quick example utilizes a simple docker container to support development of this C++ api server, and leverages GitHub Actions for quick CI functionality. The compose file is set up to support Docker Watch to expand the flexibility of the container as a development environment. There is also a simple Kubernetes YAML file to support deploying the API to a simple K8s instance.
As this is an extremely simple development project, the associated Docker, Actions, and k8s infrastructure are also very slim.

### [Docker Compose File](compose.yml)
This simple compose file creates a single API service. The compose file utilizes the Dockerfile located at the root of the project directory. The currently included configurations include mapping the host and container ports to 8080, and enabling watch as a part of a development workflow.
The end result is the simple API service is hosted within the created container as defined in the Dockerfile, as executed by the compose.yml file.
The *it worked on my machine* version of this functionality can be acheived by running simple commands such as the below examples. The first to build the image in a detached process, the other to simply start the container back up if previous shut down.
```
docker compose up --build -d # building the image file anew and detaching the container composition process

docker compose up # creating the container from the cached image file
```

### [cpp-docker-k8s.yml](cpp-docker-k8s.yml)
This is a nearly boilerplate k8s deployment yaml file to support creating the *ok-api* api service, and a corresponding deployment of that service to the locally hosted pods. This example is routing traffic from port 30001 of the host to port 8080 of the pod being routed to.
To also ensure *it worked on my machine* compliance, run the following:
```
kubectl apply -f cpp-docker-k8s.yml # deploy the application to k8s

kubectl get deployments # confirm the deployment 

kubectl get services # verify the new service-entrypoint service
```