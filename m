From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] libceph: use cursor for bio reads
Date: Tue, 12 Mar 2013 20:05:18 -0500
Message-ID: <513FD0CE.6000800@inktank.com>
References: <513FD092.2030106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34567 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3CMBFW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:05:22 -0400
Received: by mail-ob0-f179.google.com with SMTP id un3so491701obb.24
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:05:21 -0700 (PDT)
In-Reply-To: <513FD092.2030106@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Replace the use of the information in con->in_msg_pos for incoming
bio data.  The old in_msg_pos and the new cursor mechanism do
basically the same thing, just slightly differently.

The main functional difference is that in_msg_pos keeps track of the
length of the complete bio list, and assumed it was fully consumed
when that many bytes had been transferred.  The cursor does not assume
a length, it simply consumes all bytes in the bio list.  Because the
only user of bio data is the rbd client, and because the length of a
bio list provided by rbd client always matches the number of bytes
in the list, both ways of tracking length are equivalent.

In addition, for in_msg_pos the initial bio vector is selected as
the initial value of the bio->bi_idx, while the cursor assumes this
is zero.  Again, the rbd client always passes 0 as the initial index
so the effect is the same.

Other than that, they basically match:
    in_msg_pos      cursor
    ----------      ------
    bio_iter        bio
    bio_seg         vec_index
    page_pos        page_offset

The in_msg_pos field is initialized by a call to init_bio_iter().
The bio cursor is initialized by ceph_msg_data_cursor_init().
Both now happen in the same spot, in prepare_message_data().

The in_msg_pos field is advanced by a call to in_msg_pos_next(),
which updates page_pos and calls iter_bio_next() to move to the next
bio vector, or to the next bio in the list.  The cursor is advanced
by ceph_msg_data_advance().  That isn't currently happening so
add a call to that in in_msg_pos_next().

Finally, the next piece of data to use for a read is determined
by a bunch of lines in read_partial_message_bio().  Those can be
replaced by an equivalent ceph_msg_data_bio_next() call.

Since the read path has no need to know whether the next piece of a
bio to use is the last, allow it to pass a null pointer as its
last_piece argument to ceph_msg_data_bio_next().

This partially resolves:
    http://tracker.ceph.com/issues/4428

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 07ace1d..1b003b4 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1450,6 +1450,10 @@ static void in_msg_pos_next(struct
ceph_connection *con, size_t len,

 	msg_pos->data_pos += received;
 	msg_pos->page_pos += received;
+#ifdef CONFIG_BLOCK
+	if (ceph_msg_has_bio(msg))
+		(void) ceph_msg_data_advance(&msg->b, received);
+#endif /* CONFIG_BLOCK */
 	if (received < len)
 		return;

@@ -2225,23 +2229,14 @@ static int read_partial_message_bio(struct
ceph_connection *con,
 				    unsigned int data_len, bool do_datacrc)
 {
 	struct ceph_msg *msg = con->in_msg;
-	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
-	struct bio_vec *bv;
 	struct page *page;
 	size_t page_offset;
 	size_t length;
-	unsigned int left;
 	int ret;

 	BUG_ON(!msg);
-	BUG_ON(!msg->b.bio_iter);
-	bv = bio_iovec_idx(msg->b.bio_iter, msg->b.bio_seg);
-	page = bv->bv_page;
-	page_offset = bv->bv_offset + msg_pos->page_pos;
-	BUG_ON(msg_pos->data_pos >= data_len);
-	left = data_len - msg_pos->data_pos;
-	BUG_ON(msg_pos->page_pos >= bv->bv_len);
-	length = min_t(unsigned int, bv->bv_len - msg_pos->page_pos, left);
+
+	page = ceph_msg_data_next(&msg->b, &page_offset, &length, NULL);

 	ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
 	if (ret <= 0)
-- 
1.7.9.5

