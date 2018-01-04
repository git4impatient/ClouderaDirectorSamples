#!/bin/bash
# copyright 2016 (c) Martin Lurie
# sample code - not supported
#
# RESET
# note the impala-shell will connect to localhost:21000
#
#  DATANODE=$(sudo su - hdfs -c 'hdfs dfsadmin -report | grep Hostname | sed 's/.*: //'  | tail -1')

impala-shell -i $DATANODE <<eoj
drop table if exists inpatient;
drop table if exists inpatientsnappyparquet;
eoj

hadoop fs -rm -r inpatient
rm Inpatient_Data_2012_CSV.zip
rm Medicare_Hospital_Inpatient_PUF_Methodology_2014-05-30.pdf
rm Medicare_Provider_Charge_Inpatient_DRG100_FY2012.csv

# RUN DEMO 

 wget https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Downloads/Inpatient_Data_2012_CSV.zip
 unzip Inpatient_Data_2012_CSV.zip 
 head Medicare_Provider_Charge_Inpatient_DRG100_FY2012.csv
 hadoop fs -mkdir inpatient
 hadoop fs -put Medicare_Provider_Charge_Inpatient_DRG100_FY2012.csv inpatient
#
# DRG Definition,Provider Id,Provider Name,Provider Street Address,Provider City,Provider State,Provider Zip Code,Hospital Referral Region (HRR) Description,Total Discharges,Average Covered Charges,Average Total Payments,Average Medicare Payments
# 039 - EXTRACRANIAL PROCEDURES W/O CC/MCC,10001,SOUTHEAST ALABAMA MEDICAL CENTER,1108 ROSS CLARK CIRCLE,DOTHAN,AL,36301,AL - Dothan,95,37467.95789,5525.673684,4485.873684
# yes, there are some bad rows with too many commas

impala-shell <<eoj
drop table if exists inpatient;
create external table inpatient (
DRGDefinition string,
ProviderId string,
ProviderName string,
ProviderStreetAddress string,
ProviderCity string,
ProviderState string,
ProviderZipCode string,
HospitalReferralRegionHRRDescription string,
TotalDischarges decimal(12,5),
AverageCoveredCharges decimal(12,6),
AverageTotalPayments decimal(12,6),
AverageMedicarePayments decimal(12,6)
)
COMMENT 'source https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Inpatient2012.html'
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY ',' 
LOCATION
  'hdfs://merlin.lurie.biz:8020/user/marty/inpatient'
;

select count(*) from inpatient;
select * from inpatient limit 5;

drop table if exists inpatientsnappyparquet;
create table inpatientsnappyparquet as select * from inpatient;
compute stats inpatientsnappyparquet;
select sum( AverageCoveredCharges) , sum (AverageTotalPayments) , sum ( AverageMedicarePayments) from inpatientsnappyparquet;


eoj

