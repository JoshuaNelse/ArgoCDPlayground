# authenticate to cloud
`gcloud auth application-default login`

setting project:
`gcloud config set project gke-learning-432615`


config kubectl (required for terraform)
`gcloud container clusters get-credentials CLUSTER_NAME \
    --region=COMPUTE_REGION`
