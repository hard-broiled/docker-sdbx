<a id="readme-top"></a>

<!-- Shields Section -->
[![LinkedIn][linkedin-shield]][linkedin-url]

<div align="center">
    <h2 align="center">Docker SDBX Repository</h2>
    <p align="center">
        A non-modal repository utilized for rapid prototyping and testing of specific Docker functionality and corresponding GHA CI support.
    </p>
</div>


<!-- TABLE OF CONTENTS -->
<div>
    <details>
    <summary>Table of Contents</summary>
    <ol>
        <li>
        <a href="#overview">Project Overview</a>
        <ul>
            <li><a href="#codebase-mgmt">On Codebase Management</a></li>
            <li><a href="#local-vs-cloud">Local Docker vs Cloud Orchestration Offerings</a></li>
            <li><a href="#tech-stacks">Considered Technology Stacks</a></li>
            <li><a href="#cicd-support">On CI/CD Support</a></li>
        </ul>
        </li>
    </ol>
    </details>
</div>
<br />


# Overview <a id="overview"></a>

The two primary purposes of this repository are as follows:
1. Rapidly prototype, test, and showcase Docker support and functionality across broad development and deployment settings
2. Rapidly test and prototype GHA support for these Docker scenarios

This repo and contained projects straddle the line between development and operations, without expanding that position enough to fully embody DevOps simply due to a contained scale. I feel it is targeting a sweet spot between the development/ops and DevOps that is fitting for the world of "personal rapid prototypes" in an experimental way. 

I would describe this repo and contained efforts as 
- 10% Development considerations 
- 20% Ops considerations
- 70% Comprehensive documentation considerations.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### On Codebase Management <a id="codebase-mgmt"></a>

This repo does ***not*** follow best practices for code base management. Specifically realted to modality, and feature branch management. 
This repo will contain multiple feature branches that are not intended to be pushed, but rather exist as landing points and examples for rapid projects or implementation considerations. 
It will also not be modal, instead containing many different projects and potential development directions. 

Projects and efforts contained in this repo may eventually be spun off into more mature implementations in-which code base (and other) best practices will be followed. 
For any projects that go this route, links to the mature version will be included in this readme, as well as the related feature branch(es) within this repo.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Local Docker vs Cloud Orchestration Offerings <a id="local-vs-cloud"></a>

Implementations in this repository intentionally avoids any major cloud providers, opting for smaller scale hosting scenarios. 

The low level influence for this choice is the reality of this being a small scale project focused on rapid prototyping/implementation mandating zero-cost implementation choices and minimal upfront overhead.

The higher level motivation is to avoid any obfuscation of Docker capabilities or features often encountered in cloud platform orchestration offerings.

Eventually, documentation will be updated to reflect how similar end results could be acheived via popular cloud platforms such as Azure, AWS, DigitalOcean etc.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Considered Technology Stacks <a id="tech-stacks"></a>

Some quick taxonomy related to this project. 
 - "Project Technologies"
    - All technologies included for any given feature branch or related project. This is meant to include the tech stack utilized in the contained app or feature, as well as any containerization or orchestration technologies utilized up to and including CI support for that project.
 - "Development Technologies"
    - The tech stack of the contained app/feature for a given feature branch 

Primary development technologies to be targeted at this time (in no particular order) will include dotnet/C#, Python, Go, and C++ while also considering additional front-end specific technologies. This should be considered a living list.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### On CI/CD Support <a id="cicd-support"></a>

Following the previous statement regarding zero-cost implementations, GitHub and GHA were chosen as the repository host and CI/CD support vendors. 

CI has been prioritized for each feature branch to support the ability to produce related and successful Docker Images for the contained code bases.

In this scenario, "CD" won't be fully built out in many aspects. The initial purpose will be targeting smaller scale orchestration implementations (k3s w/ docker backend etc.) to keep things light and quick. There is room for growth into more mature service providers (ArgoCD, Ansible, etc.) for stability and CD-specific reproducibility and configuration. In the sem vein, there is immense room for growth into other CD areas including observability, monitoring, security, scalability, distribution, etc. 
As the current goal isn't targeting public facing CD, it hasn't been prioritized at this time. 

It should be noted that there are free-tier options that allow for repo hosting and CI/CD within Azure. These would of course simplify much of the burden, especially within CI/CD, regarding a more mature implementation of supporting any app/project via Docker and k8s. 
The initial project support overhead for these routes at this time doesn't fit with the goal of rapidly prototyping unobfuscated Docker functionality. Also, I've used my free azure trial credits years ago, and working around that is a pain for this scale of project.
Also, juggling deployment agents, and k8s implementations on the Azure free tier is not a useful exercise for something of this scale.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- Links, etc. -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/jonathan-boyle/