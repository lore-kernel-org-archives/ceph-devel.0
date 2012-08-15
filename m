From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] docs: Add EU mirror for getting Ceph source and packages
Date: Wed, 15 Aug 2012 12:13:07 +0200
Message-ID: <1345025587-1393-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [109.72.87.138] ([109.72.87.138]:38977 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751549Ab2HOKN2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 15 Aug 2012 06:13:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 doc/install/debian.rst        |    8 ++++++++
 doc/source/build-packages.rst |    4 ++++
 doc/source/get-tarballs.rst   |    3 ++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/install/debian.rst b/doc/install/debian.rst
index be39827..f49e68c 100644
--- a/doc/install/debian.rst
+++ b/doc/install/debian.rst
@@ -25,6 +25,10 @@ supported. ::
 
 	echo deb http://ceph.com/debian/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
 
+For the European users there is also a mirror in the Netherlands at http://eu.ceph.com/
+
+	echo deb http://eu.ceph.com/debian/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
+
 Add Development Release Packages
 --------------------------------
 
@@ -45,6 +49,10 @@ supported. ::
 
 	echo deb http://ceph.com/debian-testing/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
 
+For the European users there is also a mirror in the Netherlands at http://eu.ceph.com/
+
+	echo deb http://eu.ceph.com/debian-testing/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
+
 Add Development Testing Packages
 --------------------------------
 
diff --git a/doc/source/build-packages.rst b/doc/source/build-packages.rst
index a860c7c..7a6ce61 100644
--- a/doc/source/build-packages.rst
+++ b/doc/source/build-packages.rst
@@ -39,6 +39,10 @@ Fetch the source tarball for the RPM compilation environment::
 
 	wget -P ~/rpmbuild/SOURCES/ http://ceph.com/download/ceph-<version>.tar.gz
 
+Or from the EU mirror
+
+	wget -P ~/rpmbuild/SOURCES/ http://eu.ceph.com/download/ceph-<version>.tar.gz
+
 Build the RPM packages::
 
 	rpmbuild -tb ~/rpmbuild/SOURCES/ceph-<version>.tar.gz
diff --git a/doc/source/get-tarballs.rst b/doc/source/get-tarballs.rst
index 816795a..c68c953 100644
--- a/doc/source/get-tarballs.rst
+++ b/doc/source/get-tarballs.rst
@@ -8,4 +8,5 @@ source code. You may download source code tarballs for Ceph releases here:
 `Ceph Release Tarballs`_
 
 
-.. _Ceph Release Tarballs: http://ceph.com/download/
\ No newline at end of file
+.. _Ceph Release Tarballs: http://ceph.com/download/
+.. _Ceph Release Tarballs (EU mirror): http://eu.ceph.com/download/
-- 
1.7.9.5

