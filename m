From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/4] libceph: use sizeof_footer() in ceph_msg_revoke()
Date: Sat, 20 Feb 2016 17:45:29 +0100
Message-ID: <1455986729-12544-5-git-send-email-idryomov@gmail.com>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:32979 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757850AbcBTQp6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 11:45:58 -0500
Received: by mail-wm0-f41.google.com with SMTP id g62so106057933wme.0
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 08:45:58 -0800 (PST)
In-Reply-To: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Varada Kari <Varada.Kari@sandisk.com>

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index dd7c1b7f932b..43edf897c9eb 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3085,10 +3085,7 @@ void ceph_msg_revoke(struct ceph_msg *msg)
 			con->out_skip += con_out_kvec_skip(con);
 		} else {
 			BUG_ON(!msg->data_length);
-			if (con->peer_features & CEPH_FEATURE_MSG_AUTH)
-				con->out_skip += sizeof(msg->footer);
-			else
-				con->out_skip += sizeof(msg->old_footer);
+			con->out_skip += sizeof_footer(con);
 		}
 		/* data, middle, front */
 		if (msg->data_length)
-- 
2.4.3

