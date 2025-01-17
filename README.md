<a id="readme-top"></a>
<!-- docker-python-example 
Python codebase pulled from Docker example guide
-->

<!-- Shields Section -->
[![LinkedIn][linkedin-shield]][linkedin-url]

<div align="center">
    <h2 align="center">Python Dockerized Workflow Example w/ Notes on Optmization</h2>
    <p align="center">
        Feature branch utilized for rapid prototyping and testing of Python specific Docker functionality, with emphasis on optimized CI practices and corresponding GHA CI support.
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

Topic notes:
 - .venv and dev docker container workflow discussion
 - Dockerfile considerations 
    - emphasis on performance currently, route for future growth, docker init handles this simple case well
 - Compose file considerations
    - similar to dockerfile; end of road for compose vs orchestration
 - Prod workflow considerations for handling secrets etc.
 - K8s files Considerations
    - Why 2
    - Optimizing


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- Links, etc. -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/jonathan-boyle/

The contained application is a simple Python web application pulled from [Docker Docs](https://docs.docker.com/language/python/containerize/).
Initial versions of Docker related files generated via ```docker init```