From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 15/15] libceph: no need to drop con->mutex for ->get_authorizer()
Date: Mon, 12 Dec 2016 21:49:00 +0100
Message-ID: <1481575740-1834-16-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34800 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932495AbcLLUuS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:18 -0500
Received: by mail-wj0-f193.google.com with SMTP id xy5so13486332wjc.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:17 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.15
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:15 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

->get_authorizer(), ->verify_authorizer_reply(), ->sign_message() and
->check_message_signature() shouldn't be doing anything with or on the
connection (like closing it or sending messages).

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index dba380429a05..770c52701efa 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1393,15 +1393,9 @@ static struct ceph_auth_handshake *get_connect_authorizer(struct ceph_connection
 		return NULL;
 	}
 
-	/* Can't hold the mutex while getting authorizer */
-	mutex_unlock(&con->mutex);
 	auth = con->ops->get_authorizer(con, auth_proto, con->auth_retry);
-	mutex_lock(&con->mutex);
-
 	if (IS_ERR(auth))
 		return auth;
-	if (con->state != CON_STATE_NEGOTIATING)
-		return ERR_PTR(-EAGAIN);
 
 	con->auth_reply_buf = auth->authorizer_reply_buf;
 	con->auth_reply_buf_len = auth->authorizer_reply_buf_len;
-- 
2.4.3

