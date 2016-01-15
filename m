From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/4] libceph: kill off ceph_x_ticket_handler::validity
Date: Fri, 15 Jan 2016 15:50:45 +0100
Message-ID: <1452869445-10228-5-git-send-email-idryomov@gmail.com>
References: <1452869445-10228-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33966 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbcAOOvO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jan 2016 09:51:14 -0500
Received: by mail-wm0-f68.google.com with SMTP id b14so3234230wmb.1
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jan 2016 06:51:13 -0800 (PST)
In-Reply-To: <1452869445-10228-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

With it gone, no need to preserve ceph_timespec in process_one_ticket()
either.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 6 ++----
 net/ceph/auth_x.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 05e9fc21d460..9e43a315e662 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -152,7 +152,6 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	void *ticket_buf = NULL;
 	void *tp, *tpend;
 	void **ptp;
-	struct ceph_timespec new_validity;
 	struct ceph_crypto_key new_session_key;
 	struct ceph_buffer *new_ticket_blob;
 	unsigned long new_expires, new_renew_after;
@@ -193,8 +192,8 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	if (ret)
 		goto out;
 
-	ceph_decode_copy(&dp, &new_validity, sizeof(new_validity));
-	ceph_decode_timespec(&validity, &new_validity);
+	ceph_decode_timespec(&validity, dp);
+	dp += sizeof(struct ceph_timespec);
 	new_expires = get_seconds() + validity.tv_sec;
 	new_renew_after = new_expires - (validity.tv_sec / 4);
 	dout(" expires=%lu renew_after=%lu\n", new_expires,
@@ -233,7 +232,6 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 		ceph_buffer_put(th->ticket_blob);
 	th->session_key = new_session_key;
 	th->ticket_blob = new_ticket_blob;
-	th->validity = new_validity;
 	th->secret_id = new_secret_id;
 	th->expires = new_expires;
 	th->renew_after = new_renew_after;
diff --git a/net/ceph/auth_x.h b/net/ceph/auth_x.h
index 5334b9b159c5..40b1a3cf7397 100644
--- a/net/ceph/auth_x.h
+++ b/net/ceph/auth_x.h
@@ -16,7 +16,6 @@ struct ceph_x_ticket_handler {
 	unsigned int service;
 
 	struct ceph_crypto_key session_key;
-	struct ceph_timespec validity;
 	bool have_key;
 
 	u64 secret_id;
-- 
2.4.3

