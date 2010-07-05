From: Thomas Mueller <thomas@chaschperli.ch>
Subject: PATCH V2: ceph.spec.in - make -j and unpackaged files
Date: Mon, 5 Jul 2010 07:10:01 +0000 (UTC)
Message-ID: <i0s0g8$oc2$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45158 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207Ab0GEHKO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Jul 2010 03:10:14 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OVfoh-0002V6-Vx
	for ceph-devel@vger.kernel.org; Mon, 05 Jul 2010 09:10:11 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jul 2010 09:10:11 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jul 2010 09:10:11 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

please ignore the other old patch. I missed one file 
(libcls_rbd.so in devel) and removed the "--without-debug"


* now that make -j<numprocs> works out of the box, add it to the spec
* added new unpackaged files 
* the test binaries get installed with "--without-debug". omitting 
"--without-debug" fixes the problem.



diff --git a/ceph.spec.in b/ceph.spec.in
index ca15094..9551598 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -40,8 +40,8 @@ This package contains the headers needed to develop programs that use Ceph.
 
 %build
 ./autogen.sh
-%{configure} --without-hadoop --without-debug
-make CFLAGS="$RPM_OPT_FLAGS" CXXFLAGS="$RPM_OPT_FLAGS"
+%{configure} --without-hadoop 
+make -j$(getconf _NPROCESSORS_ONLN) CFLAGS="$RPM_OPT_FLAGS" CXXFLAGS="$RPM_OPT_FLAGS"
 
 %install
 rm -rf $RPM_BUILD_ROOT
@@ -75,6 +75,8 @@ fi
 %doc README COPYING
 %{_bindir}/ceph
 %{_bindir}/cconf
+%{_bindir}/cclass
+%{_bindir}/cclsinfo
 %{_bindir}/crushtool
 %{_bindir}/monmaptool
 %{_bindir}/osdmaptool
@@ -85,11 +87,13 @@ fi
 %{_bindir}/cmds
 %{_bindir}/cosd
 %{_bindir}/rados
+%{_bindir}/radosacl
 %{_bindir}/rbdtool
 %{_initrddir}/ceph
 %{_libdir}/libceph.so.*
 %{_libdir}/libcrush.so.*
 %{_libdir}/librados.so.*
+%{_libdir}/libcls_rbd.so.*
 %{_sbindir}/mkcephfs
 /sbin/mount.ceph
 %{_libdir}/ceph
@@ -112,6 +116,9 @@ fi
 %{_mandir}/man8/rados.8*
 %{_mandir}/man8/rbdtool.8*
 %{_mandir}/man8/cauthtool.8*
+%{_mandir}/man8/cclass.8.gz
+%{_mandir}/man8/cclsinfo.8.gz
+
 
 %files fuse
 %defattr(-,root,root,-)
@@ -138,6 +145,7 @@ fi
 %{_libdir}/libceph.so
 %{_libdir}/libcrush.so
 %{_libdir}/librados.so
+%{_libdir}/libcls_rbd.so
 
 %changelog
 * Fri Apr 30 2010 Sage Weil <sage@newdream.net> 0.19.1-5

