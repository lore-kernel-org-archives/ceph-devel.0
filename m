From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 4/6] ceph.spec.in: don't move libcephfs_jni files around
Date: Wed, 30 Jan 2013 19:00:43 +0100
Message-ID: <1359568845-7634-5-git-send-email-danny.al-gaaf@bisect.de>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:51043 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756599Ab3A3SAs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jan 2013 13:00:48 -0500
In-Reply-To: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Don't move libcephfs_jni files around from %{_libdir} to /usr/lib/jni/
in the buildroot. They should be placed in %{_libdir} as all libs.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 ceph.spec.in | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index 67a4915..f6a9006 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -280,10 +280,6 @@ mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/log/ceph/
 mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/run/ceph/
 mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/ceph/
 
-#  Relocate java packages to expected locations in buildroot.
-mkdir -p $RPM_BUILD_ROOT/usr/lib/jni
-mv $RPM_BUILD_ROOT/usr/lib64/libcephfs_jni.so* $RPM_BUILD_ROOT/usr/lib/jni/.
-
 # udev rules
 install -D -m 644 udev/50-rbd.rules $RPM_BUILD_ROOT/lib/udev/rules.d/50-rbd.rules
 
@@ -414,7 +410,7 @@ fi
 %{_libdir}/libcephfs.so
 %{_libdir}/librbd.so
 %{_libdir}/librados.so
-/usr/lib/jni/libcephfs_jni.so
+%{_libdir}/libcephfs_jni.so
 
 #################################################################################
 %files radosgw
@@ -562,7 +558,7 @@ fi
 
 %files -n libcephfs_jni1
 %defattr(-,root,root,-)
-/usr/lib/jni/libcephfs_jni.so.*
+%{_libdir}/libcephfs_jni.so.*
 
 %files -n cephfs-java
 %defattr(-,root,root,-)
-- 
1.8.1.1

