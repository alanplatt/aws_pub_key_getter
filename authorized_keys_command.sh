#!/bin/bash -e
# Get active public keys for specified user
#

if [ -z "$1" ]; then
  exit 1
fi

username="$1"

aws iam list-ssh-public-keys --user-name "${username}" --query "SSHPublicKeys[?Status == 'Active'].[SSHPublicKeyId]" --output text | while read KeyId; do
  aws iam get-ssh-public-key --user-name "${username}" --ssh-public-key-id "$KeyId" --encoding SSH --query "SSHPublicKey.SSHPublicKeyBody" --output text
done
