# Overview
This quick project serves as a very light example of utilizing Docker and GitHub Actions as a part of a development workflow for a C++ API server. The contents below preserve the original readme information related to the project and associated tutorial.

This quick example utilizes a simple docker container to support development of this C++ api server, and leverages GitHub Actions for quick CI support. The compose file is set up to support Docker Watch to expand the flexibility of the container as a development environment. There is also a simple Kubernetes YAML file to support deploying the API to  a local K8s instance.
As this is an extremely simple development project, the associated Docker, Actions, and k8s infrastructure are also very slim.

Adding to the documentation below with additional information.

### [Docker Compose File](compose.yml)
This simple compose file creates a single APi service. The compose file utilizes the Dockerfile located at the root of the project directory. The currently included configurations include mapping the host and container ports to 8080, and enabling watch as a part of a development workflow.
The end result is the simple API service is hosted within the created container as defined in the Dockerfile, as executed by the compose.yml file.
The *it worked on my machine* version of this functionality can be acheived by running simple commands such as the below examples. The first to build the image in a detached process, the other to simply start the container back up if previous shut down.
```
docker compose up --build -d
docker compose up
```

### [cpp-docker-k8s.yml](cpp-docker-k8s.yml)
This is a nearly boilerplate k8s deployment yaml file to support creating the *ok-api* api service, and a corresponding deployment of that service to the locally hosted pods. This example is routing traffic from port 30001 of the host to port 8080 of the pod being routed to.
To also ensure *it worked on my machine* compliance, run the following:
```
kubectl apply -f cpp-docker-k8s.yml # deploy the application to k8s

kubectl get deployments # confirm the deployment 

kubectl get services # verify the new service-entrypoint service


```

---------------------------
## Original README
A simple HTTP server implemented in C++ using the C++ REST SDK. It listens for incoming HTTP GET requests and responds with a JSON message. This is for Docker's [C++ Language Guide](https://docs.docker.com/language/cpp/).

## API

The server only supports the HTTP GET method at the moment. When a GET request is received, the server responds with a JSON object:

```json
{
    "message": "OK"
}
```

## Running with Docker Compose

Below is the [Dockerfile](Dockerfile) for the C++ application:

```Dockerfile
# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Set the working directory in the container
WORKDIR /app

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    g++ \
    libcpprest-dev \
    libboost-all-dev \
    libssl-dev \
    cmake

# Copy the source code into the container
COPY ok_api.cpp .

# Compile the C++ code
RUN g++ -o ok_api ok_api.cpp -lcpprest -lboost_system -lboost_thread -lboost_chrono -lboost_random -lssl -lcrypto

# Expose the port on which the API will listen
EXPOSE 8080

# Command to run the API when the container starts
CMD ["./ok_api"]
```

To run this application using Docker Compose, you'll need to create a `compose.yml` file.

Here's the `compose.yml` file:

```yaml
services:
  ok-api:
    image: ok-api
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "8080:8080"
```

To build and run the Docker image using Docker Compose, use the following command:

```bash
docker-compose up
```

This will build the Docker image and then run it, mapping the container's port 8080 to port 8080 on the host machine. You can then access the API by visiting `http://localhost:8080` in your web browser.

## Contributing

Any feedback and contributions are welcome! Please open an issue before submitting a pull request.

## License

[MIT License](LICENSE)
