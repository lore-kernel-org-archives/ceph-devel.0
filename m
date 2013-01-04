From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 2/6] ceph.spec.in: fix handling of java files
Date: Fri,  4 Jan 2013 18:51:27 +0100
Message-ID: <1357321891-20202-3-git-send-email-danny.al-gaaf@bisect.de>
References: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:54153 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754409Ab3ADRve (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 12:51:34 -0500
In-Reply-To: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix handling of JAVA (jar) files. Don't move the files around in the install
section since the related Makefile is fixed instead.

Use %{_javadir} instead of /usr/share/java/

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 ceph.spec.in | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index 7aae6fe..cd93573 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -281,9 +281,6 @@ mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/ceph/
 #  Relocate java packages to expected locations in buildroot.
 mkdir -p $RPM_BUILD_ROOT/usr/lib/jni
 mv $RPM_BUILD_ROOT/usr/lib64/libcephfs_jni.so* $RPM_BUILD_ROOT/usr/lib/jni/.
-mkdir -p $RPM_BUILD_ROOT/usr/share/java
-mv $RPM_BUILD_ROOT/usr/lib64/libcephfs.jar  $RPM_BUILD_ROOT/usr/share/java/.
-mv $RPM_BUILD_ROOT/usr/lib64/libcephfs-test.jar $RPM_BUILD_ROOT/usr/share/java/.
 
 %clean
 rm -rf $RPM_BUILD_ROOT
@@ -561,7 +558,7 @@ fi
 
 %files -n libcephfs-java
 %defattr(-,root,root,-)
-/usr/share/java/libcephfs.jar
-/usr/share/java/libcephfs-test.jar
+%{_javadir}/libcephfs.jar
+%{_javadir}/libcephfs-test.jar
 
 %changelog
-- 
1.8.0.2

