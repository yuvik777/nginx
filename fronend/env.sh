#!/bin/bash

# (1) Recreate config file 
rm -rf ./env-config.js
touch ./env-config.js

# (2) Add assignment 
echo "window._env_ = {" >> ./env-config.js

# (3) Read each line in .env file
# Each line represents key=value pairs
while read -r line || [[ -n "$line" ]];
do
  # (4) Split env variables by character `=`
  if printf '%s\n' "$line" | grep -q -e '='; then
    varname=$(printf '%s\n' "$line" | sed -e 's/=.*//')
    varvalue=$(printf '%s\n' "$line" | sed -e 's/^[^=]*=//')
  fi

  # Read value of current variable if exists as Environment variable
  value=$(printf '%s\n' "${!varname}")
  # Otherwise use value from .env file
  [[ -z $value ]] && value=${varvalue}
  
  # (5) Append configuration property to JS file
  echo "  $varname: \"$value\"," >> ./env-config.js
done < .env

# (6)
echo "}" >> ./env-config.js