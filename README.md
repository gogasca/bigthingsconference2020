# Notebooks Continuos Integration Demo 

This project shows how to test Jupyter Notebooks in a Github repository.
Using [Cloud Build](https://cloud.google.com/cloud-build/) for changes commited to this repo. The following workflow will be triggered.

1. Download pip installer for [gcloud-notebook-training](https://pypi.org/project/gcloud-notebook-training/)
2. Launch an AI Platform Training job running each of the Notebooks in the /notebooks folder
3. Use a [Deep Learning container](https://cloud.google.com/ai-platform/deep-learning-containers/) using Notebooks metadata and use this container as source for the AI Platform Training job
4. Report results into GCS bucket.

Big Things Conference Demo Spain 2020
