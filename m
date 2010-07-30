From: Thomas Mueller <thomas@chaschperli.ch>
Subject: [PATCH] ceph.spec.in: move mount utils to dedicated package
Date: Fri, 30 Jul 2010 10:01:06 +0200
Message-ID: <1280476866-16838-1-git-send-email-thomas@chaschperli.ch>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.muellerit.ch ([92.51.129.153]:57290 "EHLO
	mail.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab0G3IB0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 04:01:26 -0400
Received: from mail.muellerit.ch ([127.0.0.1])
	by localhost (mail.muellerit.ch [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Hs-zhVOb+B4T for <ceph-devel@vger.kernel.org>;
	Fri, 30 Jul 2010 10:01:13 +0200 (CEST)
Received: from gargelblaster.mit.local (zux221-125-110.adsl.green.ch [81.221.125.110])
	by mail.muellerit.ch (Postfix) with ESMTPSA id 55476792402E
	for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 10:01:13 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Thomas Mueller <thomas@chaschperli.ch>

on a client the server-side is IMHO not needed. Move the mount util
to a dedicated package.

Signed-off-by: Thomas Mueller <thomas@chaschperli.ch>
---
 ceph.spec.in |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index a8a5e25..7bcbe9b 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -29,6 +29,12 @@ BuildRequires: fuse-devel
 %description   fuse
 FUSE based client for Ceph distributed network file system
 
+%package       client-tools
+Summary:       mount utils for kernel client
+Group:         System Environment/Base
+%description   
+Utils to mount a ceph filesystem with the kernel client.
+
 %package     devel
 Summary:     Ceph headers
 Group:       Development/Libraries
@@ -119,7 +125,6 @@ fi
 %{_libdir}/librados.so.*
 %{_libdir}/rados-classes/libcls_rbd.so.*
 %{_sbindir}/mkcephfs
-/sbin/mount.ceph
 %{_libdir}/ceph
 %config(noreplace) %{_sysconfdir}/ceph/sample.ceph.conf
 %config(noreplace) %{_sysconfdir}/ceph/sample.fetch_config
@@ -135,7 +140,6 @@ fi
 %{_mandir}/man8/monmaptool.8*
 %{_mandir}/man8/cconf.8*
 %{_mandir}/man8/ceph.8*
-%{_mandir}/man8/mount.ceph.8*
 %{_mandir}/man8/radosgw.8*
 %{_mandir}/man8/radosgw_admin.8*
 %{_mandir}/man8/rados.8*
@@ -153,6 +157,12 @@ fi
 %{_bindir}/cfuse
 %{_mandir}/man8/cfuse.8*
 
+%files client-tols
+%defattr(-,root,root,-)
+%doc COPYING
+/sbin/mount.ceph
+%{_mandir}/man8/mount.ceph.8*
+
 %files devel
 %defattr(-,root,root,-)
 %doc COPYING
-- 
1.7.1

