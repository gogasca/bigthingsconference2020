#!/bin/bash -u

NOTEBOOK_FILE_NAME="${1}"
SCALE_TIER="${2}"
CONTAINER_URI="${3}"

NOTEBOOK_GCS_PATH="gs://news-ml-experiments/${NOTEBOOK_FILE_NAME}"
NOTEBOOK_OUT_GCS_PATH="gs://news-ml-experiments/out-${NOTEBOOK_FILE_NAME}"

gsutil cp "${NOTEBOOK_FILE_NAME}" "${NOTEBOOK_GCS_PATH}"

UUID=$(cat /proc/sys/kernel/random/uuid)
JOB_NAME=$(echo "notebook-executor-${UUID}" | tr '-' '_')
REGION="us-central1"

gcloud ai-platform jobs submit training "${JOB_NAME}" \
  --region "${REGION}" \
  --scale-tier "${SCALE_TIER}" \
  --master-image-uri "${CONTAINER_URI}" \
  --stream-logs \
  -- nbexecutor \
  --input-notebook "${NOTEBOOK_GCS_PATH}" \
  --output-notebook "${NOTEBOOK_OUT_GCS_PATH}"
  
echo "Notebooks result: ${NOTEBOOK_OUT_GCS_PATH}"

if [[  $(gcloud ai-platform jobs describe "${JOB_NAME}" | grep "SUCCEEDED") ]]; then
    exit 0
else
    echo -e "Job failed" && exit 1
fi
