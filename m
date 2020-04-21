From: Roman Penyaev <rpenyaev@suse.de>
Subject: [PATCH 15/16] libceph: switch pageslist cursor to iov_iter for messenger
Date: Tue, 21 Apr 2020 15:18:49 +0200
Message-ID: <20200421131850.443228-16-rpenyaev@suse.de>
References: <20200421131850.443228-1-rpenyaev@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbgDUNTC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:19:02 -0400
In-Reply-To: <20200421131850.443228-1-rpenyaev@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, Roman Penyaev <rpenyaev@suse.de>

Though it still uses pages, ceph_msg_data_pages_next() is noop now.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
---
 include/linux/ceph/messenger.h |  1 -
 net/ceph/messenger.c           | 32 +++++++++-----------------------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 822182ac4386..ef5b0064f515 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -206,7 +206,6 @@ struct ceph_msg_data_cursor {
 		};
 		struct {				/* pagelist */
 			struct page	*page;		/* page from list */
-			size_t		offset;		/* bytes from list */
 		};
 	};
 };
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 288f3c66a4d1..c001f3c551bd 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1003,26 +1003,13 @@ ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data_cursor *cursor,
 
 	cursor->resid = min(length, pagelist->length);
 	cursor->page = page;
-	cursor->offset = 0;
+
+	ceph_msg_data_set_iter(cursor, page, 0, min(PAGE_SIZE, cursor->resid));
 }
 
 static void ceph_msg_data_pagelist_next(struct ceph_msg_data_cursor *cursor)
 {
-	struct ceph_msg_data *data = cursor->data;
-	struct ceph_pagelist *pagelist;
-
-	BUG_ON(data->type != CEPH_MSG_DATA_PAGELIST);
-
-	pagelist = data->pagelist;
-	BUG_ON(!pagelist);
-
-	BUG_ON(!cursor->page);
-	BUG_ON(cursor->offset + cursor->resid != pagelist->length);
-
-	ceph_msg_data_set_iter(cursor, cursor->page,
-			       cursor->offset % ~PAGE_MASK,
-			       min(PAGE_SIZE - cursor->offset,
-				   cursor->resid));
+	/* Nothing here */
 }
 
 static void ceph_msg_data_pagelist_advance(struct ceph_msg_data_cursor *cursor,
@@ -1036,15 +1023,11 @@ static void ceph_msg_data_pagelist_advance(struct ceph_msg_data_cursor *cursor,
 	pagelist = data->pagelist;
 	BUG_ON(!pagelist);
 
-	BUG_ON(cursor->offset + cursor->resid != pagelist->length);
-	BUG_ON((cursor->offset & ~PAGE_MASK) + bytes > PAGE_SIZE);
-
-	/* Advance the cursor offset */
+	/* Advance the cursor iter */
 
 	cursor->resid -= bytes;
-	cursor->offset += bytes;
-	/* offset of first page in pagelist is always 0 */
-	if (!bytes || cursor->offset & ~PAGE_MASK)
+	iov_iter_advance(&cursor->iter, bytes);
+	if (!bytes || iov_iter_count(&cursor->iter))
 		return;	/* more bytes to process in the current page */
 
 	if (!cursor->resid)
@@ -1054,6 +1037,9 @@ static void ceph_msg_data_pagelist_advance(struct ceph_msg_data_cursor *cursor,
 
 	BUG_ON(list_is_last(&cursor->page->lru, &pagelist->head));
 	cursor->page = list_next_entry(cursor->page, lru);
+
+	ceph_msg_data_set_iter(cursor, cursor->page, 0,
+			       min(PAGE_SIZE, cursor->resid));
 }
 
 /*
-- 
2.24.1
