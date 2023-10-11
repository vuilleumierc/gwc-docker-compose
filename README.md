### Quick start
Start and initialize the composition:

```
make run
```

Clean GWC cache: 

```
make clean-gwc-cache
```

### Test CQL filters

#### Without filter

http://localhost:8083/gwc/service/wmts?layer=geo%3Alocation&style=&tilematrixset=EPSG%3A4326&Service=WMTS&Request=GetTile&Version=1.0.0&Format=image%2Fpng&TileMatrix=EPSG%3A4326%3A15&TileCol=34121&TileRow=7836

#### With filter, without UTF-8 char

http://localhost:8083/gwc/service/wmts?layer=geo%3Alocation&style=&tilematrixset=EPSG%3A4326&Service=WMTS&Request=GetTile&Version=1.0.0&Format=image%2Fpng&TileMatrix=EPSG%3A4326%3A15&TileCol=34121&TileRow=7836&CQL_FILTER=status%20LIKE%20%27Bbb%27

#### With filter, with UTF-8 char

http://localhost:8083/gwc/service/wmts?layer=geo%3Alocation&style=&tilematrixset=EPSG%3A4326&Service=WMTS&Request=GetTile&Version=1.0.0&Format=image%2Fpng&TileMatrix=EPSG%3A4326%3A15&TileCol=34121&TileRow=7836&CQL_FILTER=status%20LIKE%20%27Aaä%27

Test with and without the line

```
<httpRequestMode>FormPost</httpRequestMode>
```
in the file `geowebcache.xml`
