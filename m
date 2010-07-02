From: Thomas Mueller <thomas@chaschperli.ch>
Subject: PATCH: ceph.spec.in
Date: Fri, 2 Jul 2010 08:13:38 +0000 (UTC)
Message-ID: <i0k73i$g5f$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47271 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238Ab0GBIN4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 2 Jul 2010 04:13:56 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OUbNg-0005YG-7K
	for ceph-devel@vger.kernel.org; Fri, 02 Jul 2010 10:13:52 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jul 2010 10:13:52 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jul 2010 10:13:52 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

encountered following errors building an rpm package with the 
ceph.spec.in:

RPM build errors:
    File not found: /var/tmp/ceph-0.21~rc-4el5.elefant-root-mockbuild/usr/
bin/mkmonfs
    File must begin with "/": %{_initddir}/ceph
    Installed (but unpackaged) file(s) found:
   /usr/bin/dumpjournal
   /usr/bin/dupstore
   /usr/bin/psim
   /usr/bin/radosacl
   /usr/bin/streamtest
   /usr/bin/test_ioctls
   /usr/bin/test_trans
   /usr/bin/testceph
   /usr/bin/testcrypto
   /usr/bin/testkeys
   /usr/bin/testmsgr
   /usr/bin/testrados
   /usr/bin/testradospp


* mkmonfs - vanished. isn't it used anymore? if so, the man/mkmonfs.8 can 
also be removed
* initddir can be ignored as it is centos/rhel specific (it's called 
"initrddir")
* added the unpackaged files
* added CXXFLAGS to make

- Thomas

--- ceph.spec.in.orig	2010-07-02 09:05:59.000000000 +0200
+++ ceph.spec.in	2010-07-02 10:12:54.000000000 +0200
@@ -41,7 +41,7 @@
 %build
 ./autogen.sh
 %{configure} --without-hadoop --without-debug
-make CFLAGS="$RPM_OPT_FLAGS"
+make CFLAGS="$RPM_OPT_FLAGS" CXXFLAGS="$RPM_OPT_FLAGS"
 
 %install
 rm -rf $RPM_BUILD_ROOT
@@ -84,9 +84,14 @@
 %{_bindir}/cmon
 %{_bindir}/cmds
 %{_bindir}/cosd
-%{_bindir}/mkmonfs
 %{_bindir}/rados
 %{_bindir}/rbdtool
+%{_bindir}/test*
+%{_bindir}/dumpjournal
+%{_bindir}/dupstore
+%{_bindir}/psim
+%{_bindir}/radosacl
+%{_bindir}/streamtest
 %{_initddir}/ceph
 %{_libdir}/libceph.so.*
 %{_libdir}/libcrush.so.*


