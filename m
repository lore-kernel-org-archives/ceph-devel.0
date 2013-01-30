From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 3/6] ceph.spec.in: move libcephfs_jni.so to ceph-devel
Date: Wed, 30 Jan 2013 19:00:42 +0100
Message-ID: <1359568845-7634-4-git-send-email-danny.al-gaaf@bisect.de>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:51046 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756609Ab3A3SAs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jan 2013 13:00:48 -0500
In-Reply-To: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Move libcephfs_jni.so to the ceph-devel package since so-files they
shouldn't be part of the library package.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 ceph.spec.in | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index 38aef98..67a4915 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -414,6 +414,7 @@ fi
 %{_libdir}/libcephfs.so
 %{_libdir}/librbd.so
 %{_libdir}/librados.so
+/usr/lib/jni/libcephfs_jni.so
 
 #################################################################################
 %files radosgw
@@ -561,7 +562,7 @@ fi
 
 %files -n libcephfs_jni1
 %defattr(-,root,root,-)
-/usr/lib/jni/libcephfs_jni.so*
+/usr/lib/jni/libcephfs_jni.so.*
 
 %files -n cephfs-java
 %defattr(-,root,root,-)
-- 
1.8.1.1

