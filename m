From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] libceph: eliminate unnecessary allocation in process_one_ticket()
Date: Mon, 27 Oct 2014 19:06:12 +0300
Message-ID: <1414425972-10703-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36125 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbaJ0QGX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 12:06:23 -0400
Received: by mail-lb0-f174.google.com with SMTP id p9so5921043lbv.5
        for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 09:06:22 -0700 (PDT)
Received: from localhost ([109.110.67.111])
        by mx.google.com with ESMTPSA id g5sm346461lam.1.2014.10.27.09.06.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Oct 2014 09:06:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Commit c27a3e4d667f ("libceph: do not hard code max auth ticket len")
while fixing a buffer overlow tried to keep the same as much of the
surrounding code as possible and introduced an unnecessary kmalloc() in
the unencrypted ticket path.  It is likely to fail on huge tickets, so
get rid of it.

Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
---
 net/ceph/auth_x.c |   25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index de6662b14e1f..7e38b729696a 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -149,6 +149,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	struct ceph_crypto_key old_key;
 	void *ticket_buf = NULL;
 	void *tp, *tpend;
+	void **ptp;
 	struct ceph_timespec new_validity;
 	struct ceph_crypto_key new_session_key;
 	struct ceph_buffer *new_ticket_blob;
@@ -208,25 +209,19 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 			goto out;
 		}
 		tp = ticket_buf;
-		dlen = ceph_decode_32(&tp);
+		ptp = &tp;
+		tpend = *ptp + dlen;
 	} else {
 		/* unencrypted */
-		ceph_decode_32_safe(p, end, dlen, bad);
-		ticket_buf = kmalloc(dlen, GFP_NOFS);
-		if (!ticket_buf) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		tp = ticket_buf;
-		ceph_decode_need(p, end, dlen, bad);
-		ceph_decode_copy(p, ticket_buf, dlen);
+		ptp = p;
+		tpend = end;
 	}
-	tpend = tp + dlen;
+	ceph_decode_32_safe(ptp, tpend, dlen, bad);
 	dout(" ticket blob is %d bytes\n", dlen);
-	ceph_decode_need(&tp, tpend, 1 + sizeof(u64), bad);
-	blob_struct_v = ceph_decode_8(&tp);
-	new_secret_id = ceph_decode_64(&tp);
-	ret = ceph_decode_buffer(&new_ticket_blob, &tp, tpend);
+	ceph_decode_need(ptp, tpend, 1 + sizeof(u64), bad);
+	blob_struct_v = ceph_decode_8(ptp);
+	new_secret_id = ceph_decode_64(ptp);
+	ret = ceph_decode_buffer(&new_ticket_blob, ptp, tpend);
 	if (ret)
 		goto out;
 
-- 
1.7.10.4

