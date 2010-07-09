From: Christian Brunner <chb@muc.de>
Subject: [PATCH 1/4] ceph.spec.in: set correct path for rbd classes
Date: Fri, 9 Jul 2010 11:11:49 +0200
Message-ID: <20100709091139.GC29300@bambus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47800 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab0GIJLs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jul 2010 05:11:48 -0400
Received: by fxm14 with SMTP id 14so893623fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jul 2010 02:11:47 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

---
 ceph.spec.in |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index d156fe6..20bb12a 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -94,7 +94,7 @@ fi
 %{_libdir}/libceph.so.*
 %{_libdir}/libcrush.so.*
 %{_libdir}/librados.so.*
-%{_libdir}/libcls_rbd.so.*
+%{_libdir}/rados-classes/libcls_rbd.so.*
 %{_sbindir}/mkcephfs
 /sbin/mount.ceph
 %{_libdir}/ceph
@@ -146,7 +146,7 @@ fi
 %{_libdir}/libceph.so
 %{_libdir}/libcrush.so
 %{_libdir}/librados.so
-%{_libdir}/libcls_rbd.so
+%{_libdir}/rados-classes/libcls_rbd.so
 
 %changelog
 * Fri Apr 30 2010 Sage Weil <sage@newdream.net> 0.19.1-5
-- 
1.6.5.2

