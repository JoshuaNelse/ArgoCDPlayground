# authenticate to cloud
`gcloud auth application-default login`

setting project:
`gcloud config set project gke-learning-432615`


config kubectl (required for terraform)
`gcloud container clusters get-credentials CLUSTER_NAME \
    --region=COMPUTE_REGION`


howto for setting up cloudflare:
https://developers.cloudflare.com/cloudflare-one/tutorials/many-cfd-one-tunnel/


Configure origin TLS certs (pulled these from cloudflare)
`kubectl create -n argocd secret tls argocd-server-tls --cert <crt>.pem --key <key>.pem`
