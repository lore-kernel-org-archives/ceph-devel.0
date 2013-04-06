From: Alex Elder <elder@inktank.com>
Subject: [PATCH, v2] libceph: skip message if too big to receive
Date: Sat, 06 Apr 2013 15:42:06 -0500
Message-ID: <5160889E.6080600@inktank.com>
References: <515F4DAB.8090805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:53472 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759658Ab3DFUmJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Apr 2013 16:42:09 -0400
Received: by mail-ia0-f175.google.com with SMTP id e16so4037445iaa.6
        for <ceph-devel@vger.kernel.org>; Sat, 06 Apr 2013 13:42:08 -0700 (PDT)
In-Reply-To: <515F4DAB.8090805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I found a bug in this and am posting the following
update.  If a connection's alloc_msg() method sets
the skip flag, it will return with con->in_msg being
a null pointer.  The original version of this would
dereference that pointer without checking, which
causes a crash.  This version checks first.

(This and the updated patches that follow it are
available in the "review/wip-3761-4" branch of the
ceph-client git repository.)

					-Alex

We know the length of our message buffers.  If we get a message
that's too long, just dump it and ignore it.  If skip was set
then con->in_msg won't be valid, so be careful not to dereference
a null pointer in the process.

This resolves:
    http://tracker.ceph.com/issues/4664

Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: make sure con->in_msg is valid before dereferencing it

 net/ceph/messenger.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 994192b..cb5b4e6 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2207,10 +2207,18 @@ static int read_partial_message(struct
ceph_connection *con)
 		ret = ceph_con_in_msg_alloc(con, &skip);
 		if (ret < 0)
 			return ret;
+
+		BUG_ON(!con->in_msg ^ skip);
+		if (con->in_msg && data_len > con->in_msg->data_length) {
+			pr_warning("%s skipping long message (%u > %zd)\n",
+				__func__, data_len, con->in_msg->data_length);
+			ceph_msg_put(con->in_msg);
+			con->in_msg = NULL;
+			skip = 1;
+		}
 		if (skip) {
 			/* skip this message */
 			dout("alloc_msg said skip message\n");
-			BUG_ON(con->in_msg);
 			con->in_base_pos = -front_len - middle_len - data_len -
 				sizeof(m->footer);
 			con->in_tag = CEPH_MSGR_TAG_READY;
-- 
1.7.9.5


