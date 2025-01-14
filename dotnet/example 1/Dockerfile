# syntax=docker/dockerfile:1

# Base image
ARG DOTNET_VERSION=6.0
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:${DOTNET_VERSION}-alpine AS base
WORKDIR /source

# Build Stage
FROM base AS build
ARG TARGETARCH
#-- distinct copy and restore of *.csproj files
COPY src/*.csproj src/
COPY tests/*.csproj tests/
# COPY NuGet.Config ./ # included as an example for projects that may leverage a nuget.config file
RUN --mount=type=cache,id=nuget,target=/root/.nuget/packages \
    dotnet restore src/*.csproj
COPY . .
WORKDIR /source/src
RUN --mount=type=cache,id=nuget,target=/root/.nuget/packages \
    dotnet publish -a ${TARGETARCH/amd64/x64} --no-restore --use-current-runtime --self-contained false -o /app

# Test Stage
FROM base AS test
COPY --from=build /source /source
# Run unit tests
RUN dotnet test /source/tests --verbosity detailed

# Development Stage
FROM base AS development
COPY . /source
WORKDIR /source/src
CMD dotnet run --no-launch-profile

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