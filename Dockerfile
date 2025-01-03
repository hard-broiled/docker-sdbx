# syntax=docker/dockerfile:1

# Build Stage
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build
ARG TARGETARCH
COPY . /source
WORKDIR /source/src
# Verifying targetarch resolution value
RUN echo "TARGETARCH is: ${TARGETARCH}" 
RUN echo "Resolved architecture: ${TARGETARCH/amd64/x64}"
RUN --mount=type=cache,id=nuget,target=/root/.nuget/packages \
    dotnet restore \
    && dotnet publish -a ${TARGETARCH/amd64/x64} --no-restore --use-current-runtime --self-contained false -o /app
RUN dotnet test /source/tests

# Development Stage
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS development
COPY . /source
WORKDIR /source/src
CMD dotnet run --no-launch-profile

# Live Stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine AS final
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