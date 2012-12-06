# $Id: Makefile,v 1.1 2012/12/06 01:31:36 nadya Exp $
#
# @Copyright@
# @Copyright@
#
# $Log: Makefile,v $
# Revision 1.1  2012/12/06 01:31:36  nadya
# initial
#
# Revision 1.4  2012/10/24 23:05:39  nadya
# fix permissions
#
# Revision 1.3  2012/10/05 18:30:52  nadya
# use version in deployment script name: 2 meme verisons need to coexist on a server
#
# Revision 1.2  2012/09/01 04:11:23  nadya
# user version in one place
#
# Revision 1.1  2012/06/30 02:18:14  nadya
# initial
#

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

	
REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

version.mk:
	cat ../version.mk version.mk.in > version.mk

build: version.mk
	echo "Nothing to build "

install::
	mkdir -p $(ROOT)/$(PKGROOT)
	install -m644 crystaldock.xml $(ROOT)/$(PKGROOT)/crystaldock_$(VERSION).xml

clean::
	rm -rf version.mk

