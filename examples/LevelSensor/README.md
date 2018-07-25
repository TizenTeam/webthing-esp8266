# LEVELSENSOR #

## USAGE: ##

```
curl http://192.168.1.225/
[ { 
    "@context" : "https://iot.mozilla.org/schemas",
    "@type" : [ 
        "MultiLevelSensor",
        "Sensor"
      ],
    "href" : "/things/AnalogSensorDevice",
    "name" : "Analog Sensor pluged in single pin",
    "properties" : { "level" : { 
            "@type" : "LevelProperty",
            "href" : "/things/AnalogSensorDevice/properties/level",
            "type" : "number"
          } }
  } ]

# Check property value
curl http://192.168.1.225/things/AnalogSensorDevice/properties/level
{"level":15.28239}
```

## DEMO: ##

[![web-of-things-agriculture-20180712rzr.webm](https://s-opensource.org/wp-content/uploads/2018/07/web-of-things-agriculture-20180712rzr.gif)](https://player.vimeo.com/video/279677314#web-of-things-agriculture-20180712rzr.webm "Video Demo")

Using Arduino mega256 with W5100 shield and FC-28 soil moisture analog sensor
