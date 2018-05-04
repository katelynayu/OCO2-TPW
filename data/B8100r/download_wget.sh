#!/bin/bash


#wget --no-check-certificate --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --keep-session-cookies -r -c -nH -nd -np -A nc4,xml "https://oco2.gesdisc.eosdis.nasa.gov/data/s4pa/OCO2_DATA/OCO2_L2_Lite_FP.7r/2017/oco2_LtCO2_170101_B7305Br_170223010226s.nc4"


#wget --no-check-certificate --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --keep-session-cookies -r -c -nH -nd -np -A nc4,xml "https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170707_B8100r_171020173024s.nc4"

declare -a arr=(
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170630_B8100r_171007181608s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170629_B8100r_171007181514s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170628_B8100r_171007181024s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170627_B8100r_171007181007s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170626_B8100r_171007180946s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170625_B8100r_171007180809s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170624_B8100r_171007180404s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170623_B8100r_171007180352s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170622_B8100r_171007180210s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170621_B8100r_171007180119s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170620_B8100r_171007175744s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170619_B8100r_171007175611s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170618_B8100r_171007175459s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170617_B8100r_171007175452s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170616_B8100r_171007175053s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170615_B8100r_171007174852s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170614_B8100r_171007174814s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170613_B8100r_171007174809s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170612_B8100r_171007174306s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170611_B8100r_171007174137s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170610_B8100r_171007174132s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170609_B8100r_171007174046s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170608_B8100r_171007173539s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170607_B8100r_171007173427s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170606_B8100r_171007173357s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170605_B8100r_171007173347s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170604_B8100r_171007172830s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170603_B8100r_171007172821s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170602_B8100r_171007172750s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170601_B8100r_171007172609s.nc4"
"https://oco2.gesdisc.eosdis.nasa.gov/data//OCO2_DATA/OCO2_L2_Lite_FP.8r/2017/oco2_LtCO2_170531_B8100r_171007172232s.nc4")

for i in "${arr[@]}"
do
   wget --no-check-certificate --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --keep-session-cookies -r -c -nH -nd -np -A nc4,xml "$i"
   #echo "$i"
done
