From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: fix two messenger bugs
Date: Fri, 19 Apr 2013 17:49:24 -0500
Message-ID: <5171C9F4.1070108@inktank.com>
References: <5171C963.2050402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:40137 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964846Ab3DSWt1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 18:49:27 -0400
Received: by mail-ie0-f172.google.com with SMTP id c12so1328283ieb.31
        for <ceph-devel@vger.kernel.org>; Fri, 19 Apr 2013 15:49:27 -0700 (PDT)
In-Reply-To: <5171C963.2050402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This patch makes four small changes in the ceph messenger.

While getting copyup functionality working I found two bugs in the
messenger.  Existing paths through the code did not trigger these
problems, but they're fixed here:
    - In ceph_msg_data_pagelist_cursor_init(), the cursor's
      last_piece field was being checked against the length
      supplied.  This was OK until this commit: ccba6d98 libceph:
      implement multiple data items in a message That commit changed
      the cursor init routines to allow lengths to be supplied that
      exceeded the size of the current data item. Because of this,
      we have to use the assigned cursor resid field rather than the
      provided length in determining whether the cursor points to
      the last piece of a data item.
    - In ceph_msg_data_add_pages(), a BUG_ON() was erroneously
      catching attempts to add page data to a message if the message
      already had data assigned to it. That was OK until that same
      commit, at which point it was fine for messages to have
      multiple data items. It slipped through because that BUG_ON()
      call was present twice in that function. (You can never be too
      careful.)

In addition two other minor things are changed:
    - In ceph_msg_data_cursor_init(), the local variable "data" was
      getting assigned twice.
    - In ceph_msg_data_advance(), it was assumed that the
      type-specific advance routine would set new_piece to true
      after it advanced past the last piece. That may have been
      fine, but since we check for that case we might as well set it
      explicitly in ceph_msg_data_advance().

This resolves:
    http://tracker.ceph.com/issues/4762

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index a36d98d..91dd451 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -913,7 +913,7 @@ ceph_msg_data_pagelist_cursor_init(struct
ceph_msg_data_cursor *cursor,
 	cursor->resid = min(length, pagelist->length);
 	cursor->page = page;
 	cursor->offset = 0;
-	cursor->last_piece = length <= PAGE_SIZE;
+	cursor->last_piece = cursor->resid <= PAGE_SIZE;
 }

 static struct page *
@@ -1013,8 +1013,6 @@ static void ceph_msg_data_cursor_init(struct
ceph_msg *msg, size_t length)
 	BUG_ON(length > msg->data_length);
 	BUG_ON(list_empty(&msg->data));

-	data = list_first_entry(&msg->data, struct ceph_msg_data, links);
-
 	cursor->data_head = &msg->data;
 	cursor->total_resid = length;
 	data = list_first_entry(&msg->data, struct ceph_msg_data, links);
@@ -1088,14 +1086,15 @@ static bool ceph_msg_data_advance(struct
ceph_msg_data_cursor *cursor,
 		break;
 	}
 	cursor->total_resid -= bytes;
-	cursor->need_crc = new_piece;

 	if (!cursor->resid && cursor->total_resid) {
 		WARN_ON(!cursor->last_piece);
 		BUG_ON(list_is_last(&cursor->data->links, cursor->data_head));
 		cursor->data = list_entry_next(cursor->data, links);
 		__ceph_msg_data_cursor_init(cursor);
+		new_piece = true;
 	}
+	cursor->need_crc = new_piece;

 	return new_piece;
 }
@@ -3019,7 +3018,6 @@ void ceph_msg_data_add_pages(struct ceph_msg *msg,
struct page **pages,
 	data->length = length;
 	data->alignment = alignment & ~PAGE_MASK;

-	BUG_ON(!list_empty(&msg->data));
 	list_add_tail(&data->links, &msg->data);
 	msg->data_length += length;
 }
-- 
1.7.9.5

