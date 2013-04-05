From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: fix possible CONFIG_BLOCK build problem
Date: Fri, 05 Apr 2013 17:17:27 -0500
Message-ID: <515F4D77.1080205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:34563 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162867Ab3DEWRa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 18:17:30 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so3644955iag.31
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 15:17:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This patch:
    15a0d7b libceph: record message data length
did not enclose some bio-specific code inside CONFIG_BLOCK as
it should have.  Fix that.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    2 ++
 net/ceph/messenger.c           |    4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index b832c0c..cdeebae 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -271,8 +271,10 @@ extern void ceph_msg_data_set_pages(struct ceph_msg
*msg, struct page **pages,
 				size_t length, size_t alignment);
 extern void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
 				struct ceph_pagelist *pagelist);
+#ifdef CONFIG_BLOCK
 extern void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio,
 				size_t length);
+#endif /* CONFIG_BLOCK */

 extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 				     bool can_fail);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index a6fda95..994192b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -817,7 +817,7 @@ static bool ceph_msg_data_bio_advance(struct
ceph_msg_data *data, size_t bytes)

 	return true;
 }
-#endif
+#endif /* CONFIG_BLOCK */

 /*
  * For a page array, a piece comes from the first page in the array
@@ -3011,6 +3011,7 @@ void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pagelist);

+#ifdef	CONFIG_BLOCK
 void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio,
 		size_t length)
 {
@@ -3028,6 +3029,7 @@ void ceph_msg_data_set_bio(struct ceph_msg *msg,
struct bio *bio,
 	msg->data_length = length;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_bio);
+#endif	/* CONFIG_BLOCK */

 /*
  * construct a new message with given type, size
-- 
1.7.9.5

