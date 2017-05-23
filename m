From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5/5] libceph: fix error handling in process_one_ticket()
Date: Tue, 23 May 2017 18:33:58 +0200
Message-ID: <1495557238-1077-6-git-send-email-idryomov@gmail.com>
References: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33936 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933184AbdEWQeQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 12:34:16 -0400
Received: by mail-qk0-f195.google.com with SMTP id u75so23409756qka.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 09:34:16 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o15sm784055qki.47.2017.05.23.09.34.14
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 09:34:15 -0700 (PDT)
In-Reply-To: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Don't leak key internals after new_session_key is populated.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index d0126df33f1f..8757fb87dab8 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -151,7 +151,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	struct timespec validity;
 	void *tp, *tpend;
 	void **ptp;
-	struct ceph_crypto_key new_session_key;
+	struct ceph_crypto_key new_session_key = { 0 };
 	struct ceph_buffer *new_ticket_blob;
 	unsigned long new_expires, new_renew_after;
 	u64 new_secret_id;
@@ -237,13 +237,13 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	     type, ceph_entity_type_name(type), th->secret_id,
 	     (int)th->ticket_blob->vec.iov_len);
 	xi->have_keys |= th->service;
-
-out:
-	return ret;
+	return 0;
 
 bad:
 	ret = -EINVAL;
-	goto out;
+out:
+	ceph_crypto_key_destroy(&new_session_key);
+	return ret;
 }
 
 static int ceph_x_proc_ticket_reply(struct ceph_auth_client *ac,
-- 
2.4.3

