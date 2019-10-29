#!/bin/sh

# https://github.com/markasoftware/bing-wallpaper-linux
# Depends on curl, xmllint and feh

urlpath=$( \
curl "https://www.bing.com/HPImageArchive.aspx?format=rss&idx=0&n=1&mkt=en-GB" \
| xmllint --xpath "/rss/channel/item/link/text()" - \
| sed 's/1366x768/1920x1080/g' \
)

curl "https://www.bing.com$urlpath" \
| feh --bg-fill -
