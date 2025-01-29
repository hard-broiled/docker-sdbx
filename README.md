<a id="readme-top"></a>

<!-- Initial ReadMe based documentation for the docker-sdbx repo. This may eventually be matured into a corresponding Wiki page on the repository. The primary result of this effort would be to showcase a created Wiki. As this isn't a collaborative project, the actual benefits of this effort are minimal, due to scale. -->

<!-- Shields Section -->
[![LinkedIn][linkedin-shield]][linkedin-url]

<div align="center">
    <h2 align="center">Docker SDBX Repository</h2>
    <p align="center">
        A non-modal repository utilized for rapid zero-cost prototyping and showcasing specific Docker, Orchestration, and CI/CD functionality with corresponding write-ups.
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
            <li><a href="#codebase-mgmt">On Codebase Management</a></li>
            <li><a href="#local-vs-cloud">Local Docker vs Cloud Orchestration Offerings</a></li>
            <li><a href="#tech-stacks">Considered Technology Stacks</a></li>
            <li><a href="#cicd-support">On CI/CD Support</a></li>
            <li><a href="#feat-branches">Highlighted Feature Branches</a></li>
        </ul>
        </li>
    </ul>
    </details>
</div>


# Overview <a id="overview"></a>

The primary purposes of this repository are currently as follows:
* Rapidly prototype, test, and showcase specific elements of Docker, k8s/Orchestration, & CI/CD support and functionality across broad SDLC and CI/CD settings
* Host write-ups related to these specific elements in SDLC & CI/CD contexts
* 'Show my process' related to creating these write-ups or documentation elements on all contained topics and technologies to give insight to my approaches and philosophies related to CI/CD, DevOps, SDLC, and other related SWE topics 

This repo and contained projects/write-ups will often straddle the line between development and operations. However, no single article is intented to expanded that position enough to fully embody DevOps. Rather, the repo as a whole will house many of these conversations that contribute towards a DevOps mindset and related approaches. 

I feel the contents of this repo target a sweet spot between distinct considerations for development and operations, and greater considerations for DevOps that is fitting for the world of "rapid prototypes" with considered routes towards mature projects and organizations that leverage best practices in both the SDLC and DevOps. 

Inteded distribution of contained efforts:
- 10% Development considerations 
- 20% Ops considerations
- 70% Comprehensive write-up & documentation

For any given feature branch or topic, the enhancement and optimization of contained CI/CD processes will be the most significant effort in the long term after the write-up/documentation of related topics has been initialized. As the full set of feature branches will cover a broad set of development technologies, this should yield a useful and demonstrative collection of conversations with optimal implementations of CI/CD for many development contexts that are utilizing Docker in the SDLC or CI/CD workflows.

Write-ups (in README form) are currently considered the primary value output of this repository and effort. 

I also note, many elements of my approach for write-ups as 'articles' needs work, I ask for forgiveness in advance on that front.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### On Codebase Management <a id="codebase-mgmt"></a>

This repo does ***not*** follow best practices for code base management. Specifically realted to modality, and feature branch management. 
* This repo will contain multiple feature branches that may not be intended for merging, but rather exist as landing points and examples for rapid projects or implementation considerations.
    * These branches will be the closest I get to 'How-Tos' in this repository
* This repo is not modal, instead containing many different projects and potential development directions to support a broader set of topics for write-ups. 

Projects and efforts contained in this repo may eventually be spun off into more mature implementations in-which code base management (and other) best practices will be followed. 
For any projects that go this route, links to the mature version will be included in this readme or related write-ups, as well as the related feature branch(es) within this repo.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Local/VM Hosted Docker Containers vs Cloud Orchestration Offerings <a id="local-vs-cloud"></a>

Implementations in this repository will initially avoid major cloud providers for deployment environments as well as docker/container related offerings, opting for smaller scale hosting scenarios. 

Currently, two considerations motivate this choice:
* The reality of this being a small scale project focused on rapid prototyping/implementation to support articles/write-ups targeting zero-cost implementation choices and minimal upfront overhead
* Avoiding obfuscation of Docker capabilities and configuration often encountered in cloud platform orchestration offerings

Eventually, write-ups will be created to reflect how similar results could be acheived via popular cloud platforms.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Considered Technology Stacks <a id="tech-stacks"></a>

Some quick taxonomy related to this project. 
 - Technology specific directories
    - These directories will house containerization and orchestration examples for example applications in the mentioned tech stack
    - Contained README files will explore how the SDLC could look while utilizing these example containerization/orchestration files
    - Brief example of this organizational model:
    ```
        - dotnet/
            - Dockerfile
            - k8s.yml
            - compose.yml
            - README.md write-up on example dotnet centric SDLC leveraging included files
        - python/
            - Dockerfile
            - k8s.yml
            - compose.yml
            - README.md write-up on example python centric SDLC leveraging included files
    ```
 - Topic specific directories
    - More conversationally oriented as there isn't a single implied tech stack for these topics
    - Each topic will likely contain sub-topics with write-ups for local/environment tooling, utility set-up etc. as is found to be necessary to support more comprehensive coverage of the topic
    - There will also be specific technologies that come up within certain topics (devops/CI/Docker) to facilitate specific use case considerations for that technology within that topic 

The below list of specific development technologies and related conversations to be targeted will grow over time. Currently it includes (in no particular order):
* .NET/C#
* Javascript
* Python
* C++

Currently considered additions to this topic list:
* Go
* Typescript
* FastAPI vs Flask vs Django Considerations
* Minimal API vs MVC Considerations
* DB providers and Volume Considerations (sqlite, postgres, MongoDB, SQL vs NoSQL)
* Front End & Back End Orchestration

***Please note!***
Several of the contained app/feature codebases are not my own work. They have been pulled from example repositories or tutorials related to the primary technologies contained in the related projects & feature branches. These were leveraged to decrease the turn-around time for creating viable Docker images/containers in more development contexts.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### On CI/CD Support <a id="cicd-support"></a>

Following the previous statement regarding zero-cost implementations, GitHub and GHA are initially targeted as the repository host and CI/CD vendors. 

The primary consideration for CI has been ensuring each feature branch can produce functional Docker Images/Containers for the contained code bases. Any contained GHA pipelines will be set to trigger on successful merges to the contained feature branch only. Once more mature zero-cost deployment environment infrastructure has been set up related to this project, these containers will be deployed to small but scalable k8s instances within said environment(s).  

As mentioned previously, enhancement and optimization of the CI process will be targeted in the long term after write-ups related to the contents of each feature/topic branch have been initialized.

In a similar vein, CD capabilities will be targeted in the long term after initial articles or write-ups are completed. The initial efforts in this area will be exploring smaller scale orchestration implementations to keep things light and quick and to stay true to the comprehensive zero-cost approach mentioned above. There will be room for growth into more mature service providers for stability and CD-specific reproducibility and configuration, ideally targeting expectations found in larger organizations. Similarly, there will be efforts put towards growth into other CD areas including observability, monitoring, security, scalability, distribution, etc. 
As the current goal isn't targeting public facing CD, it hasn't been prioritized at this time. 

* __On Azure offerings__: 
It should be noted that there are free-tier options that allow for repo hosting and CI/CD within Azure. In some scenarios these *may* simplify processes mentioned in contained write-ups including CI/CD, supporting apps/project still leveraging Docker and k8s. 
At a later date, write-ups covering the use of Azure and other major cloud providers for related efforts will be produced.
Initial efforts prioritize the goal of rapidly prototyping *unobfuscated* Docker functionality. ... *and*, I've used my free Azure trial credits previously. Juggling VMs to work with custom pipeline agents alongside k8s instances can be a pain when targeting zero-cost.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Highlighted Feature Branches <a id="feat-branches"></a>

Below are the currently highlighted feature branches for consideration. Please note each will have it's own readme to further emphasize important details or considerations of the effort, as well as takeaways and routes for improvement/maturation of a related project or effort utilizing the contained technologies.

 - [.Net Docker Example][.net-feature-url]
 - [Javascript Docker Example][jscript-feature-url]
 - [Python Docker Example][python-feature-url]
 - [C++ Docker Example][cpp-feature-url]


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- Links, etc. -->
[.net-feature-url]: https://github.com/hard-broiled/docker-sdbx/tree/feature/dotnet-docker-example
[cpp-feature-url]: https://github.com/hard-broiled/docker-sdbx/tree/feature/cpp-docker-example
[jscript-feature-url]: https://github.com/hard-broiled/docker-sdbx/tree/feature/javascript-docker-example
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/jonathan-boyle/
[python-feature-url]: https://github.com/hard-broiled/docker-sdbx/tree/feature/python-docker-example
