find . | entr -r typst compile main.typ | python3 -m http.server
