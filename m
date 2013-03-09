From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/8] libceph: advance pagelist with list_rotate_left()
Date: Sat, 09 Mar 2013 09:15:05 -0600
Message-ID: <513B51F9.3020600@inktank.com>
References: <513B5116.2020305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:48346 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915Ab3CIPPH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 10:15:07 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so3215775ieb.34
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 07:15:07 -0800 (PST)
In-Reply-To: <513B5116.2020305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

While processing an outgoing pagelist (either the data pagelist or
trail) in a ceph message, the messenger cycles through each of the
pages on the list.  This is accomplished in out_msg_pos_next(), if
the end of the first page on the list is reached, the first page is
moved to the end of the list.

There is a list operation, list_rotate_left(), which performs
exactly this operation, and by using it, what's really going on
becomes more obvious.

So replace these two list_move_tail() calls with list_rotate_left().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index fb5f6e7..2734d03 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1041,11 +1041,9 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 	con->out_msg_pos.page++;
 	con->out_msg_pos.did_page_crc = false;
 	if (in_trail)
-		list_move_tail(&page->lru,
-			       &msg->trail->head);
+		list_rotate_left(&msg->trail->head);
 	else if (msg->pagelist)
-		list_move_tail(&page->lru,
-			       &msg->pagelist->head);
+		list_rotate_left(&msg->pagelist->head);
 #ifdef CONFIG_BLOCK
 	else if (msg->bio)
 		iter_bio_next(&msg->bio_iter, &msg->bio_seg);
-- 
1.7.9.5

