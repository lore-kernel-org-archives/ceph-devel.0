From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/3] libceph: use target_copy() in send_linger()
Date: Tue, 16 Jun 2020 09:44:15 +0200
Message-ID: <20200616074415.9989-4-idryomov@gmail.com>
References: <20200616074415.9989-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgFPHos (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2020 03:44:48 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E2C03E96A
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2020 00:44:46 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id y6so8247908edi.3
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2020 00:44:46 -0700 (PDT)
In-Reply-To: <20200616074415.9989-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>

Instead of copying just oloc, oid and flags, copy the entire
linger target.  This is more for consistency than anything else,
as send_linger() -> submit_request() -> __submit_request() sends
the request regardless of what calc_target() says (i.e. both on
CALC_TARGET_NO_ACTION and CALC_TARGET_NEED_RESEND).

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osd_client.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2db8b44e70c2..db6abb5a5511 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3076,9 +3076,7 @@ static void send_linger(struct ceph_osd_linger_request *lreq)
 		cancel_linger_request(req);
 
 	request_reinit(req);
-	ceph_oid_copy(&req->r_base_oid, &lreq->t.base_oid);
-	ceph_oloc_copy(&req->r_base_oloc, &lreq->t.base_oloc);
-	req->r_flags = lreq->t.flags;
+	target_copy(&req->r_t, &lreq->t);
 	req->r_mtime = lreq->mtime;
 
 	mutex_lock(&lreq->lock);
-- 
2.19.2
