From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/5] libceph: nuke time_sub()
Date: Thu, 21 May 2015 15:35:02 +0300
Message-ID: <1432211706-10473-2-git-send-email-idryomov@gmail.com>
References: <1432211706-10473-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34293 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbbEUMfb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 08:35:31 -0400
Received: by wghq2 with SMTP id q2so84161134wgh.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 05:35:30 -0700 (PDT)
In-Reply-To: <1432211706-10473-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

Unused since ceph got merged into mainline I guess.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/libceph.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 30f92cefaa72..85ae9a889a3f 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -93,15 +93,6 @@ enum {
 	CEPH_MOUNT_SHUTDOWN,
 };
 
-/*
- * subtract jiffies
- */
-static inline unsigned long time_sub(unsigned long a, unsigned long b)
-{
-	BUG_ON(time_after(b, a));
-	return (long)a - (long)b;
-}
-
 struct ceph_mds_client;
 
 /*
-- 
1.9.3

