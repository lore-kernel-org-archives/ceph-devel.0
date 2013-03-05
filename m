From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/5] libceph: activate message data assignment checks
Date: Tue, 05 Mar 2013 07:53:51 -0600
Message-ID: <5135F8EF.3000408@inktank.com>
References: <5135F859.1090606@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:49532 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab3CENxy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 08:53:54 -0500
Received: by mail-ia0-f177.google.com with SMTP id y25so839518iay.22
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 05:53:53 -0800 (PST)
In-Reply-To: <5135F859.1090606@inktank.com>
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
---
 net/ceph/messenger.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 97506ac..5bf1bb5 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2677,10 +2677,10 @@ EXPORT_SYMBOL(ceph_con_keepalive);
 void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page **pages,
 		unsigned int page_count, size_t alignment)
 {
-	/* BUG_ON(!pages); */
-	/* BUG_ON(!page_count); */
-	/* BUG_ON(msg->pages); */
-	/* BUG_ON(msg->page_count); */
+	BUG_ON(!pages);
+	BUG_ON(!page_count);
+	BUG_ON(msg->pages);
+	BUG_ON(msg->page_count);

 	msg->pages = pages;
 	msg->page_count = page_count;
@@ -2691,8 +2691,8 @@ EXPORT_SYMBOL(ceph_msg_data_set_pages);
 void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
 				struct ceph_pagelist *pagelist)
 {
-	/* BUG_ON(!pagelist); */
-	/* BUG_ON(msg->pagelist); */
+	BUG_ON(!pagelist);
+	BUG_ON(msg->pagelist);

 	msg->pagelist = pagelist;
 }
@@ -2700,8 +2700,8 @@ EXPORT_SYMBOL(ceph_msg_data_set_pagelist);

 void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio)
 {
-	/* BUG_ON(!bio); */
-	/* BUG_ON(msg->bio); */
+	BUG_ON(!bio);
+	BUG_ON(msg->bio);

 	msg->bio = bio;
 }
@@ -2709,8 +2709,8 @@ EXPORT_SYMBOL(ceph_msg_data_set_bio);

 void ceph_msg_data_set_trail(struct ceph_msg *msg, struct ceph_pagelist
*trail)
 {
-	/* BUG_ON(!trail); */
-	/* BUG_ON(msg->trail); */
+	BUG_ON(!trail);
+	BUG_ON(msg->trail);

 	msg->trail = trail;
 }
-- 
1.7.9.5

