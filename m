From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 01/15] libceph: ceph_x_encrypt_buflen() takes in_len
Date: Mon, 12 Dec 2016 21:48:46 +0100
Message-ID: <1481575740-1834-2-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33368 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbcLLUuF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:05 -0500
Received: by mail-wj0-f195.google.com with SMTP id kp2so13540062wjc.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:04 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.02
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:02 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Pass what's going to be encrypted - that's msg_b, not ticket_blob.
ceph_x_encrypt_buflen() returns the upper bound, so this doesn't change
the maxlen calculation, but makes it a bit clearer.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index a0905f04bd13..4d14dc8c7746 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -308,8 +308,8 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 	if (ret)
 		goto out_au;
 
-	maxlen = sizeof(*msg_a) + sizeof(msg_b) +
-		ceph_x_encrypt_buflen(ticket_blob_len);
+	maxlen = sizeof(*msg_a) + ticket_blob_len +
+		ceph_x_encrypt_buflen(sizeof(msg_b));
 	dout("  need len %d\n", maxlen);
 	if (au->buf && au->buf->alloc_len < maxlen) {
 		ceph_buffer_put(au->buf);
@@ -350,11 +350,12 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 			     p, end - p);
 	if (ret < 0)
 		goto out_au;
+
 	p += ret;
+	WARN_ON(p > end);
 	au->buf->vec.iov_len = p - au->buf->vec.iov_base;
 	dout(" built authorizer nonce %llx len %d\n", au->nonce,
 	     (int)au->buf->vec.iov_len);
-	BUG_ON(au->buf->vec.iov_len > maxlen);
 	return 0;
 
 out_au:
-- 
2.4.3

