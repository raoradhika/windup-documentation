#!/bin/bash

FILES=`find docs -name 'master.adoc'`

for f in $FILES; do
  asciidoctor --failure-level WARN -b xhtml5 -d book $f
done

rm index.md > /dev/null 2>&1

cat << EOF > index.md
---
layout: home
---
# Windup documentation

EOF

for f in $FILES; do
  echo -e "- [$(dirname $f | sed 's/docs\///g; s/_/ /g; s/-/ /g; s/[a-z]*/\u&/g')]($(dirname $f)/master.html)" >> index.md
done
