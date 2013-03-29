From: Alex Elder <elder@inktank.com>
Subject: [PATCH] ceph: move max constant definitions
Date: Fri, 29 Mar 2013 16:24:15 -0500
Message-ID: <5156067F.7070404@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:39137 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab3C2VYR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 17:24:17 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so934832ief.35
        for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 14:24:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Move some definitions for max integer values out of the rbd code and
into the more central "decode.h" header file.  These really belong
in a Linux (or libc) header somewhere, but I haven't gotten around
to proposing that yet.

This is in preparation for moving some code out of rbd.c and into
the osd client.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c         |    7 -------
 include/linux/ceph/decode.h |    7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d54a045..9c97204 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -52,13 +52,6 @@
 #define	SECTOR_SHIFT	9
 #define	SECTOR_SIZE	(1ULL << SECTOR_SHIFT)

-/* It might be useful to have these defined elsewhere */
-
-#define	U8_MAX	((u8)	(~0U))
-#define	U16_MAX	((u16)	(~0U))
-#define	U32_MAX	((u32)	(~0U))
-#define	U64_MAX	((u64)	(~0ULL))
-
 #define RBD_DRV_NAME "rbd"
 #define RBD_DRV_NAME_LONG "rbd (rados block device)"

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index 360d9d0..689f1df 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -8,6 +8,13 @@

 #include <linux/ceph/types.h>

+/* This seemed to be the easiest place to define these */
+
+#define	U8_MAX	((u8)  (~0U))
+#define	U16_MAX	((u16) (~0U))
+#define	U32_MAX	((u32) (~0U))
+#define	U64_MAX	((u64) (~0ULL))
+
 /*
  * in all cases,
  *   void **p     pointer to position pointer
-- 
1.7.9.5

