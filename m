From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH 2/3] bash_completion: Add the bash_completion files to the Debian packages
Date: Tue, 28 Jun 2011 20:28:13 +0200
Message-ID: <1309285694-12399-3-git-send-email-wido@widodh.nl>
References: <1309285694-12399-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:37351 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1760809Ab1F1SiY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2011 14:38:24 -0400
In-Reply-To: <1309285694-12399-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 debian/ceph-client-tools.install |    2 ++
 debian/ceph.install              |    1 +
 debian/radosgw.install           |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/debian/ceph-client-tools.install b/debian/ceph-client-tools.install
index 205eb7c..d9b3edd 100644
--- a/debian/ceph-client-tools.install
+++ b/debian/ceph-client-tools.install
@@ -6,3 +6,5 @@ usr/share/man/man8/csyn.8
 usr/share/man/man8/rados.8
 usr/share/man/man8/rbd.8
 usr/share/man/man8/mount.ceph.8
+etc/bash_completion.d/rados
+etc/bash_completion.d/rbd
diff --git a/debian/ceph.install b/debian/ceph.install
index b1160db..53de14f 100644
--- a/debian/ceph.install
+++ b/debian/ceph.install
@@ -30,3 +30,4 @@ usr/share/man/man8/cephfs.8
 usr/share/man/man8/cauthtool.8
 usr/share/man/man8/cclsinfo.8
 usr/share/man/man8/cdebugpack.8
+etc/bash_completion.d/ceph
diff --git a/debian/radosgw.install b/debian/radosgw.install
index 0a69f45..d968edd 100644
--- a/debian/radosgw.install
+++ b/debian/radosgw.install
@@ -2,3 +2,4 @@ usr/bin/radosgw
 usr/bin/radosgw_admin
 usr/share/man/man8/radosgw.8
 usr/share/man/man8/radosgw_admin.8
+etc/bash_completion.d/radosgw_admin
-- 
1.7.0.4

