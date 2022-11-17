1.1.1.8 2022-11-17
==================
- base0->r0.0.4.7

1.1.1.7 2022-11-17
==================
- upgrade to callPackage-based versions

1.1.1.6 2022-11-13
==================
- fix fixed-package-name typo in flake-build-utils

1.1.1.5 2022-11-12
==================
- add flake

1.1.1.4 2022-04-07
==================
- increment monadio-plus to 2.3.0.1

1.1.1.3 2022-04-06
==================
- increment monadio-plus to 2.3.0.0

1.1.1.2 2022-04-05
==================
- increment monadio-plus to 2.2.0.0

1.1.1.1 2022-04-04
==================
- increment monadio-plus to 2.1.0.0

1.1.1.0 2021-12-30
==================
- add testParsecFile

1.1.0.3 2021-12-29
==================
- parsecFileUTF8* implicitly includes eof

1.1.0.2 2021-10-12
==================
- upgrade dependencies, including monadio-plus to 2.0.0.0

1.1.0.1 2021-06-02
==================
- use MonadIO-Plus 1.4.6.0 (readFile @_ @T rather than readFileUTF8)

1.1.0.0 2021-02-20
==================
- use MonadIO-Plus 1.1.0.0; remove parsecFUTF8{,L}

1.0.3.2 2020-09-17
==================
- directly export ParsecPlusBase

1.0.3.1 2020-01-31
==================
- use getContentsUTF8Lenient to provide lenient parsing on stdin, too (bugfix)

1.0.3.0 2020-01-28
==================
- add parsecFileUTF8Lenient, parsecFUTF8L

1.0.2.0 2020-01-19
==================
- add parsecFUTF8

1.0.1.0 2019-11-30
==================
- export ParseError

1.0.0.0 2019-10-09
==================
- factored out from fluffy
