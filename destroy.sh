#!/bin/bash
set -e

cd monitoring && docker compose down && cd ..
cd terraform && terraform destroy -auto-approve && cd ..

echo "==> Everything torn down."
