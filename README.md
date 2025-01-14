<a id="readme-top"></a>
<!-- docker-dotnet-example 
dotnet codebase pulled from Docker .Net Language Guide
-->

<!-- Shields Section -->
[![LinkedIn][linkedin-shield]][linkedin-url]

<div align="center">
    <h2 align="center">.Net Dockerized Workflow Example w/ Notes on Optmization</h2>
    <p align="center">
        Feature branch utilized for rapid prototyping and testing of .NET specific Docker functionality, with emphasis on optimized CI practices and corresponding GHA CI support.
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
            <li><a href="#dockerfile">Dockerfile Considerations</a></li>
            <ul>
                <li><a href="#base-stage">Base Stage</a></li>
                <li><a href="#build-stage">Build Stage</a></li>
                <li><a href="#test-stage">Test Stage</a></li>
                <li><a href="#development-stage">Development Stage</a></li>
                <li><a href="#runtime-stage">Runtime Stage</a></li>
            </ul>
            <li><a href="#compose">Compose Considerations</a></li>
            <li><a href="#gha-cicd">CI & CD via GitHub Actions</a></li>
            <li><a href="#k8s">docker-dotnet-kubernetes.yaml Considerations</a></li>
            <li><a href="#takeaways">Final Takeaways and Long-term Considerations</a></li>
            <ul>
                <li><a href="#orchestration">Light-weight Production-close Orchestration</a></li>
            </ul>
        </ul>
        </li>
    </ul>
    </details>
</div>


# Overview <a id="overview"></a>

This feature branch addresses the situation of a development workflow focused on a simple .NET application utilizing a postgresql datastore, and a basic student/school data model. The task included in this feature, is containerizing the application and preparing it for a new development workflow centered around Docker.

There is some initial work we can do to save ourselves future technical debt and pain. First, we note that this app is currently running on dotnet 6.0. This is an older version of dotnet, already past it's EoS date, and will likely become a focus of a migration effort in the future.

Second, I clarify here that for development centric purposes docker compose can *currently* serve just fine as an initial development environment focused deployment/orchestration tool. Eventually the target is to build out this workflow to connect to a hosted miniaturized Kubernetes instance, and ideally use a configuration tool like Ansbile to ensure consistency.

While the original .NET project files for this branch are based on an available guide at the Docker documentation site, there are additions and enhancements in several files. The goal of these items is to improve the future development and ops support for this app, optimize image build actions, and prepare the application for more advanced orchestration support.



Footnotes:

The contained application is a simple .NET web application pulled from [Docker's .NET Language Guide](https://docs.docker.com/language/dotnet/).
Initial versions of Docker related files generated via ```docker init```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## ```Dockerfile``` Considerations <a id="dockerfile"></a>

The primary goals to consider at this stage of the workflow are to ensure we can leverage optimal Docker capabilities while considering the current state of the application and development choices. To strive towards this, the Dockerfile has been modified to a multi-stage configuration. Below each stage is reviewed and the choices made for each are considered.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Base Stage <a id="base-stage"></a>

```
# Base image
ARG DOTNET_VERSION=6.0
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:${DOTNET_VERSION}-alpine AS base
WORKDIR /source
```
As noted before, the dotnet version for this application is currently 6.0. EoL support for this version was 11/12/24, so there is a high chance that this app will be migrated in the near future to a newer version. For now we simplify this upgrade process via the supplied argument so that the base and runtime image references are correct.

It should also be noted, that the '...dotnet/sdk...' image selection is in-line with recommended practices per microsoft documentation. This is also true for the selection of base image for the runtime layer as seen in the [documentation](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/net-core-net-framework-containers/official-net-docker-images#during-development-and-build).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Build Stage <a id="build-stage"></a>

```
# Build Stage
FROM base AS build
ARG TARGETARCH
COPY src/*.csproj src/
COPY tests/*.csproj tests/
# COPY NuGet.Config ./ # included as an example for projects that may leverage a nuget.config file
RUN --mount=type=cache,id=nuget,target=/root/.nuget/packages \
    dotnet restore src/*.csproj
COPY . .
WORKDIR /source/src
RUN --mount=type=cache,id=nuget,target=/root/.nuget/packages \
    dotnet publish -a ${TARGETARCH/amd64/x64} --no-restore --use-current-runtime --self-contained false -o /app
```

The biggest improvements seen in this stage are pulling the dependencies and restoring the project dependencies before the dotnet publish actions is executed. For this particular project, that yield more efficient image build times. 

It should be noted, the best methods for optimizing dependency focused restore steps in dockerized .net applications are not one-size-fits-all solutions. There are popular script based methods and utilities like [dotnet-subset](https://github.com/nimbleways/dotnet-subset) that are often utilized to solve this problem. 

MSFT [documentation](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/docker/building-net-docker-images#the-dockerfile) encourages practices around selectively copying csprof files and restoring as a distinct layer before proceeding to a following layer that copies the rest of the code base for a ```dotnet publish``` execution. For many use cases, this will yield an optimal image build process as the restore layer will leverage previously cached results unless there was a change detected in the copied csproj files, which isn't likely to be a common change.

There are additional points of consideration for more complex .NET applications. As we begin supporting applications with more and more contained projects, the list of *.csproj files will grow accordingly. Having to manually update and maintain a distinct restore layer while ensuring that no configuration files are missed while also preserving the project folder structure introduces many vectors for errors in this hypothetical workflow.

A more mature and future-proof solution would be utilizing dotnet-subset tool. This would require changes to several layers of the existing dockerfile to ensure we can install the tool, running the tool to collect all necessary configuration files, and changing the ```dotnet restore``` command to reference the output of the tool to ensure all csproj files are captured. This of course introduces potential issues in that a new 3rd party tool would be introduced at the base or very early layers of the image build process.

For the purposes of this example project, the maintainence of a distinct restore layer looks to be lighter than a script based or dotnet-subset based solution. This is due to the fact we only have two configuration files, and there's no defined expectation of application expansion.

For additional reading, there is a great write-up of this support scenario by the folks behind dotnet-subset that can be found [here](https://blog.theodo.ma/docker-build-caching-for-dotnet-applications-done-right-with-dotnet-subset/). 

For the rest of the build stage, things proceed fairly normally with a ```dotnet publish``` call that includes the ```--no-restore``` flag to complete the optimization introduced by the distinct restore layer.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Test Stage <a id="test-stage"></a>

```
# Test Stage
FROM base AS test
COPY --from=build /source /source
# Run unit tests
RUN dotnet test /source/tests --verbosity detailed
```

This stage again utilizes the base image layer, and copies results from the build stage in to allow for avoiding unneccessary additional build steps. With these items in hand, it is able to simple execute ```dotnet test``` as the ```tests\``` contents were copied to the working directory previously in the build step. The detailed verbosity tag isn't necessary, and was only included as an example where more logging information is desired.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Development Stage <a id="development-stage"></a>

```
# Development Stage
FROM base AS development
COPY . /source
WORKDIR /source/src
CMD dotnet run --no-launch-profile
```

The purpose of this section at this point is primarily as a place holder for a more comprehensive development specific layer. This could be targeted by orchestration functionality such as the compose file, or leveraged in GHA pipeline that is configured to specifically support a development container and version of the app as a part of a pre-production workflow.

As a part of this effort, this stage will be targeted for significant improvement to ensure a more complete workflow and CI/CD flow could be established for this project.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Runtime Stage <a id="runtime-stage"></a>

```
# Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:${DOTNET_VERSION}-alpine AS final
WORKDIR /app
COPY --from=build /app .
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
USER appuser
ENTRYPOINT ["dotnet", "myWebApp.dll"]
```

An important distinction to note in the first line of this section is the base image being used. As mentioned during the first layers of this image, MSFT documentation provides recommendations on image flavors to be used in build & development versus production purposes. the ```...dotnet/aspnet...``` element of this image name is that key distinction. There is comprehensive [documentation](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/net-core-net-framework-containers/official-net-docker-images#in-production) explaining further on this design choice. In short, utilizing this lighter image for runtime or production purposes will yield a more optimal image build process.

From there, the file follows a fairly standard set of procedures:
 - Copying necessary output files from the build stage
 - Creating a non-admin user to be utilized to lend for a more secure process
 - Creating and executing the entrypoint to start the application

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### ````Dockerfile```` Conclusion

This is by no means a complete conversation about dockerfiles, or the potential enhancements that could be included in this example. Volumes declaration could be considered within the Dockerfile depending on how complex the end state of this application is expected to be. As we intend to use docker compose for development orchestration, this dockerfile is satisfactory for the current purposes.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## ```compose.yaml``` Considerations <a id="compose"></a>

The initial [compose.yaml](compose.yaml) file is straightforward to start, and will work well for local development workflow considerations. It includes two services, the web app server and databse, a volume to persist the datastore, and a secret utilized to supply a the database password as an environment variable for the database service. 

Currently this file is left unchanged as related to several basic guides for using docker with simple web applications. Because of this, we can highlight areas for quick improvements, and opportunities for more stable support of future development actions.

Quick improvements could include the following:
 - Versioning: including an initial ```version:``` tag at the beginning of the file would greatly improve the information related to this document as development efforts continue
 - Networking: This could start as a simple improvement, by including basic custom networks to move past using the default network automatically created by docker compose. As the application matures or becomes more complex, the container network design would likely follow suit, which is an important design consideration.
 - Enhanced Volume Declaration: It's difficult to specify exactly how this could be optimized for this project as it is so simple and we are only hypothesizing how the project could grow and mature. Some considerations to align this enhancement with best practices are
    - Does this application only require read-only permissions to this volume?
    - How can we correctly configure permissions and ownership of this volumne
    - For the production environment, ensure we utilize environment variables for entries like the host path, volume name etc. and secrets where required (sensitive information).

Until this project becomes more complex, or external design considerations motivate a more built out set up for shared volumes and networks, this compose file is satisfactory for the time being. 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## CI & CD via GitHub Actions <a id="gha-cicd"></a>

To enhance the development workflow for the current scenario, an effort worth considering early-on specifically in the context of a "zero-cost mandate", is to go about localizing GHA execution, so that we can test our GHA workflows for this project without burning the free agent minutes associated with our Github account. 

Supporting utilities for this effort are namely Act, a tool created for just this purpose. A quick guide on this can be taken as follows:
 - Install Act as is best for your system
 - Utilize an existing or new GitHub PAT to configure act
   - ```act -s GITHUB_TOKEN={{GITHUB_PAT}}
 - If unsure on the initial default image size to select for your purposes, the medium image represents a good balance between size consideratios and functionality.
 - Test your Act installation by dry running an existing workflow
   - Navigate to the root of a repo directory that contains a GHA workflow within ```.github/workflows/```
   - enter ```act -n``` into the terminal, assuming your IDE or PATH values are configured correctly to utilize the tool.

Noting that Act doesn't perfectly support all features of GitHub Actions, it can serve as a great tool to save potentially costly workflow execution minutes on Github.

There will be natural limitations to the localized testing of GHA workflows, as we can't expect to install and run Act on each environment utilized for CI and CD support, but in general this can be a nice additional elements to preparing our development workflow for enhanced CICD.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## CI & CD via GitHub Actions <a id="k8s"></a>

Placeholder for write-up on current kubernetes configuration.

Quick notes:
 - variable usage
 - sensitive information
 - load balancing
 - introducing 

File link [docker-dotnet-kubernetes.yaml](docker-dotnet-kubernetes.yaml)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Final Takeaways and Long-term Considerations <a id="takeaways"></a>

With the included improvements and considerations, this project and associated workflow is in a more mature state and ready to support a more complicated app development scenario. When considering a more complex application, we can expect multiple containers for distributed microservices versus a monolithic container app, while also expecting more complex docker network configurations to accomodate these distributed services. Additionally, we should expect enhanced volume configurations to support a more complex database, and persistent datastore needs. There could potentially be a conversation regarding volumes vs bind mounts if the use case of this application or the development workflow moves in a direction where we want to specify the persistence directory outside of the ```var/lib/docker/volumes``` default, but I don't think this is likely. 

As our implementation complexity goes up, our considerations should also cover observability and monitoring of our containers and the Kubernetes instance being used to orchestrate and host the application. Maintaining application up-time, as well as critical internal service monitoring will be a key consideration.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Light-weight Production-close Orchestration  <a id="orchestration"></a>

***Under Construction***

In short, the desired solution is a resource friendly zero-cost option that puts the workflow close to a production-ready end result, hence the term "Production-close".

There are many flavors that satisfy several if not all of these contraints on the market, and there is an on-going process to choose the best option given all considerations for these example projects.

Current considerations:
 - Kind: oriented towards CI environments for testing
 - MicroK8s/Minikube: oriented towards local development on one workstation
 - K3s
 - Kubeadm
 - Docker Desktop Single Node K8s (current utilization with [docker-dotnet-kubernetes.yaml](docker-dotnet-kubernetes.yaml))
    - Noting that this wouldn't directly satisfy the "production-close" target, but it is currently the fastest implementation route that allows a step closer to a k8s-like workflow and away from bare compose or Docker Swarm support.


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- Links, etc. -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/jonathan-boyle/


