# dev-workspace-utilities

```bash
cekit --descriptor images/base.yaml build podman --tag image-registry.openshift-image-registry.svc:5000/devspaces-images/dev-tools-base:latest
podman push image-registry.openshift-image-registry.svc:5000/devspaces-images/dev-tools-base:latest

cekit --descriptor images/quarkus-angular-node20-java21.yaml build podman --tag image-registry.openshift-image-registry.svc:5000/devspaces-images/quarkus-angular:latest
podman push image-registry.openshift-image-registry.svc:5000/devspaces-images/quarkus-angular:latest

cekit --descriptor images/nested.yaml build podman --tag image-registry.openshift-image-registry.svc:5000/devspaces-images/nested:latest
podman push image-registry.openshift-image-registry.svc:5000/devspaces-images/nested:latest

cekit --descriptor images/nested.yaml build podman --tag quay.io/cgruver0/che/nested:latest
podman push quay.io/cgruver0/che/nested:latest
```
