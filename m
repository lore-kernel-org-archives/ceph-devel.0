From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] libceph: add ceph_osd_state_name()
Date: Sat, 16 Feb 2013 10:57:27 -0600
Message-ID: <511FBA77.3040104@inktank.com>
References: <511FBA36.4020407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:51618 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab3BPQ5a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:57:30 -0500
Received: by mail-qc0-f176.google.com with SMTP id n41so1556989qco.21
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:57:29 -0800 (PST)
In-Reply-To: <511FBA36.4020407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add the definition of ceph_osd_state_name(), to match its
counterpart in user space.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/rados.h |    2 ++
 net/ceph/ceph_strings.c    |   15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 9c3b4aa..b65182a 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -150,6 +150,8 @@ struct ceph_eversion {
 #define CEPH_OSD_AUTOOUT (1<<2)  /* osd was automatically marked out */
 #define CEPH_OSD_NEW     (1<<3)  /* osd is new, never marked in */

+extern const char *ceph_osd_state_name(int s);
+
 /* osd weights.  fixed point value: 0x10000 == 1.0 ("in"), 0 == "out" */
 #define CEPH_OSD_IN  0x10000
 #define CEPH_OSD_OUT 0
diff --git a/net/ceph/ceph_strings.c b/net/ceph/ceph_strings.c
index 3fbda04..833075c 100644
--- a/net/ceph/ceph_strings.c
+++ b/net/ceph/ceph_strings.c
@@ -68,6 +68,21 @@ const char *ceph_osd_op_name(int op)
 	return "???";
 }

+const char *ceph_osd_state_name(int s)
+{
+	switch (s) {
+	case CEPH_OSD_EXISTS:
+		return "exists";
+	case CEPH_OSD_UP:
+		return "up";
+	case CEPH_OSD_AUTOOUT:
+		return "autoout";
+	case CEPH_OSD_NEW:
+		return "new";
+	default:
+		return "???";
+	}
+}

 const char *ceph_pool_op_name(int op)
 {
-- 
1.7.9.5

