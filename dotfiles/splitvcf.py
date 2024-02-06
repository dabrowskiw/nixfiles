import sys
import hashlib


class Vcard:
    def __init__(self):
        self.lines = []
        self.content = ""
        self.uid = None

    def setuid(self, uidline):
        self.uid = self.uidline.split(":")[0].strip()

    def close(self):
        if self.uid is None:
            self.uid = hashlib.sha256("".join(self.lines).encode("utf-8")).hexdigest()
        self.content = "\n".join(
            self.lines[0:2] + ["UID:%s" % (self.uid)] + self.lines[2:]
        )


infile = sys.argv[1]

vcards = []
vcard = Vcard()

for line in open(infile, "r").readlines():
    linedata = line.split(":")
    if len(linedata) != 0 and linedata[0].strip() == "UID":
        vcard.setuid(line.strip())
    else:
        vcard.lines += [line.strip()]
    if line.strip() == "END:VCARD":
        if len(vcard.lines) > 2:
            vcard.close()
            vcards += [vcard]
        vcard = Vcard()

for vcard in vcards:
    with open("%s.vcf" % (vcard.uid), "w") as outfile:
        outfile.write(vcard.content)
