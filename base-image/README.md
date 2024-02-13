# Create Local Image Streams

```bash
oc new-project devspaces-images
oc policy add-role-to-group system:image-puller system:serviceaccounts -n devspaces-images
oc import-image ubi-minimal:latest --from=registry.access.redhat.com/ubi9/ubi-minimal:latest --confirm -n devspaces-images
oc apply -f base-image/base-image.yaml
```
