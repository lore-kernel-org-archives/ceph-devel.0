From: Holger Macht <hmacht@suse.de>
Subject: [PATCH] ceph.spec.in: Move libcls_*.so from -devel to base package
Date: Wed, 15 Feb 2012 17:29:09 +0100
Message-ID: <20120215162908.GA22127@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44623 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054Ab2BOQ3L (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 15 Feb 2012 11:29:11 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E56D98FA97
	for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2012 17:29:10 +0100 (CET)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

OSDs (src/osd/ClassHandler.cc) specifically look for libcls_*.so in
/usr/$libdir/rados-classes, so libcls_rbd.so and libcls_rgw.so need to
be shipped along with the base package.

Signed-off-by: Holger Macht <hmacht@suse.de>
---
 ceph.spec.in |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index 48fd4ee..58c3af7 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -348,8 +348,8 @@ fi
 %ghost %dir %{_localstatedir}/run/ceph/
 %dir %{_sysconfdir}/ceph/
 /usr/sbin/rcceph
-%{_libdir}/rados-classes/libcls_rbd.so.*
-%{_libdir}/rados-classes/libcls_rgw.so.*
+%{_libdir}/rados-classes/libcls_rbd.so*
+%{_libdir}/rados-classes/libcls_rgw.so*
 
 #################################################################################
 %files fuse
@@ -377,8 +377,6 @@ fi
 %dir %{_includedir}/rbd
 %{_includedir}/rbd/librbd.h
 %{_includedir}/rbd/librbd.hpp
-%{_libdir}/rados-classes/libcls_rbd.so
-%{_libdir}/rados-classes/libcls_rgw.so
 %{_libdir}/libcephfs.so
 %{_libdir}/librbd.so
 %{_libdir}/librgw.so
-- 
1.7.7

