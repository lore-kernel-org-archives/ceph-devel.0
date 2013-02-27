From: Filippos Giannakos <philipgian@grnet.gr>
Subject: [PATCH] Add X-Python-Version >=2.6 to debian control file.
Date: Wed, 27 Feb 2013 13:56:08 +0200
Message-ID: <1361966168-22618-1-git-send-email-philipgian@grnet.gr>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:18359 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751521Ab3B0MLc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Feb 2013 07:11:32 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: synnefo-devel@googlegroups.com, Filippos Giannakos <philipgian@grnet.gr>

python-ceph complains when installed to debian squeeze about the 'with'
statement. Apparently installation tries to install the python-ceph package for
python 2.5, which does not support the 'with' statement natively.

Signed-off-by: Filippos Giannakos <philipgian@grnet.gr>
---
 debian/control |    1 +
 1 file changed, 1 insertion(+)

diff --git a/debian/control b/debian/control
index eefb4ee..fbf517b 100644
--- a/debian/control
+++ b/debian/control
@@ -8,6 +8,7 @@ Maintainer: Laszlo Boszormenyi (GCS) <gcs@debian.hu>
 Uploaders: Sage Weil <sage@newdream.net>
 Build-Depends: debhelper (>= 6.0.7~), autotools-dev, autoconf, automake, libfuse-dev, libboost-dev (>= 1.34), libboost-thread-dev, libedit-dev, libnss3-dev, libtool, libexpat1-dev, libfcgi-dev, libatomic-ops-dev, libgoogle-perftools-dev [i386 amd64], pkg-config, libcurl4-gnutls-dev, libkeyutils-dev, uuid-dev, libaio-dev, python (>= 2.6.6-3~), libxml2-dev, javahelper, default-jdk, junit4, libboost-program-options-dev
 Standards-Version: 3.9.3
+X-Python-Version: >=2.6
 
 Package: ceph
 Architecture: linux-any
-- 
1.7.10.4

