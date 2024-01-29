# dev-workspace-utilities

```bash
cekit --descriptor images/base.yaml build podman --tag image-registry.openshift-image-registry.svc:5000/dev-tools/dev-tools-base:latest
podman push image-registry.openshift-image-registry.svc:5000/dev-tools/dev-tools-base:latest

cekit --descriptor images/quarkus-angular.yaml build podman --tag image-registry.openshift-image-registry.svc:5000/dev-tools/quarkus-angular:latest
podman push image-registry.openshift-image-registry.svc:5000/dev-tools/quarkus-angular:latest
```