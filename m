From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 02/15] libceph: old_key in process_one_ticket() is redundant
Date: Mon, 12 Dec 2016 21:48:47 +0100
Message-ID: <1481575740-1834-3-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34546 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753187AbcLLUuF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:05 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so13806966wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:05 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.03
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:03 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Since commit 0a990e709356 ("ceph: clean up service ticket decoding"),
th->session_key isn't assigned until everything is decoded.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 4d14dc8c7746..28bde937d58a 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -148,7 +148,6 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	int dlen;
 	char is_enc;
 	struct timespec validity;
-	struct ceph_crypto_key old_key;
 	void *ticket_buf = NULL;
 	void *tp, *tpend;
 	void **ptp;
@@ -187,7 +186,6 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	if (tkt_struct_v != 1)
 		goto bad;
 
-	memcpy(&old_key, &th->session_key, sizeof(old_key));
 	ret = ceph_crypto_key_decode(&new_session_key, &dp, dend);
 	if (ret)
 		goto out;
@@ -204,7 +202,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	if (is_enc) {
 		/* encrypted */
 		dout(" encrypted ticket\n");
-		dlen = ceph_x_decrypt(&old_key, p, end, &ticket_buf, 0);
+		dlen = ceph_x_decrypt(&th->session_key, p, end, &ticket_buf, 0);
 		if (dlen < 0) {
 			ret = dlen;
 			goto out;
-- 
2.4.3

