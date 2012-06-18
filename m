From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/6] libceph: don't use bio_iter as a flag
Date: Mon, 18 Jun 2012 10:33:34 -0500
Message-ID: <4FDF4A4E.10803@inktank.com>
References: <4FDF4948.10306@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64225 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab2FRPdg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 11:33:36 -0400
Received: by mail-yx0-f174.google.com with SMTP id l2so3328546yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 08:33:36 -0700 (PDT)
In-Reply-To: <4FDF4948.10306@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Recently a bug was fixed in which the bio_iter field in a ceph
message was not being properly re-initialized when a message got
re-transmitted:
    commit 43643528cce60ca184fe8197efa8e8da7c89a037
    Author: Yan, Zheng <zheng.z.yan@intel.com>
    rbd: Clear ceph_msg->bio_iter for retransmitted message

We are now only initializing the bio_iter field when we are about to
start to write message data (in prepare_write_message_data()),
rather than every time we are attempting to write any portion of the
message data (in write_partial_msg_pages()).  This means we no
longer need to use the msg->bio_iter field as a flag.

So just don't do that any more.  Trust prepare_write_message_data()
to ensure msg->bio_iter is properly initialized, every time we are
about to begin writing (or re-writing) a message's bio data.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -628,7 +628,7 @@ static void prepare_write_message_data(s
 	else
 		con->out_msg_pos.page_pos = 0;
 #ifdef CONFIG_BLOCK
-	if (msg->bio && !msg->bio_iter)
+	if (msg->bio)
 		init_bio_iter(msg->bio, &msg->bio_iter, &msg->bio_seg);
 #endif
 	con->out_msg_pos.data_pos = 0;
@@ -696,10 +696,6 @@ static void prepare_write_message(struct
 		m->hdr.seq = cpu_to_le64(++con->out_seq);
 		m->needs_out_seq = false;
 	}
-#ifdef CONFIG_BLOCK
-	else
-		m->bio_iter = NULL;
-#endif

 	dout("prepare_write_message %p seq %lld type %d len %d+%d+%d %d pgs\n",
 	     m, con->out_seq, le16_to_cpu(m->hdr.type),
