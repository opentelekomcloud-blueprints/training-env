#!/bin/bash
#set +e
set +x

eval "$(jq -r '@sh "OTC_MYUSER=\(.username) OTC_MYPW=\(.password) OTC_MYDOMAIN=\(.domain) OTC_MYPROJECTID=\(.project)" ')"

function check_deps() {
  test -f $(which jq) || error_exit "jq command not detected in path, please install it"
}


function jsonValue() {
  KEY=$1
  num=$2
  awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$KEY'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p
}

function get_login_token() {
  # Project ID
  OTC_MYTENANTID=$OTC_MYPROJECTID


  REQ_AUTH_TOKEN='{
    "auth": {"identity": {"methods":["password"],
    "password":{"user":
    {"name": "'$OTC_MYUSER'"
    ,"password": "'$OTC_MYPW'"
    ,"domain":{"name": "'$OTC_MYDOMAIN'"}}}},
    "scope": {"project": {"name": "eu-de_Cloud-Test"}}}
  }'

# Get Token
  export TOKEN=`curl -si -d "$REQ_AUTH_TOKEN" -H "Content-type: application/json" https://iam.eu-de.otc.t-systems.com/v3/auth/tokens | awk '/X-Subject-Token/ {print$2}'`

}

function get_loadbalancerId() {
  # Get LB Ids
  BASE_URL="https://elb.eu-de.otc.t-systems.com"
  REQ_URL="$BASE_URL/v2.0/lbaas/loadbalancers"
  RES=`curl 'Accept:application/json' -H 'Content-Type:application/json' -H "X-Auth-Token:$TOKEN" -X GET "$REQ_URL" 2>/dev/null | jsonValue id 2`

  echo "{\"lbid\" : \"${RES//[[:blank:]]/}\"}" | sed -e 's/^[[:space:]]*//'
  #jp -n --arg lbId "$RES" '{"lbid":$lbId}'
}

check_deps && \
get_login_token && \
get_loadbalancerId


