#!/bin/bash

# Variables
RESOURCE_GROUP_NAME="tfstate-day04"
STORAGE_ACCOUNT_NAME="day04$RANDOM"
LOCATION="eastus"
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage account
az storage account create --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP_NAME --location $LOCATION --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

echo "Storage container $CONTAINER_NAME created in resource group $RESOURCE_GROUP_NAME"