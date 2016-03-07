#!/bin/env python3

import sys
import datetime
import xml.etree.ElementTree as ET
import xml.dom.minidom

def loadHamsterTSV(f):
    data = {}
    with open(f, 'r') as f:
        line = f.readline().strip() # ignore headers
        line = f.readline().strip()
        while line:
            parts = line.split('\t')
            if parts[2]: # ignore not finished
                t = {
                    "start": parts[1],
                    "end": parts[2],
                    "minutes": int(parts[3])
                }
                if parts[0] in data:
                    data[parts[0]].append(t)
                else:
                    data[parts[0]] = [ t ]
            line = f.readline().strip()

    return data

def _hours(minutes):
    return str(int(minutes/60))

def _minutes(minutes):
    return str(minutes % 60)

def _grindStoneDate(date):
    return datetime.datetime.strptime(date, "%Y-%m-%d %H:%M:%S").strftime("%Y-%m-%dT%H:%M:%S.0+02:00")

def dumpGrindstoneXML(data):
    local = {}
    total_sum = 0
    for k, t in data.items():
        local_sum = 0
        for l in t:
            local_sum += l["minutes"]
        local[k] = local_sum
        total_sum += local_sum

    timeSummary = ET.Element('timeSummary', {
        "hours": _hours(total_sum),
        "minutes": _minutes(total_sum),
        "seconds": "0"
    })
    for k, t in data.items():
        task = ET.SubElement(timeSummary, 'task', {
            "name": k,
            "hours": _hours(local[k]),
            "minutes": _minutes(local[k]),
            "seconds": "0"
        })
        for i in t:
            ET.SubElement(task, 'time', {
                "end": _grindStoneDate(i["end"]),
                "start": _grindStoneDate(i["start"]),
                "hours": _hours(i["minutes"]),
                "minutes": _minutes(i["minutes"]),
                "seconds": "0"
            })

    xmlb = ET.tostring(timeSummary).decode('utf-8')
    return xml.dom.minidom.parseString(xmlb).toprettyxml()

print(dumpGrindstoneXML(loadHamsterTSV(sys.argv[1])))
