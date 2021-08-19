#!/bin/sh

####
# Shell script to build container stack
#
docker-compose build kong
docker-compose up -d kong-db
docker-compose run --rm kong kong migrations bootstrap
docker-compose run --rm kong kong migrations up
docker-compose up -d kong

####
# Quick sanity check option
#
docker-compose ps
curl -s http://localhost:8001 | jq .plugins.available_on_server.oidc

####
# Start konga
#
docker-compose up -d konga

####
# Wait for Konga to finish startup
#
sleep 2m
docker-compose up -d keycloak-db
docker-compose up -d keycloak
docker-compose ps
