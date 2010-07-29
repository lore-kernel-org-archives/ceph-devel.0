From: Thomas Mueller <thomas@chaschperli.ch>
Subject: [PATCH] ceph.spec.in: rbdtool renamed, add libcls_sync.*
Date: Thu, 29 Jul 2010 14:45:55 +0000 (UTC)
Message-ID: <i2s473$33r$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:60850 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757596Ab0G2OqF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Jul 2010 10:46:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OeUN1-0004gV-R9
	for ceph-devel@vger.kernel.org; Thu, 29 Jul 2010 16:46:03 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 16:46:03 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 16:46:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

* rbdtool got renamed to rbd
* add new libs libcls_sync.*

--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -111,12 +111,13 @@ fi
 %{_bindir}/cosd
 %{_bindir}/rados
 %{_bindir}/radosacl
-%{_bindir}/rbdtool
+%{_bindir}/rbd
 %{_initrddir}/ceph
 %{_libdir}/libceph.so.*
 %{_libdir}/libcrush.so.*
 %{_libdir}/librados.so.*
 %{_libdir}/rados-classes/libcls_rbd.so.*
+%{_libdir}/rados-classes/libcls_sync.so.*
 %{_sbindir}/mkcephfs
 /sbin/mount.ceph
 %{_libdir}/ceph
@@ -138,7 +139,7 @@ fi
 %{_mandir}/man8/radosgw.8*
 %{_mandir}/man8/radosgw_admin.8*
 %{_mandir}/man8/rados.8*
-%{_mandir}/man8/rbdtool.8*
+%{_mandir}/man8/rbd.8*
 %{_mandir}/man8/cauthtool.8*
 %{_mandir}/man8/cclass.8.gz
 %{_mandir}/man8/cclsinfo.8.gz
@@ -172,6 +173,7 @@ fi
 %{_libdir}/libcrush.so
 %{_libdir}/librados.so
 %{_libdir}/rados-classes/libcls_rbd.so
+%{_libdir}/rados-classes/libcls_sync.so
 
 %if %{with_radosgw}
 %files radosgw

