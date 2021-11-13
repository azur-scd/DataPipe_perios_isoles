#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
   Module with helping functions.
"""

import numpy as np
import pandas as pd
import urllib3
import json
import lxml
import os
import platform
import subprocess

periscope_base_url = "https://periscope.sudoc.fr/SolrProxy"
os_platform = platform.system()

http = urllib3.PoolManager()
def periscope_api(rcr,start,rows):
    """Get the json result of request on the Solr index behind Periscope
    ------------------
       Parameters:
           rcr : str, the rcr of the wanted library
           start : int, the number of the first row in the json flow
           rows : int, the total number of rows in the json flow
    ------------------
       Example : periscope_harvest("060882104",0,10)
    """
    url = 'https://periscope.sudoc.fr/SolrProxy'
    headers = {'Accept': 'application/json'}
    params = {'q':'930-b_t:'+rcr+' AND 999-p_s:NI',
              'solrService': 'Pcp',
              'version': '2.2',
              'start':start,
              'rows':rows,
              'fl':'ppn_z,011-a_z,200-a_z,999-p_s,NbLocs_i',
              'wt':'json'}
    r = http.request('GET',url,headers=headers,fields=params)
    data = json.loads(r.data.decode('utf-8'))
    return data   

def exec_w(df,rcr):
    """run the xslt transform with saxon with a specific command depending on the runtime os
    """
    if os_platform == 'Windows':
            print(subprocess.run([file_path('run_saxon.bat'),file_path('xslt/sudoc_harvest.xsl'),file_path('temporary_files/ppns.xml'),file_path('temporary_files/exs_999ni.xml'),rcr], shell=True, check=True, capture_output=True))
    if os_platform == 'Linux':
            print(subprocess.run(['/bin/bash','./run_saxon.sh',file_path('xslt/sudoc_harvest.xsl'),file_path('temporary_files/ppns.xml'),file_path('temporary_files/exs_999ni.xml'),rcr]))
    df_sudoc = pd.read_xml(file_path('temporary_files/exs_999ni.xml'))
    df_result = df_sudoc[df_sudoc["bu"].notna()].merge(df, left_on='ppn', right_on='ppn_z',how='left').drop(columns=['ppn_z','999-p_s'])
    df_result = df_result[['ppn','011-a_z','200-a_z','NbLocs_i','bu','loc','cote','coll']]
    df_result.to_excel(file_path('result_files/result.xlsx'),sheet_name=rcr)  
    print("...End processing") 
    return df_result

def file_path(relative_path):
    folder = os.path.dirname(os.path.abspath("__file__"))
    path_parts = relative_path.split("/")
    new_path = os.path.join(folder, *path_parts)
    return new_path