From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 4/6] ceph.spec.in: fix libcephfs-jni package name
Date: Fri,  4 Jan 2013 18:51:29 +0100
Message-ID: <1357321891-20202-5-git-send-email-danny.al-gaaf@bisect.de>
References: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:54150 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753949Ab3ADRve (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 12:51:34 -0500
In-Reply-To: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Rename libcephfs-jni to libcephfs_jni1 to reflect the SO name/version of
the library and to prevent RPMLINT to complain about the naming.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 ceph.spec.in | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index bfd030b..8eb4be8 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -189,14 +189,14 @@ Requires:	libcephfs1 = %{version}-%{release}
 %description -n ceph-test
 This package contains Ceph benchmarks and test tools.
 
-%package -n libcephfs-jni
+%package -n libcephfs_jni1
 Summary:	Java Native Interface library for CephFS Java bindings.
 Group:		System Environment/Libraries
 License:	LGPL-2.0
 Requires:	java
 Requires:	libcephfs1 = %{version}-%{release}
 BuildRequires:  java-devel
-%description -n libcephfs-jni
+%description -n libcephfs_jni1
 This package contains the Java Native Interface library for CephFS Java
 bindings.
 
@@ -205,7 +205,7 @@ Summary:	Java libraries for the Ceph File System.
 Group:		System Environment/Libraries
 License:	LGPL-2.0
 Requires:	java
-Requires:	libcephfs-jni = %{version}-%{release}-
+Requires:	libcephfs_jni1 = %{version}-%{release}
 BuildRequires:  java-devel
 %description -n cephfs-java
 This package contains the Java libraries for the Ceph File System.
@@ -552,7 +552,7 @@ fi
 %{_bindir}/tpbench
 %{_bindir}/xattr_bench
 
-%files -n libcephfs-jni
+%files -n libcephfs_jni1
 %defattr(-,root,root,-)
 /usr/lib/jni/libcephfs_jni.so*
 
-- 
1.8.0.2

