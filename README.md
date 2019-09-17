references-in-sqlite
=================================

The issue of multiple Bible references is discussed here:
https://en.wikipedia.org/wiki/Chapters_and_verses_of_the_Bible

CCEL has open resources for converting between reference systems.
http://www.ccel.org/refsys/refsys.html

Specifically these files:
http://www.ccel.org/refsys/Bible.xml
http://www.ccel.org/refsys/Bible.ORG.xml
http://www.ccel.org/refsys/Bible.LXX.xml

The XML files are first prepared for SQL input:

    xsltproc  -o "Bible.txt" "from-bible.xsl" "Bible.xml"
    xsltproc  -o "Bible.LXX.txt" "from-other.xsl" "Bible.LXX.xml"
    xsltproc  -o "Bible.ORG.txt" "from-other.xsl" "Bible.ORG.xml"

Then they are imported:

    sqlite3 references.sqlite ".read references-in-sqlite.sql"
