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
    - GHA
    - ArgoCD
    - Jenkins consideration
    - Azure ADO
 - CI Pipelines
    - Image Build: build and push to registries, best practices for security, scanning, fingerprinting, private registries
        - Image build and registry push
            - Security scanning/hardening
                - Docker bench
                - Docker scap
                - Prometheus
    - Application build & unit testing
                
 - CD Pipelines
    - Orchestration service
 - Azure deployments of applications
    - IaC considerations
    - Use cases for the following:
        - ACA
        - ACI
        - AKS
        - WebApps/Function Apps
 - VM Focused Deployment Workflow
    - Deployment Workflow Node with necessary tooling (docker engine, orchestration, monitoring/visibility considerations, etc.)
        - Non-prod vs prod considerations
 - 'Development' environment deployment support, initial example for full workflows  
 - IaC Considerations
    - VM stability
        - IaC tooling selection, Config as Code selection
            - Terraform/Ansible pairing
            - ARM templates
            - Blending others
 - Continuing conversations
    - DinD use cases
    - KinD use cases 

    


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- Links, etc. -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/jonathan-boyle/