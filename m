From: simon gao <simon29rock@gmail.com>
Subject: [PATCH] net : client only want latest osdmap.  If the gap with the latest version exceeds the threshold, mon will send the fullosdmap instead of incremental osdmap
Date: Fri, 10 Jul 2020 00:39:04 -0400
Message-ID: <1594355944-7137-1-git-send-email-simon29rock@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgGJEic (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jul 2020 00:38:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A717EC08C5CE
        for <ceph-devel@vger.kernel.org>; Thu,  9 Jul 2020 21:38:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so2063105pjg.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jul 2020 21:38:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: simon gao <simon29rock@gmail.com>

Fix: https://tracker.ceph.com/issues/43421
Signed-off-by: simon gao <simon29rock@gmail.com>
---
 include/linux/ceph/ceph_fs.h | 1 +
 net/ceph/mon_client.c        | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index ebf5ba6..9dcc132 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -208,6 +208,7 @@ struct ceph_client_mount {
 } __attribute__ ((packed));
 
 #define CEPH_SUBSCRIBE_ONETIME    1  /* i want only 1 update after have */
+#define CEPH_SUBSCRIBE_LATEST_OSDMAP   2  /* i want the latest fullmap, for client */ 
 
 struct ceph_mon_subscribe_item {
 	__le64 start;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 3d8c801..b0d1ce6 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -349,7 +349,8 @@ static bool __ceph_monc_want_map(struct ceph_mon_client *monc, int sub,
 {
 	__le64 start = cpu_to_le64(epoch);
 	u8 flags = !continuous ? CEPH_SUBSCRIBE_ONETIME : 0;
-
+    if (CEPH_SUB_OSDMAP == sub)
+        flags |= CEPH_SUBSCRIBE_LATEST_OSDMAP
 	dout("%s %s epoch %u continuous %d\n", __func__, ceph_sub_str[sub],
 	     epoch, continuous);
 
-- 
1.8.3.1
