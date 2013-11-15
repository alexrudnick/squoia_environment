from __future__ import print_function

import os
import sys
from string import Template

with open("template_example.cfg") as infile:
    template = Template(infile.read())
    print(template.substitute(TOPDIR=os.path.abspath(os.curdir)))
