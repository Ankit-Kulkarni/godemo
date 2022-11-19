---
# theme : "serif"
transition: "slide"
highlightTheme: "monokai"
logoImg: "/home/ankit/Downloads/titanblack.png"
slideNumber: true
title: "How to use VSCode"
---

# Deploy Go packages as RPM/Debs


```
From:    Ankit Kulkarni
         Titan 
Work as: Sr. Devops Engineer

Twitter: @ankitkul1890
Web:     i.ankul.in
Github:  ankit-kulkarni
```

---


# INDEX {.fragment .highlight-green}

- Continuosly build your project 
  - `Compiledaemon`{.fragment .highlight-red}   + `Makefile`{.fragment .highlight-green}
- Package it as rpm/deb
  - `NFPM` (nFPM is not FPM){.fragment .highlight-red}

---

# More details on NFPM

--

- Add code files using regex like *.py
- Add config files 
- Create empty folders 
- Add prerun/postrun scripts during package installation
    - might be needed to send some hooks , change permission, ownershipt etc

--

----


# Thank you !!

```
Twitter:       @ankitkul1890
Web:           i.ankul.in
Code @Github:  ankit-kulkarni/godemo
```




