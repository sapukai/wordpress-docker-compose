#!/bin/bash

# Get arguments
for ARGUMENT in "$@"; do
  KEY=$(echo $ARGUMENT | cut -f1 -d=)
  VALUE=$(echo $ARGUMENT | cut -f2 -d=)

  case "$KEY" in
  --url) URL=${VALUE} ;;
  --title) TITLE=${VALUE} ;;
  --admin_email) ADMIN_EMAIL=${VALUE} ;;
  --lang) LOCALE=${VALUE} ;;
  *) ;;
  esac
done

# Wait a little in case the db or the wp container are not quite there yet
sleep 60

# Check if WordPress is not installed
if ! wp core is-installed; then
  # Install WordPress
  wp core install --path=/var/www/html --url=${URL} --title=${TITLE} --admin_user=admin --admin_password=admin --admin_email=${ADMIN_EMAIL}

  # Delete bundled plugins
  wp plugin delete hello akismet

  # Change language
  wp language core install $LOCALE
  wp site switch-language $LOCALE

  # Install theme

  # Set the front page

  # Change permalinks structure

  # Install plugins
fi
