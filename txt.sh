#!/bin/sh

if [ ! -d build ]
then
    mkdir build
fi

cp -r src/* build/

HEAD='<!DOCTYPE html><html><head><meta charset="utf-8" /><meta name=viewport content="width=device-width,initial-scale=1"><style>body{font-family:sans-serif;font-size:20px;margin:20px;max-width:600px;}a{color:#345cde;text-decoration:none;}pre{white-space:pre-wrap;word-wrap:break-word;}@media(prefers-color-scheme:dark){body{background:#000;color:#fff}a{color:#fdc9f7}}</style></head><body>'
FOOTER="</body></html>"

txt="src/p/*"

for post in $(ls -1 $txt | sort -r)
do
    POST_FILE="$(basename $post)"
    POST_NAME=$(basename $post .txt)

    pre="$(cat src/p/$POST_FILE)"
    
    echo "$HEAD<pre>$pre</pre>$FOOTER" > "build/p/${POST_NAME}.html"

    txtlist="$txtlist<a href=\"/p/$POST_FILE\">$POST_FILE</a><br />"
    prelist="$prelist<a href=\"/p/$POST_NAME\">$POST_NAME</a><br />"

    echo "$HEAD <p>Posts</p> $prelist $FOOTER" > "build/p.html"
    echo "$HEAD <p>txt</p> $txtlist $FOOTER" > "build/txt.html"
done


for page in src/*.txt
do
    PAGE_FILE="$(basename $page)"
    PAGE_NAME=$(basename $page .txt)
    
    content="$(cat src/$PAGE_FILE)"
    echo "$HEAD<pre>$content</pre>$FOOTER" > "build/${PAGE_NAME}.html"
done



