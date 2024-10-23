# Using Red Hat entitlements for container builds

## Extract the entitlements files from your OpenShift Cluster:

__Note:__ This step requires Cluster Admin Privileges

```bash
mkdir ./entitlement
oc get secret etc-pki-entitlement -n openshift-config-managed -o jsonpath={".data.entitlement-key\.pem"} | base64 -d > ./entitlement/entitlement-key.pem
oc get secret etc-pki-entitlement -n openshift-config-managed -o jsonpath={".data.entitlement\.pem"} | base64 -d > ./entitlement/entitlement.pem
```

## Use the entitlements for a container build:

```bash
cat << EOF > ./Containerfile
FROM quay.io/devfile/base-developer-image:ubi9-latest

USER 0

RUN dnf install -y xorg-x11-server-Xvfb
```

```bash
podman build -v ${PWD}/entitlement:/etc/pki/entitlement:Z  -t test:test -f Containerfile .
```
