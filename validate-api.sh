docker run -v $(pwd):/repo node:latest bash -c "cd /repo && yarn run validate && yarn prettier --check openapi.yaml"
