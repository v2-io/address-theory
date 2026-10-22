



# Brainstorm
*(Just ideas-- nothing ruled etc. etc.)*
## UDON Fragment Root Elements / Schemas (Types)

### Bare udon fragment
```
/a/b/c/basename.ud
```

```udon
|$dir[a] |$dir[b] |$dir[c] |$file[basename] ; pseudo elements from filesystem resolved path
                            :$meta [...]    ; (other misc information such as stat info etc.)
      (start of doc)->     ┊
                           ┊
  1st col in the file ──────^
```

### Schemas =~ Named Root
```
/a/b/c/basename.schema.ud
```

```udon
|$dir[a] |$dir[b] |$dir[c] |schema[basename].$file ; pseudo elements from filesystem resolved path
                            :$meta [...]           ; (other misc information such as stat info etc.)
      (start of doc)->     ┊
                           ┊
  1st col in the file ──────^
```


### File-Specified udon Root & Schema
```
/a/b/c/basename._.ud
```

```udon
|$dir[a] |$dir[b] |$dir[c] |some-root[basename].$file.$wildcard ; pseudo elements from filesystem resolved path
                            :$meta [...]       ; (other misc information such as stat info etc.)
      (start of doc)->     ┊|some-root         ; can have [basename][other-key(s)...] as well, unlike normal single-key
                           ┊  |child
      (causes error)->     ┊|additional-roots  ; error, forbidden in udon-lite-0.1
  1st col in the file ──────^
```


### Alternatives / Variations

**(Forget the pseudo hierarchy)**
```udon
|schema[basename]
  :$type text/udon
  :$path /a/b/c
  :$meta [...]
  ....
```

**(Explicit)**
```udon
|$root[/a/b/c/the-file.something.ud]
  :$meta [...]
  :$schema
  :$parsed-path ...  ; and plenty more if wanted

  ; Yeah, this is the "safe" and obvious choice... Don't know though if it's best.
```



---

## Discussion
- The pseudo-hierarchy would potentially allow, at least on fragment-file (uncooked udon) ingest, a flat query space for logical udon and the filesystem layout.  When it is an udon store, it allows one to decide automatically if some child element wants to just be indented in the parent file, or if it should live in parent/child.element.ud  --- automatic organic growth capabilities... Including having *both* as a logical-udon union...
