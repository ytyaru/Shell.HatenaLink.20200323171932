SCHEME=http
# hatenablog.com, hatenablog.jp, hateblo.jp, hatenadiary.com, hatenadiary.jp
DOMAIN=hatenablog.com
    ID=ytyaru
  TIME=000000
   END=$(date "+%Y/%m/%d")
  DAYS=7
 START=$(date -d "${END}"' '"$DAYS"' day ago' '+%Y/%m/%d')
  DATE=$START
URL_ROOT_FORMAT="\${SCHEME}://\${ID}.\${DOMAIN}"
#URL_ARTICLE_PART_FORMAT="entry/\${DATE}/\${TIME}"
#URL_FORMAT="${URL_ROOT_FORMAT}/${URL_ARTICLE_PART_FORMAT}"
#URL_FORMAT="\${SCHEME}://\${ID}.\${DOMAIN}/entry/\${DATE}/\${TIME}"
URL_FORMAT="${URL_ROOT_FORMAT}/entry/\${DATE}/\${TIME}"
OUT_FORMAT='\\* '"[\${URL_FORMAT}:title]"
