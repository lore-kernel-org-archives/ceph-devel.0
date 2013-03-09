From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/7] libceph: activate message data assignment checks
Date: Sat, 09 Mar 2013 10:03:50 -0600
Message-ID: <513B5D66.3000605@inktank.com>
References: <513B5CAF.4010702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:37255 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401Ab3CIQDw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:03:52 -0500
Received: by mail-ia0-f182.google.com with SMTP id b35so627424iac.13
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:03:52 -0800 (PST)
In-Reply-To: <513B5CAF.4010702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The mds client no longer tries to assign zero-length message data,
and the osd client no longer sets its data info more than once.
This allows us to activate assertions in the messenger to verify
these things never happen.

This resolves both of these:
    http://tracker.ceph.com/issues/4263
    http://tracker.ceph.com/issues/4284

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Greg Farnum <greg@inktank.com>
---
 net/ceph/messenger.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index f48e2af..e75a03d 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2690,10 +2690,10 @@ EXPORT_SYMBOL(ceph_con_keepalive);
 void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page **pages,
 		size_t length, size_t alignment)
 {
-	/* BUG_ON(!pages); */
-	/* BUG_ON(!length); */
-	/* BUG_ON(msg->pages); */
-	/* BUG_ON(msg->length); */
+	BUG_ON(!pages);
+	BUG_ON(!length);
+	BUG_ON(msg->pages);
+	BUG_ON(msg->length);

 	msg->pages = pages;
 	msg->length = length;
@@ -2704,9 +2704,9 @@ EXPORT_SYMBOL(ceph_msg_data_set_pages);
 void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
 				struct ceph_pagelist *pagelist)
 {
-	/* BUG_ON(!pagelist); */
-	/* BUG_ON(!pagelist->length); */
-	/* BUG_ON(msg->pagelist); */
+	BUG_ON(!pagelist);
+	BUG_ON(!pagelist->length);
+	BUG_ON(msg->pagelist);

 	msg->pagelist = pagelist;
 }
@@ -2714,8 +2714,8 @@ EXPORT_SYMBOL(ceph_msg_data_set_pagelist);

 void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio)
 {
-	/* BUG_ON(!bio); */
-	/* BUG_ON(msg->bio); */
+	BUG_ON(!bio);
+	BUG_ON(msg->bio);

 	msg->bio = bio;
 }
@@ -2723,9 +2723,9 @@ EXPORT_SYMBOL(ceph_msg_data_set_bio);

 void ceph_msg_data_set_trail(struct ceph_msg *msg, struct ceph_pagelist
*trail)
 {
-	/* BUG_ON(!trail); */
-	/* BUG_ON(!trail->length); */
-	/* BUG_ON(msg->trail); */
+	BUG_ON(!trail);
+	BUG_ON(!trail->length);
+	BUG_ON(msg->trail);

 	msg->trail = trail;
 }
-- 
1.7.9.5

