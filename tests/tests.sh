#!/usr/bin/env bash
set -Eeuo pipefail

INPUT_BUCKET=s3://input
OUTPUT_BUCKET=s3://output
SLEEP_TIME=30
DATASETS_DIR=/tests/datasets
UPLOAD_DATASETS=false
export AWS_DEFAULT_REGION=us-east-1

trap 'terminate_gracefully' SIGINT

function usages() {
  cat <<EOM
usage: $(basename "$0") OPTIONS

OPTIONS:
  [-i|--input <bucket>]     default: $INPUT_BUCKET
  [-o|--output <bucket>]    default: $OUTPUT_BUCKET
  [-s|--sleep-time <num>]   default: $SLEEP_TIME
  [-r|--region <region>]    default: $AWS_DEFAULT_REGION
  [-d|--dataset-dir]        default: $DATASETS_DIR
  [-u|--upload-datasets]    default: $UPLOAD_DATASETS
EOM
  exit 0
}

function arg_parse() {
  while [ $# -gt 0 ]; do
    case "$1" in
    -i | --in)
      INPUT_BUCKET="$2"
      shift
      ;;
    -o | --out)
      OUTPUT_BUCKET="$2"
      shift
      ;;
    -s | --sleep-time)
      SLEEP_TIME="$2"
      shift
      ;;
    -r | --region)
      AWS_DEFAULT_REGION="$2"
      shift
      ;;
    -d | --datasets-dir)
      DATASETS_DIR="$2"
      shift
      ;;
    -u | --upload-datasets)
      UPLOAD_DATASETS=true
      ;;
    -h | --help | *)
      usages
      ;;
    esac
    shift
  done
}

function print_args() {
  cat <<EOM
----------------------------------------
INPUT_BUCKET=$INPUT_BUCKET
OUTPUT_BUCKET=$OUTPUT_BUCKET
DATASETS_DIR=$DATASETS_DIR
AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
UPLOAD_DATASETS=$UPLOAD_DATASETS
----------------------------------------
EOM
}

function print() {
  echo "$(date +%Y-%m-%dT%H:%M:%S%z) $1"
}

function check_aws() {
  if ! command -v aws &>/dev/null; then
    print "AWS CLI is missing"
    exit 1
  fi

  if ! aws sts get-caller-identity --output text --query Arn &>/dev/null; then
    print "AWS CLI is not working for you"
    exit 1
  fi
}

function sync_datasets() {
  if [ ! -d "$DATASETS_DIR" ]; then
    print "$DATASETS_DIR is missing"
    exit 1
  fi
  print "Synching datasets to $INPUT_BUCKET bucket"
  aws s3 sync "$DATASETS_DIR" "$INPUT_BUCKET" --quiet --only-show-errors
}

function tests() {
  print "[Test] Checking existence of files in the correct location"
  print "[Test] non-PII files"
  local filename
  for file in "$DATASETS_DIR/sample"*; do
    if [ -f "$file" ]; then
      filename=$(basename "$file")
      if ! aws s3 ls "$OUTPUT_BUCKET/$filename" &>/dev/null; then
        print "[FAILED] File $filename does not exist in the outgoing bucket $OUTPUT_BUCKET"
        exit 1
      else
        print "[PASSED] File $filename exists in the correct location."
      fi
    fi
  done

  print "[Test] PII files"
  for file in "$DATASETS_DIR/pii"*; do
    if [ -f "$file" ]; then
      filename=$(basename "$file")
      if ! aws s3 ls "$INPUT_BUCKET/blocked/$filename" &>/dev/null; then
        print "[FAILED] File $filename does not exist in '/blokced'"
        exit 1
      else
        print "[PASSED] File $filename exists in the correct location."
      fi
    fi
  done
}

function remove_files() {
  print "Removing the files"
  aws s3 rm "$INPUT_BUCKET/" --recursive --quiet --only-show-errors
  aws s3 rm "$OUTPUT_BUCKET/" --recursive --quiet --only-show-errors
}

function terminate_gracefully() {
  print "Handling SIGINT"
  print ""
  print "Trying to terminate gracefully"
  remove_files
  print "Terminating"
  exit 0
}

function main() {
  arg_parse "$@"
  print_args
  check_aws
  if [ "$UPLOAD_DATASETS" = true ]; then
    sync_datasets
  else
    print "Going to sleep for $SLEEP_TIME seconds"
    sleep "$SLEEP_TIME"
    tests
  fi
}

main "$@"
