#!/usr/bin/env python

fig_re = r'\\includegraphics{0,1}\[.*?\]+\{(.*?)\}'
extensions = ('pdf', 'png', 'jpg')

import sys, re, os

if not len(sys.argv) == 2:
    print "Usage: text_grep_fig filename.tex"
    sys.exit(-1)

f = open(sys.argv[1], 'r')
data = f.read().replace('\n', ' ').replace(r'\lyxdot ', '.')

for image in (m.group(1) for m in re.finditer(fig_re, data)):
    filenames = (f for f in (image + '.' + ext for ext in extensions)
                 if os.path.exists(f))
    fn = next(filenames, None)
    if fn: print fn
