spin up a cluster

```
eksctl create cluster \
--name prod \
--version 1.14 \
--region us-east-2 \
--nodegroup-name standard-workers \
--node-type t3.medium \
--nodes 2 \
--nodes-min 1 \
--nodes-max 4 \
--ssh-access \
--ssh-public-key aneesh.pem \
--managed
```

delete the cluster

```
eksctl delete cluster \
--name prod \
--region us-east-2
```

- create a image using the Dockerfile and push it to the docker registory or try ci in docker by adding git endpoint

- Deploy the website pods and expose it via LoadBalancer service