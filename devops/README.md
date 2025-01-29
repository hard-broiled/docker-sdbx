<a id="readme-top"></a>

<!-- Shields Section -->
[![LinkedIn][linkedin-shield]][linkedin-url]

<div align="center">
    <h2 align="center">Considerations for Dockerized Development Workflows for Modern DevOps Contexts</h2>
    <p align="center">
        Feature branch utilized for rapid prototyping and testing of components for conversations on DevOps focused Containerization, Container Orchestration, CI/CD, Best Practices and more.
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
            <li><a href="#construc">Under Construction</a></li>
        </ul>
        </li>
    </ul>
    </details>
</div>


# Overview <a id="overview"></a>

README is currently **Under Construction**

Considerations for the following topics (un-ordered):
 - CI & CD platforms
    - GHA (overview, separate article)
    - ArgoCD (overview, later separate article)
    - Jenkins consideration (overview, later separate article)
    - Azure ADO (overview, separate article)
 - CI Pipelines
    - Image Build: build and push to registries, best practices for security, scanning, fingerprinting, private registries
        - Image build and registry push
            - Security scanning/hardening
                - Docker bench & scout conversation
                - SCAP options
                - Prometheus
    - Application build & unit testing
                
 - CD Pipelines
    - Orchestration service
        - compose/swarm for single vendor considerations
        - k3s overview (IoT emphasis)
        - k8s
 - Azure deployments of applications
    - IaC considerations
    - Use cases for the following:
        - ACA
        - ACI
        - AKS
        - WebApps/Function Apps
        - Overview on cloud provider options vs customized docker workflows with directly managed orchestration
 - VM Focused Deployment Workflow
    - Deployment Workflow Node with necessary tooling (docker engine, orchestration, monitoring/visibility considerations, etc.)
        - Non-prod vs prod considerations
        - Major providers vs not; freeware considerations
 - 'Development' environment deployment support, initial example for full workflows
    - starting with conversations on Azure hosting; freeware for local quick set up; AWS
 - IaC Considerations
    - VM stability
        - IaC tooling selection, Config as Code selection
            - Terraform/Ansible together and separate
            - ARM templates
 - Continuing conversations
    - DinD considerations
    - KinD considerations (freeware deployment node amongst other scenarios)

    


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- Links, etc. -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/jonathan-boyle/