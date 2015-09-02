#!/bin/bash

AZURE_CMD=$(which azure);
CURL=$(which curl);
ACTIONS_LOG="/var/log/azure_traffic_linker.log";
AZURE_MODE="arm";
GREP=$(which grep);

function log(){
    echo "$(date)  $@" >> $ACTIONS_LOG;
}

function installAzureClient(){

    [ -z "$AZURE_CMD" ] && { 
         log "It seems Azure CLI is not installed, attempting to install ...";
         $CURL https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh 2>/$ACTIONS_LOG | bash >> $ACTIONS_LOG 2>&1;
         export NVM_DIR="//.nvm"; 
         [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" 2>/dev/null && nvm install v0.10.30  >> $ACTIONS_LOG 2>&1;
         [ ! -L "/usr/bin/node" ] && ln -s "/.nvm/v0.10.30/bin/node" "/usr/bin/node"
         [ ! -L "/usr/bin/azure" ] && ln -s "/.nvm/v0.10.30/bin/azure" "/usr/bin/azure"
         npm install -g azure-cli >> $ACTIONS_LOG 2>&1;
         AZURE_CMD=$(which azure);
         [ -z "$AZURE_CMD" ] && log "Wasn't able to Install Azure CLI, please install it manualy, now exit ..." && exit 1;
    }

}
  while [ "$1" != "" ]; do
    case $1 in

      --install )                   shift;
                                  installAzureClient;
                                  exit 0;
                                  ;;
      --username )                shift;
                                  USERNAME="$1";
                                  ;;
      --password )                shift;
                                  PASSWORD="$1";
                                  ;;                                 
      --resource-group )          shift;
                                  RESGROUP="$1"
                                  ;;
      --location )                shift;
                                  LOCATION="$1";
                                  ;;
      --profile-name )            shift;
                                  PROFILE_NAME="$1";
                                  ;;
      --dns-domain )              shift;
                                  DNS_DOMAIN="$1";
                                  ;;
      --monitoring-path )         shift;
                                  MONITORING_PATH="$1";
                                ;;
    esac
    shift
  done

  installAzureClient;
  $AZURE_CMD login -u $USERNAME -p $PASSWORD
  $AZURE_CMD config set mode $AZURE_MODE >> $ACTIONS_LOG 2>&1;
  $AZURE_CMD group list --json |  $GREP -q "$RESGROUP" || {
      $AZURE_CMD group create "$RESGROUP" "$LOCATION" >> $ACTIONS_LOG 2>&1;
  }
  $AZURE_CMD provider register Microsoft.Network >> $ACTIONS_LOG 2>&1;
  $AZURE_CMD provider register Microsoft.Network >> $ACTIONS_LOG 2>&1;## required to run two times, first time it always fails
  $AZURE_CMD network traffic-manager profile list --json "$RESGROUP" | $GREP -q "$PROFILE_NAME" || {
      $AZURE_CMD network traffic-manager profile create --resource-group "$RESGROUP" --name "$PROFILE_NAME" --relative-dns-name "$DNS_DOMAIN"  --monitor-path "$MONITORING_PATH";
  }
  $AZURE_CMD network traffic-manager profile endpoint create --target "$(hostname)" --resource-group "$RESGROUP" --profile-name "$PROFILE_NAME" --name $(hostname) --endpoint-location  "$LOCATION"




