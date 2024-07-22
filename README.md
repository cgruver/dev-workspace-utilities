# dev-workspace-utilities

```bash
cekit --descriptor images/base.yaml build podman --tag image-registry.openshift-image-registry.svc:5000/devspaces-images/dev-tools-base:latest

cekit --descriptor images/quarkus-angular-node20-java21.yaml build podman --tag image-registry.openshift-image-registry.svc:5000/devspaces-images/quarkus-angular:latest

cekit --descriptor images/nested.yaml build podman --tag image-registry.openshift-image-registry.svc:5000/devspaces-images/nested:latest

cekit --descriptor images/nested.yaml build podman --tag quay.io/cgruver0/che/nested:latest

cekit --descriptor images/nested-fedora.yaml build podman --tag quay.io/cgruver0/che/nested-fedora:latest

cekit --descriptor images/nested-userns.yaml build podman --tag quay.io/cgruver0/che/nested-userns:latest

cekit --descriptor images/quarkus-super-heroes.yaml build podman --tag quay.io/cgruver0/che/dev-workspace-quarkus-super-heroes:latest

cekit --descriptor images/quarkus-angular-node20-java21.yaml build podman --tag quay.io/cgruver0/che/quarkus-angular-node20-java21:latest

cekit --descriptor images/quarkus-angular-node18-java17.yaml build podman --tag quay.io/cgruver0/che/quarkus-angular-node18-java17:latest

cekit --descriptor images/node20.yaml build podman --tag quay.io/cgruver0/che/node20-dev-tools:latest
```
