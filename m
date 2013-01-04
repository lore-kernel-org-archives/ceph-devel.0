From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 3/6] ceph.spec.in: rename libcephfs-java package to cephfs-java
Date: Fri,  4 Jan 2013 18:51:28 +0100
Message-ID: <1357321891-20202-4-git-send-email-danny.al-gaaf@bisect.de>
References: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:54154 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754399Ab3ADRve (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 12:51:34 -0500
In-Reply-To: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Rename the libcephfs-java package to cephfs-java since the package
contains no (classic) library and RPMLINT complains about the name.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 ceph.spec.in | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index cd93573..bfd030b 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -200,14 +200,14 @@ BuildRequires:  java-devel
 This package contains the Java Native Interface library for CephFS Java
 bindings.
 
-%package -n libcephfs-java
+%package -n cephfs-java
 Summary:	Java libraries for the Ceph File System.
 Group:		System Environment/Libraries
 License:	LGPL-2.0
 Requires:	java
 Requires:	libcephfs-jni = %{version}-%{release}-
 BuildRequires:  java-devel
-%description -n libcephfs-java
+%description -n cephfs-java
 This package contains the Java libraries for the Ceph File System.
 
 %if (0%{?centos} || 0%{?opensuse} || 0%{?suse_version})
@@ -556,7 +556,7 @@ fi
 %defattr(-,root,root,-)
 /usr/lib/jni/libcephfs_jni.so*
 
-%files -n libcephfs-java
+%files -n cephfs-java
 %defattr(-,root,root,-)
 %{_javadir}/libcephfs.jar
 %{_javadir}/libcephfs-test.jar
-- 
1.8.0.2

