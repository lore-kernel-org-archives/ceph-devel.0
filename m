From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] libceph: update ceph_osd_op_name()
Date: Sat, 16 Feb 2013 10:57:38 -0600
Message-ID: <511FBA82.2080805@inktank.com>
References: <511FBA36.4020407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:41154 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab3BPQ5l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:57:41 -0500
Received: by mail-qa0-f52.google.com with SMTP id bs12so740451qab.11
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:57:40 -0800 (PST)
In-Reply-To: <511FBA36.4020407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Update ceph_osd_op_name() to include the newly-added definitions in
"rados.h", and to match its counterpart in the user space code.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/ceph_strings.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/ceph/ceph_strings.c b/net/ceph/ceph_strings.c
index 833075c..1348df9 100644
--- a/net/ceph/ceph_strings.c
+++ b/net/ceph/ceph_strings.c
@@ -21,9 +21,15 @@ const char *ceph_osd_op_name(int op)
 	switch (op) {
 	case CEPH_OSD_OP_READ: return "read";
 	case CEPH_OSD_OP_STAT: return "stat";
+	case CEPH_OSD_OP_MAPEXT: return "mapext";
+	case CEPH_OSD_OP_SPARSE_READ: return "sparse-read";
+	case CEPH_OSD_OP_NOTIFY: return "notify";
+	case CEPH_OSD_OP_NOTIFY_ACK: return "notify-ack";
+	case CEPH_OSD_OP_ASSERT_VER: return "assert-version";

 	case CEPH_OSD_OP_MASKTRUNC: return "masktrunc";

+	case CEPH_OSD_OP_CREATE: return "create";
 	case CEPH_OSD_OP_WRITE: return "write";
 	case CEPH_OSD_OP_DELETE: return "delete";
 	case CEPH_OSD_OP_TRUNCATE: return "truncate";
@@ -39,6 +45,11 @@ const char *ceph_osd_op_name(int op)
 	case CEPH_OSD_OP_TMAPUP: return "tmapup";
 	case CEPH_OSD_OP_TMAPGET: return "tmapget";
 	case CEPH_OSD_OP_TMAPPUT: return "tmapput";
+	case CEPH_OSD_OP_WATCH: return "watch";
+
+	case CEPH_OSD_OP_CLONERANGE: return "clonerange";
+	case CEPH_OSD_OP_ASSERT_SRC_VERSION: return "assert-src-version";
+	case CEPH_OSD_OP_SRC_CMPXATTR: return "src-cmpxattr";

 	case CEPH_OSD_OP_GETXATTR: return "getxattr";
 	case CEPH_OSD_OP_GETXATTRS: return "getxattrs";
@@ -53,6 +64,10 @@ const char *ceph_osd_op_name(int op)
 	case CEPH_OSD_OP_BALANCEREADS: return "balance-reads";
 	case CEPH_OSD_OP_UNBALANCEREADS: return "unbalance-reads";
 	case CEPH_OSD_OP_SCRUB: return "scrub";
+	case CEPH_OSD_OP_SCRUB_RESERVE: return "scrub-reserve";
+	case CEPH_OSD_OP_SCRUB_UNRESERVE: return "scrub-unreserve";
+	case CEPH_OSD_OP_SCRUB_STOP: return "scrub-stop";
+	case CEPH_OSD_OP_SCRUB_MAP: return "scrub-map";

 	case CEPH_OSD_OP_WRLOCK: return "wrlock";
 	case CEPH_OSD_OP_WRUNLOCK: return "wrunlock";
@@ -64,6 +79,15 @@ const char *ceph_osd_op_name(int op)
 	case CEPH_OSD_OP_CALL: return "call";

 	case CEPH_OSD_OP_PGLS: return "pgls";
+	case CEPH_OSD_OP_PGLS_FILTER: return "pgls-filter";
+	case CEPH_OSD_OP_OMAPGETKEYS: return "omap-get-keys";
+	case CEPH_OSD_OP_OMAPGETVALS: return "omap-get-vals";
+	case CEPH_OSD_OP_OMAPGETHEADER: return "omap-get-header";
+	case CEPH_OSD_OP_OMAPGETVALSBYKEYS: return "omap-get-vals-by-keys";
+	case CEPH_OSD_OP_OMAPSETVALS: return "omap-set-vals";
+	case CEPH_OSD_OP_OMAPSETHEADER: return "omap-set-header";
+	case CEPH_OSD_OP_OMAPCLEAR: return "omap-clear";
+	case CEPH_OSD_OP_OMAPRMKEYS: return "omap-rm-keys";
 	}
 	return "???";
 }
-- 
1.7.9.5

