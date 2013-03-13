From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: no outbound zero data
Date: Tue, 12 Mar 2013 20:02:59 -0500
Message-ID: <513FD043.30707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:34123 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3CMBDD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:03:03 -0400
Received: by mail-oa0-f54.google.com with SMTP id n12so531792oag.13
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:03:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is handling in write_partial_message_data() for the case where
only the length of--and no other information about--the data to be
sent has been specified.  It uses the zero page as the source of
data to send in this case.

This case doesn't occur.  All message senders set up a page array,
pagelist, or bio describing the data to be sent.  So eliminate the
block of code that handles this (but check and issue a warning for
now, just in case it happens for some reason).

This resolves:
    http://tracker.ceph.com/issues/4426

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 0d54ca4..c3f2fa1 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1506,13 +1506,10 @@ static int write_partial_message_data(struct
ceph_connection *con)
 							&length, &last_piece);
 #endif
 		} else {
-			size_t resid = data_len - msg_pos->data_pos;
-
-			page = zero_page;
-			page_offset = msg_pos->page_pos;
-			length = PAGE_SIZE - page_offset;
-			length = min(resid, length);
-			last_piece = length == resid;
+			WARN(1, "con %p data_len %u but no outbound data\n",
+				con, data_len);
+			ret = -EINVAL;
+			goto out;
 		}
 		if (do_datacrc && !msg_pos->did_page_crc) {
 			u32 crc = le32_to_cpu(msg->footer.data_crc);
-- 
1.7.9.5

