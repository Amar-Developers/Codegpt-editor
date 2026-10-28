#!/usr/bin/env bash
# Code GPT: run a build step, and if it fails, put its last lines in a GitHub annotation so the error is readable
# from the run summary (without downloading the full log). Usage: ./build/codegpt_run.sh <command> [args...]
LOG="$( mktemp )"
set -o pipefail
"$@" 2>&1 | tee "${LOG}"
code=${PIPESTATUS[0]}
if [[ ${code} -ne 0 ]]; then
  tail_text="$( grep -v '^\s*$' "${LOG}" | tail -n 40 | cut -c1-300 )"
  tail_text="${tail_text//'%'/'%25'}"; tail_text="${tail_text//$'\r'/}"; tail_text="${tail_text//$'\n'/'%0A'}"
  echo "::error title=$1 failed (exit ${code})::${tail_text}"
fi
rm -f "${LOG}"
exit ${code}
