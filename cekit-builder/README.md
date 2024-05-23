# Create Local Image Streams

```bash
oc new-project devspaces-images
oc policy add-role-to-group system:image-puller system:serviceaccounts -n devspaces-images
oc import-image ubi-minimal:latest --from=registry.access.redhat.com/ubi9-minimal:latest --confirm -n devspaces-images
oc apply -f cekit-builder/cekit-builder.yaml
oc start-build cekit-builder -n devspaces-images -w -F
```
