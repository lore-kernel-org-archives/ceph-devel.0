From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: skip message if too big to receive
Date: Fri, 05 Apr 2013 17:18:19 -0500
Message-ID: <515F4DAB.8090805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:59920 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162980Ab3DEWSV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 18:18:21 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so3568515iak.38
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 15:18:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We know the length of our message buffers.  If we get a message
that's too long, just dump it and ignore it.

This resolves:
    http://tracker.ceph.com/issues/4664

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 994192b..ae825e44 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2207,6 +2207,12 @@ static int read_partial_message(struct
ceph_connection *con)
 		ret = ceph_con_in_msg_alloc(con, &skip);
 		if (ret < 0)
 			return ret;
+
+		if (data_len > con->in_msg->data_length) {
+			pr_warning("%s skipping long message (%u > %zd)\n",
+				__func__, data_len, con->in_msg->data_length);
+			skip = 1;
+		}
 		if (skip) {
 			/* skip this message */
 			dout("alloc_msg said skip message\n");
-- 
1.7.9.5

