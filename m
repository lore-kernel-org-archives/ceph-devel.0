From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 12/15] libceph: no need for GFP_NOFS in ceph_monc_init()
Date: Mon, 12 Dec 2016 21:48:57 +0100
Message-ID: <1481575740-1834-13-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33573 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbcLLUuP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:15 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so13766138wmu.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:14 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.12
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:12 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It's called during inital setup, when everything should be allocated
with GFP_KERNEL.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/mon_client.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index a8effc8b7280..29a0ef351c5e 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1028,21 +1028,21 @@ int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl)
 	err = -ENOMEM;
 	monc->m_subscribe_ack = ceph_msg_new(CEPH_MSG_MON_SUBSCRIBE_ACK,
 				     sizeof(struct ceph_mon_subscribe_ack),
-				     GFP_NOFS, true);
+				     GFP_KERNEL, true);
 	if (!monc->m_subscribe_ack)
 		goto out_auth;
 
-	monc->m_subscribe = ceph_msg_new(CEPH_MSG_MON_SUBSCRIBE, 128, GFP_NOFS,
-					 true);
+	monc->m_subscribe = ceph_msg_new(CEPH_MSG_MON_SUBSCRIBE, 128,
+					 GFP_KERNEL, true);
 	if (!monc->m_subscribe)
 		goto out_subscribe_ack;
 
-	monc->m_auth_reply = ceph_msg_new(CEPH_MSG_AUTH_REPLY, 4096, GFP_NOFS,
-					  true);
+	monc->m_auth_reply = ceph_msg_new(CEPH_MSG_AUTH_REPLY, 4096,
+					  GFP_KERNEL, true);
 	if (!monc->m_auth_reply)
 		goto out_subscribe;
 
-	monc->m_auth = ceph_msg_new(CEPH_MSG_AUTH, 4096, GFP_NOFS, true);
+	monc->m_auth = ceph_msg_new(CEPH_MSG_AUTH, 4096, GFP_KERNEL, true);
 	monc->pending_auth = 0;
 	if (!monc->m_auth)
 		goto out_auth_reply;
-- 
2.4.3

