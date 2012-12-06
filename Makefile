#
# $Id: Makefile,v 1.1 2012/12/06 01:31:36 nadya Exp $
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 5.5 (Mamba)
# 		         version 6.0 (Mamba)
# 
# Copyright (c) 2000 - 2012 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@
#
# $Log: Makefile,v $
# Revision 1.1  2012/12/06 01:31:36  nadya
# initial
#
#

ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
ifndef ROLLPYTHON
  #ROLLPYTHON = `which python`
  ROLLPYTHON = /opt/python/bin/python
endif
ifndef ROLLPYTHONLIB
  #ROLLPYTHONLIB = `find /usr/lib64 -name site-packages | tail -1`
  ROLLPYTHONLIB = /opt/python/lib/python2.7
endif
empty:=
space:=$(empty) $(empty)
ROLLSUFFIX = _$(subst $(space),+,$(ROLLCOMPILER))

-include $(ROLLSROOT)/etc/Rolls.mk
include Rolls.mk

default:
# Copy and substitute lines of nodes/*.in that reference ROLLCOMPILER, making
# # one copy for each ROLLCOMPILER value, also pluggin in values for
# # ROLLPYTHON and ROLLPYTHONLIB
	for i in `ls nodes/*.in`; do \
	    export o=`echo $$i | sed 's/\.in//'`; \
	    cp $$i $$o; \
	    for c in $(ROLLCOMPILER); do \
	        perl -pi -e 'print and s/ROLLCOMPILER/'$${c}'/g if m/ROLLCOMPILER/' $$o; \
	    done; \
	    perl -pi -e 'print and s#ROLLPYTHONLIB#$(ROLLPYTHONLIB)#g if m/ROLLPYTHONLIB/' $$o; \
	    perl -pi -e 'print and s#ROLLPYTHON#$(ROLLPYTHON)#g if m/ROLLPYTHON\b/' $$o; \
	    perl -pi -e '$$_ = "" if m/ROLL(COMPILER|PYTHON|PYTHONLIB)/' $$o; \
	done
	$(MAKE) ROLLCOMPILER="$(ROLLCOMPILER)" ROLLPYTHON="$(ROLLPYTHON)" ROLLPYTHONLIB="$(ROLLPYTHONLIB)" roll

clean::
	rm -f _arch bootstrap.py

cvsclean: clean
	for i in `ls nodes/*.in`; do \
	    export o=`echo $$i | sed 's/\.in//'`; \
	    rm -f $$o; \
	done
	rm -fr RPMS SRPMS
	
