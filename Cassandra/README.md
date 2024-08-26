# Cassandra Test

```bash
cat << EOF | oc apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: cassandra
  namespace: cassandra-test
spec:
  containers:
  - name: cassandra
    image: quay.io/cgruver0/che/cassandra:4.1.6
    command: ["tail"]
    args: ["-f", "/dev/null"]
    imagePullPolicy: Always
EOF
```
