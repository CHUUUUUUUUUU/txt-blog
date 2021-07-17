#!/bin/sh

if [ ! -d build ]
then
    mkdir build
fi

txt="src/p/*"

for post in $(ls -1 $txt | sort -r)
do
    POST_FILE="$(basename $post)"
    #POST_NAME=$(basename $post .txt)

    index="$index<a href=\"/p/$POST_FILE\">$POST_FILE</a><br />"
    
done

cp -r src/* build/

HEAD='<!DOCTYPE html><html><head><meta charset="utf-8" /><meta name=viewport content="width=device-width,initial-scale=1"><style>body{font-family:sans-serif;font-size:20px;margin:20px;max-width:600px;}a{color:#345cde;text-decoration:none;}pre{white-space:pre-wrap;word-wrap:break-word;}@media(prefers-color-scheme:dark){body{background:#000;color:#fff}a{color:#fdc9f7}}</style></head><body>'
FOOTER="</body></html>"


for page in src/*.txt
do
    PAGE_FILE="$(basename $page)"
    PAGE_NAME=$(basename $page .txt)
    
    content="$(cat src/$PAGE_FILE)"
    echo "$HEAD<pre>$content</pre>$FOOTER" > "build/${PAGE_NAME}.html"
done


#echo "$HEAD $index $FOOTER" > "build/index.html"

echo "$HEAD <p>Posts</p> $index $FOOTER" > "build/p.html"
