ExpandLink() { eval echo "$(eval echo "${OUT_FORMAT}")"; }
GenerateDates() {
	local days=$(expr \( `date --date "${END}" +%s` - `date --date "${START}" +%s` \) / 86400)
	seq 0 ${days} | xargs -n1 -i date -d${START}+{}days +%Y/%m/%d
}
GenerateLinks() { cat - | while read DATE; do { ExpandLink; } done; }
Generate() { GenerateDates | GenerateLinks; }
#	Generate() { seq 0 ${days} | xargs -n1 -i date -d${START}+{}days +%Y/%m/%d | \
#				 sed 's/^/\* \['"${SCHEME}"':\/\/'"${ID}"'.'"${DOMAIN}"'\/entry\//g' | \
#				 sed 's/$/\/'"${TIME}"':title\]/g'; }
#	Generate() { seq 0 ${days} | xargs -n1 -i date -d${START}+{}days +%Y/%m/%d | \
#				 { cat - | while read DATE; do { eval echo "$(eval echo "${OUT_FORMAT}")"; } done; }; }
##				 { DATES=$(cat); echo -e "$DATES" | while read DATE; do { eval echo "$(eval echo "${OUT_FORMAT}")"; } done; }; }
ToClipbord() { echo "$(Generate)" | xsel -bi; }
Generate

