From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH 3/3] bash_completion: Add to the Makefile
Date: Tue, 28 Jun 2011 20:28:14 +0200
Message-ID: <1309285694-12399-4-git-send-email-wido@widodh.nl>
References: <1309285694-12399-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:37353 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1760812Ab1F1SiY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2011 14:38:24 -0400
In-Reply-To: <1309285694-12399-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/Makefile.am |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index cffd09b..38bbf0e 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -558,6 +558,12 @@ sample.fetch_config: fetch_config
 shell_commondir = $(libdir)/ceph
 shell_common_SCRIPTS = ceph_common.sh
 
+bash_completiondir = /etc/bash_completion.d
+bash_completion_DATA = $(srcdir)/bash_completion/ceph \
+		$(srcdir)/bash_completion/rados \
+		$(srcdir)/bash_completion/rbd \
+		$(srcdir)/bash_completion/radosgw_admin
+
 libceph_includedir = $(includedir)/ceph
 libceph_include_DATA = $(srcdir)/include/ceph/libceph.h
 
@@ -1149,7 +1155,11 @@ noinst_HEADERS = \
 	tools/gui_resources.h\
 	test/osd/RadosModel.h\
 	global/pidfile.h\
-	common/sync_filesystem.h
+	common/sync_filesystem.h\
+	bash_completion/ceph\
+	bash_completion/rados\
+	bash_completion/rbd\
+	bash_completion/radosgw_admin
 
 all_sources = $(cmon_SOURCES) $(ceph_SOURCES) $(cephfs_SOURCES) $(librados_config_SOURCES) $(cauthtool_SOURCES) $(monmaptool_SOURCES) \
 	$(crushtool_SOURCES) $(osdmaptool_SOURCES) $(cconf_SOURCES) $(mount_ceph_SOURCES) $(cmds_SOURCES) \
-- 
1.7.0.4

