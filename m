From: Thomas Mueller <thomas@chaschperli.ch>
Subject: make with -j fails
Date: Fri, 2 Jul 2010 07:23:18 +0000 (UTC)
Message-ID: <i0k456$g5f$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:43962 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756230Ab0GBHXb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 2 Jul 2010 03:23:31 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OUaav-0006vl-D6
	for ceph-devel@vger.kernel.org; Fri, 02 Jul 2010 09:23:29 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jul 2010 09:23:29 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jul 2010 09:23:29 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

as soon as I try to use the -j option the make fails. tried with -j2 and -
j8

is it supposed to work to call make with "-j" to speedup the compilation 
time?

- Thomas

if g++ -DHAVE_CONFIG_H -I. -I. -I.    -Wall -D__CEPH__ -
D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -O2 -g -pipe -
Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-
buffer-size=4 -m64 -mtune=generic -MT buffer.o -MD -MP -MF ".deps/
buffer.Tpo" -c -o buffer.o `test -f 'common/buffer.cc' || echo 
'./'`common/buffer.cc; \
	then mv -f ".deps/buffer.Tpo" ".deps/buffer.Po"; else rm -f 
".deps/buffer.Tpo"; exit 1; fi
if g++ -DHAVE_CONFIG_H -I. -I. -I.    -Wall -D__CEPH__ -
D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -O2 -g -pipe -
Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-
buffer-size=4 -m64 -mtune=generic -MT debug.o -MD -MP -MF ".deps/
debug.Tpo" -c -o debug.o `test -f 'common/debug.cc' || echo './'`common/
debug.cc; \
	then mv -f ".deps/debug.Tpo" ".deps/debug.Po"; else rm -f ".deps/
debug.Tpo"; exit 1; fi
common/debug.cc:8:22: error: ceph_ver.h: No such file or directory
make[2]: *** [debug.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: Leaving directory `/builddir/build/BUILD/ceph-0.21~rc/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/builddir/build/BUILD/ceph-0.21~rc/src'
Making all in man
make[1]: Entering directory `/builddir/build/BUILD/ceph-0.21~rc/man'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/builddir/build/BUILD/ceph-0.21~rc/man'
make[1]: Entering directory `/builddir/build/BUILD/ceph-0.21~rc'
make[1]: Nothing to be done for `all-am'.
make[1]: Leaving directory `/builddir/build/BUILD/ceph-0.21~rc'
make: *** [all-recursive] Error 1
error: Bad exit status from /var/tmp/rpm-tmp.52754 (%build)

