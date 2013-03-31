From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: account for alignment in pages cursor
Date: Sat, 30 Mar 2013 23:59:47 -0500
Message-ID: <5157C2C3.8070801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:37343 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab3CaE7u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 Mar 2013 00:59:50 -0400
Received: by mail-gh0-f174.google.com with SMTP id g10so226290ghb.33
        for <ceph-devel@vger.kernel.org>; Sat, 30 Mar 2013 21:59:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When a cursor for a page array data message is initialized it needs
to determine the initial value for cursor->last_piece.  Currently it
just checks if length is less than a page, but that's not correct.
The data in the first page in the array will be offset by a page
offset based on the alignment recorded for the data.  (All pages
thereafter will be aligned at the base of the page, so there's
no need to account for this except for the first page.)

Because this was wrong, there was a case where the length of a piece
would be calculated as all of the residual bytes in the message and
that plus the page offset could exceed the length of a page.

So fix this case.  Make sure the sum won't wrap.

This resolves a third issue described in:
    http://tracker.ceph.com/issues/4598

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
 net/ceph/messenger.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 198b902..ee16086 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -839,9 +839,10 @@ static void ceph_msg_data_pages_cursor_init(struct
ceph_msg_data *data,
 	page_count = calc_pages_for(data->alignment, (u64)data->length);
 	cursor->page_offset = data->alignment & ~PAGE_MASK;
 	cursor->page_index = 0;
-	BUG_ON(page_count > (int) USHRT_MAX);
-	cursor->page_count = (unsigned short) page_count;
-	cursor->last_piece = length <= PAGE_SIZE;
+	BUG_ON(page_count > (int)USHRT_MAX);
+	cursor->page_count = (unsigned short)page_count;
+	BUG_ON(length > SIZE_MAX - cursor->page_offset);
+	cursor->last_piece = (size_t)cursor->page_offset + length <= PAGE_SIZE;
 }

 static struct page *ceph_msg_data_pages_next(struct ceph_msg_data *data,
-- 
1.7.9.5

