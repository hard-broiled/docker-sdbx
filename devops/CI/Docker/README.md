<a id="readme-top"></a>

<!-- Shields Section -->
[![LinkedIn][linkedin-shield]][linkedin-url]

<div align="center">
    <h2 align="center">Continuous Integration for Containerized Applications with Docker</h2>
    <p align="center">
        Guideline conversation to pursue CI best practices for maintaining custom docker images for containerized application development.
    </p>
</div>


<!-- TABLE OF CONTENTS -->
<div>
    <details>
    <summary>Table of Contents</summary>
    <ul>
        <li>
        <a href="#overview">Context Overview</a>
        <ul>
            <li><a href="#image b&p">CI for Docker Image Build/Push</a></li>
            <li><a href="#app b&ut">CI for Application Build & Unit Testing</a></li>
            <li><a href="#branch policy">Branch Policy Considerations</a></li>
        </ul>
        </li>
    </ul>
    </details>
</div>


# Overview <a id="overview"></a>

At a high level, the primary focus of this conversation is to target creating CI pipelines that will allow us to rapidly achieve build and push functionality for custom docker images. In addition to this, we want to ensure that these efforts start with considerations for long-term best practices to bake in mature CI/CD practices into development workflows as early as possible. Ideally we can endeavour to avoid the all too common enterprise maturation growth pain that is fully refactoring CI/CD practices that were implemented early on when rapid product releases were prioritized over all else.

This article is by no means a fully comprehensive conversation on included or mentioned topics. Additional resources will be provided throughout as are relevant and available.

A brief list of considerations for CI pipeline topics is provided here for now, with expectations of additions in the future:

 - Image Build: build and push to registries, best practices for security, scanning, fingerprinting, private registries
    - Security scanning/hardening
        - Docker bench
        - Docker scap
        - Prometheus/Grafana integrations
 - Application build & unit testing
 - Branching policies to ensure all security requirements are met before merging into shared contexts


<p align="right">(<a href="#readme-top">back to top</a>)</p>


### CI for Docker Image Build/Push <a id="image b&p"></a>
- Image Build: build and push to registries, best practices for security, scanning, fingerprinting, private registries
    - Security scanning/hardening
        - Docker Bench
        - Docker SCAP (not a trivial process)
        - Docker Scout
        - Prometheus/Grafana Considerations

#### Base Functionality

At it's core, a CI pipeline for custom docker images should ensure that the dockerfile is built to update the image with any changes from recent development actions, and push the resultant image to a known registry.
This sort of basic pipeline can be easily and quickly set up within GitHub Actions and Azure Devops. The actions for each provider are included below:
- GHA:
    - docker/login-action@v3
    - docker/setup-buildx-action@v6
    - docker/build-push-action@v6
- ADO:
    - Docker@2
If adhering to best practices was that simple, everyone would do it. So let's expand the needs of these basic CI scenarios to create more mature pipelines.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### A Better Framework

Let me start this sections by acknowledging the write up on SCAP integration into CI processes by [Craig Andrews.](craig-andrews-scap-writeup)
Not only does Craig's write-up contain excellent information, we can also map the situation we are addressing to the use-case of his work quite well. Since we seek to solve as general a use case as possible, leveraging linux-based execution environments within GHA and ADO will yeild maximum coverage when looking to leverage SCAP in particular.

One consideration that can be taken at the start of this process is that we can leverage multiple CI pipelines to own different parts of this stage of the process. This isn't a mandatory design choice, but it's something that can allow for more precise process controll down the road.

Some quick improvements we can make to this image build pipeline include the following consideration points:
- Trigger on push 
    - We want to leverage an early stage of the development workflow to kick off testing, scanning, etc. to ensure that we can support merge requirements when we are considering merging 'completed' code to the collaboration branch.
- Utilization of container scan/testing steps in the 'feature push' pipeline
    - Docker Bench
    - Docker SCAP (not a trivial process)
    - Docker Scout
    - Executing contained unit tests within the application/docker image
- Distinct processes for requirements management on merge request into collaboration branch
- Using build packages with standardized names
- Consideration for multiple CI pipelines for different stages of the process
    - We can consider a design that has multiple pipelines or independent stages of functionality that trigger at different parts of the development workflow and codebase management processes to isolate responsibilities in the CI process and allow for more precise control
        - Examples:
            - CI on Push to feature branches
                - Instigates test, scan, style standards, etc. pass/fail with feed back
                - Injection point for pre-commit/pre-push functionality
            - CI on merge request to collaboration branch
                - Validation that all requirements have passed
                - Allows for specific use-case considerations to be prioritized 
                    - SCAP scans for industry specific compliance
    
*Note:* For the following sections, we presume that the CI running environment is configured correctly to allow for any mentioned additional utilities to be utilized. Additional conversation on setting up CI environments for those utilities may follow in this or other write-ups in the future.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


#### Trigger on Push with Filtering Considerations
```
on:
  - push
```

The trigger filter can be as simple as the above if we want to ensure this pipeline runs for any push actions in the repository. There are always more options for creating more specific filters for something like feature branches and other conditional situations. Those can be accomodated as the project evolves, but for now a broader net at this step of the pipeline is a good starting configuration.


<!-- Some potential assumptions for this section could include the below list. These assumptions could be a part of a separate conversation that wil be saved for a different time. 
These assumptions include:
 - Standardized feature branch naming patterns 
    - Quick Example: feature/dockerfile_app-name_work-item
 - Standardized Dockerfile directory patterns
    - Dockerfiles are always placed at the root directory, or a known location to support directory location filtering
        - Quick non-root Example: ```/Docker/Dockerfile``` -->


#### Utilization of Container Scan/Testing steps in the 'feature push' pipeline
 - Leverage Docker Bench
    - optimizing the script
 - Leverage SCAP steps for security hardening
 - Leverage Docker Scout for scanning, considerations on usage scenarios

##### Granular Permissions
- Limit permissions for the pipeline jobs etc. to support least-priviliges



<p align="right">(<a href="#readme-top">back to top</a>)</p>




### CI for Application Build & Unit Testing <a id="app b&ut"></a>



<p align="right">(<a href="#readme-top">back to top</a>)</p>





### Branch Policy Considerations <a id="branch policy"></a> 



<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- Links, etc. -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/jonathan-boyle/
[craig-andrews-scap-writeup]: https://candrews.integralblue.com/2023/09/scap-security-and-compliance-scanning-of-docker-images-in-github-actions-and-gitlab-ci/#implementation




