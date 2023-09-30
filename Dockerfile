# syntax=docker/dockerfile:1
FROM ubuntu:latest
RUN apt update && apt install -y g++
WORKDIR /opt/docker-cxx-on-ubuntu
COPY . .
