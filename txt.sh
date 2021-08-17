#!/bin/sh

if [ ! -d build ]
then
    mkdir build
fi

cp -r src/* build/

top='<!DOCTYPE html><html><head><meta charset="utf-8" /><meta name=viewport content="width=device-width,initial-scale=1"><link href="#" rel=icon><style>body{font-family:sans-serif;font-size:20px;margin:20px auto;padding:0 20px;max-width:540px;}a{color:#345cde;text-decoration:none;}pre{white-space:pre-wrap;word-wrap:break-word;font-size:20px;font-family:sans-serif;}@media(prefers-color-scheme:dark){body{background:#000;color:#fff}a{color:#fdc9f7}}</style></head><body>'
bottom="</body></html>"

txt="src/p/*"

for post in $(ls -1 $txt | sort -r)
do
    POST_FILE="$(basename $post)"
    POST_NAME=$(basename $post .txt)

    pre="$(cat src/p/$POST_FILE)"
    
    mail="<p style=\"font-size:90%;color:#969696;\">Comments? Send an <a href=\"mailto:test@test.email?subject=RE%3A%20$POST_NAME&body=name%3A%20%0Acomment%3A%20%0A\">Email</a>.</p>"
    
    if [ ! -f "src/c/comment-$POST_FILE" ]
    then
        comment=""
    else
        comment="
Comments:
$(cat src/c/comment-$POST_FILE)"
    fi
    
    echo "$top<pre>$pre
$comment</pre>$mail$bottom" > "build/p/${POST_NAME}.html"

    txtlist="$txtlist<a href=\"/p/$POST_FILE\">$POST_FILE</a><br />"
    prelist="$prelist<a href=\"/p/$POST_NAME\">$POST_NAME</a><br />"

    echo "$top <p>Posts</p> $prelist $bottom" > "build/p.html"
    echo "$top <p>txt</p> $txtlist $bottom" > "build/txt.html"
done


for page in src/*.txt
do
    PAGE_FILE="$(basename $page)"
    PAGE_NAME=$(basename $page .txt)
    
    content="$(cat src/$PAGE_FILE)"
    echo "$top<pre>$content</pre>$bottom" > "build/${PAGE_NAME}.html"
done

