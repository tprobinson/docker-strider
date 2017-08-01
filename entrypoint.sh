#!/bin/sh

# Install plugins for the first time if we haven't already.
if [[ ! -z "$STRIDER_PLUGINS" && -x /.initial_plugins_installed ]]; then
  for i in $STRIDER_PLUGINS; do
    strider install -m "$STRIDER_CLONE_DEST" $i
  done
  touch /.initial_plugins_installed
fi

if [[ ! -z "$STRIDER_ADMIN_EMAIL" && -x "${STRIDER_CLONE_DEST}/.admin_user_created" ]]; then
  strider addUser -a true -l "$STRIDER_ADMIN_EMAIL" -p "$STRIDER_ADMIN_PASSWORD"
  touch "${STRIDER_CLONE_DEST}/.admin_user_created"
fi
exec node main.js
