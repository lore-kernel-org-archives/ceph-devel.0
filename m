From: Roman Penyaev <rpenyaev@suse.de>
Subject: [PATCH 16/16] libceph: remove ceph_msg_data_*_next() from messenger
Date: Tue, 21 Apr 2020 15:18:50 +0200
Message-ID: <20200421131850.443228-17-rpenyaev@suse.de>
References: <20200421131850.443228-1-rpenyaev@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbgDUNTD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:19:03 -0400
In-Reply-To: <20200421131850.443228-1-rpenyaev@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, Roman Penyaev <rpenyaev@suse.de>

All cursor types do not need next operation, advance handles
everything, so just remove it.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
---
 net/ceph/messenger.c | 49 --------------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index c001f3c551bd..3facb1a8c5d5 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -865,11 +865,6 @@ static void ceph_msg_data_bio_cursor_init(struct ceph_msg_data_cursor *cursor,
 	set_bio_iter_to_iov_iter(cursor);
 }
 
-static void ceph_msg_data_bio_next(struct ceph_msg_data_cursor *cursor)
-{
-	/* Nothing here */
-}
-
 static void ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
 				      size_t bytes)
 {
@@ -907,11 +902,6 @@ static void ceph_msg_data_bvecs_cursor_init(struct ceph_msg_data_cursor *cursor,
 		      data->num_bvecs, cursor->resid);
 }
 
-static void ceph_msg_data_bvecs_next(struct ceph_msg_data_cursor *cursor)
-{
-	/* Nothing here */
-}
-
 static void ceph_msg_data_bvecs_advance(struct ceph_msg_data_cursor *cursor,
 					size_t bytes)
 {
@@ -950,11 +940,6 @@ static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data_cursor *cursor,
 						cursor->resid));
 }
 
-static void ceph_msg_data_pages_next(struct ceph_msg_data_cursor *cursor)
-{
-	/* Nothing here */
-}
-
 static void ceph_msg_data_pages_advance(struct ceph_msg_data_cursor *cursor,
 					size_t bytes)
 {
@@ -1007,11 +992,6 @@ ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data_cursor *cursor,
 	ceph_msg_data_set_iter(cursor, page, 0, min(PAGE_SIZE, cursor->resid));
 }
 
-static void ceph_msg_data_pagelist_next(struct ceph_msg_data_cursor *cursor)
-{
-	/* Nothing here */
-}
-
 static void ceph_msg_data_pagelist_advance(struct ceph_msg_data_cursor *cursor,
 					   size_t bytes)
 {
@@ -1087,33 +1067,6 @@ static void ceph_msg_data_cursor_init(unsigned int dir, struct ceph_msg *msg,
 	__ceph_msg_data_cursor_init(cursor);
 }
 
-/*
- * Setups cursor->iter for the next piece to process.
- */
-static void ceph_msg_data_next(struct ceph_msg_data_cursor *cursor)
-{
-	switch (cursor->data->type) {
-	case CEPH_MSG_DATA_PAGELIST:
-		ceph_msg_data_pagelist_next(cursor);
-		break;
-	case CEPH_MSG_DATA_PAGES:
-		ceph_msg_data_pages_next(cursor);
-		break;
-#ifdef CONFIG_BLOCK
-	case CEPH_MSG_DATA_BIO:
-		ceph_msg_data_bio_next(cursor);
-		break;
-#endif /* CONFIG_BLOCK */
-	case CEPH_MSG_DATA_BVECS:
-		ceph_msg_data_bvecs_next(cursor);
-		break;
-	case CEPH_MSG_DATA_NONE:
-	default:
-		BUG();
-		break;
-	}
-}
-
 static void ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor,
 				  size_t bytes)
 {
@@ -1519,7 +1472,6 @@ static int write_partial_message_data(struct ceph_connection *con)
 			continue;
 		}
 
-		ceph_msg_data_next(cursor);
 		ret = ceph_tcp_sendiov(con->sock, &cursor->iter, true);
 		if (ret <= 0) {
 			if (do_datacrc)
@@ -2260,7 +2212,6 @@ static int read_partial_msg_data(struct ceph_connection *con)
 			continue;
 		}
 
-		ceph_msg_data_next(cursor);
 		ret = ceph_tcp_recviov(con->sock, &cursor->iter);
 		if (ret <= 0) {
 			if (do_datacrc)
-- 
2.24.1
