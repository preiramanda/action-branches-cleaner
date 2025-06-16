#!/bin/env bash

cleanup::delete_unmerged_branches() {
  local not_merged_prs=$1

  for branch in $not_merged_prs; do
    if [[ " ${BASE_BRANCHES[*]} " == *" $branch "* ]]; then
      echo "Branch protected or listed to be skipped: $branch"
      continue
    fi

    echo "Deleting not merged branch: $branch"
    github::delete_branch "$branch"
  done
}

cleanup::delete_inactive_branches() {
  local days_inactive=$1
  local inactive_branches=$(github::get_inactive_branches "$days_inactive")

  for branch in $inactive_branches; do
    if [[ " ${BASE_BRANCHES[*]} " == *" $branch "* ]]; then
      echo "Branch protected or listed to be skipped: $branch"
      continue
    fi

    echo "Deleting inactive branch: $branch"
    github::delete_branch "$branch"
  done
}
