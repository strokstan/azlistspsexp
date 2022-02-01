#!/usr/bin/env bash

NAME={name or prefix}
az ad sp list --all --query "[?contains(displayName, '$NAME')].[displayName,appId]" -o tsv > spslist.tsv
while read -r SPS SPID
do
	ENDDATE=$(az ad sp credential list --id $SPID --query [].[endDate] -o tsv | cut -b 1-10 )
	echo " $SPS end date is $ENDDATE  " | tee -a ./spsresexp.log
done < spslist.tsv
#done < tsvtest

