From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 06/19] crush: return CRUSH_ITEM_UNDEF for failed placements with indep
Date: Mon, 23 Dec 2013 19:09:37 +0200
Message-ID: <1387818590-30483-7-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:33197 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab3LWRKw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:10:52 -0500
Received: by mail-ea0-f182.google.com with SMTP id a15so2485026eae.13
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:10:51 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

For firstn mode, if we fail to make a valid placement choice, we just
continue and return a short result to the caller.  For indep mode, however,
we need to make the position stable, and return an undefined value on
failed placements to avoid shifting later results to the left.

Reflects ceph.git commit b1d4dd4eb044875874a1d01c01c7d766db5d0a80.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/crush/crush.h |    3 ++-
 net/ceph/crush/mapper.c     |    8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 83543c504b5a..3d6a12928560 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -19,10 +19,11 @@
 
 #define CRUSH_MAGIC 0x00010000ul   /* for detecting algorithm revisions */
 
-
 #define CRUSH_MAX_DEPTH 10  /* max crush hierarchy depth */
 
 
+#define CRUSH_ITEM_UNDEF  0x7fffffff  /* undefined result */
+
 /*
  * CRUSH uses user-defined "rules" to describe how inputs should be
  * mapped to devices.  A rule consists of sequence of steps to perform
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index dcf48bc504ea..a8605245d190 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -455,8 +455,12 @@ reject:
 		} while (retry_descent);
 
 		if (skip_rep) {
-			dprintk("skip rep\n");
-			continue;
+			if (firstn) {
+				dprintk("skip rep\n");
+				continue;
+			}
+			dprintk("undef rep, continuing\n");
+			item = CRUSH_ITEM_UNDEF;
 		}
 
 		dprintk("CHOOSE got %d\n", item);
-- 
1.7.10.4

