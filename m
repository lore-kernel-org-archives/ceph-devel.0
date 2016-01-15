From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/4] libceph: fix authorizer invalidation, take 2
Date: Fri, 15 Jan 2016 15:50:43 +0100
Message-ID: <1452869445-10228-3-git-send-email-idryomov@gmail.com>
References: <1452869445-10228-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36226 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbcAOOvM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jan 2016 09:51:12 -0500
Received: by mail-wm0-f66.google.com with SMTP id l65so3216035wmf.3
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jan 2016 06:51:11 -0800 (PST)
In-Reply-To: <1452869445-10228-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

Back in 2013, commit 4b8e8b5d78b8 ("libceph: fix authorizer
invalidation") tried to fix authorizer invalidation issues by clearing
validity field.  However, nothing ever consults this field, so it
doesn't force us to request any new secrets in any way and therefore we
never get out of the exponential backoff mode:

    [  129.973812] libceph: osd2 192.168.122.1:6810 connect authorization failure
    [  130.706785] libceph: osd2 192.168.122.1:6810 connect authorization failure
    [  131.710088] libceph: osd2 192.168.122.1:6810 connect authorization failure
    [  133.708321] libceph: osd2 192.168.122.1:6810 connect authorization failure
    [  137.706598] libceph: osd2 192.168.122.1:6810 connect authorization failure
    ...

AFAICT this was the case at the time 4b8e8b5d78b8 was merged, too.

Using timespec solely as a bool isn't nice, so introduce a new have_key
flag, specifically for this purpose.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 27 ++++++++++++++++++++++-----
 net/ceph/auth_x.h |  1 +
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 10d87753ed87..ab080bb18254 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -237,6 +237,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	th->secret_id = new_secret_id;
 	th->expires = new_expires;
 	th->renew_after = new_renew_after;
+	th->have_key = true;
 	dout(" got ticket service %d (%s) secret_id %lld len %d\n",
 	     type, ceph_entity_type_name(type), th->secret_id,
 	     (int)th->ticket_blob->vec.iov_len);
@@ -384,6 +385,24 @@ bad:
 	return -ERANGE;
 }
 
+static bool need_key(struct ceph_x_ticket_handler *th)
+{
+	if (!th->have_key)
+		return true;
+
+	return get_seconds() >= th->renew_after;
+}
+
+static bool have_key(struct ceph_x_ticket_handler *th)
+{
+	if (th->have_key) {
+		if (get_seconds() >= th->expires)
+			th->have_key = false;
+	}
+
+	return th->have_key;
+}
+
 static void ceph_x_validate_tickets(struct ceph_auth_client *ac, int *pneed)
 {
 	int want = ac->want_keys;
@@ -402,20 +421,18 @@ static void ceph_x_validate_tickets(struct ceph_auth_client *ac, int *pneed)
 			continue;
 
 		th = get_ticket_handler(ac, service);
-
 		if (IS_ERR(th)) {
 			*pneed |= service;
 			continue;
 		}
 
-		if (get_seconds() >= th->renew_after)
+		if (need_key(th))
 			*pneed |= service;
-		if (get_seconds() >= th->expires)
+		if (!have_key(th))
 			xi->have_keys &= ~service;
 	}
 }
 
-
 static int ceph_x_build_request(struct ceph_auth_client *ac,
 				void *buf, void *end)
 {
@@ -674,7 +691,7 @@ static void ceph_x_invalidate_authorizer(struct ceph_auth_client *ac,
 
 	th = get_ticket_handler(ac, peer_type);
 	if (!IS_ERR(th))
-		memset(&th->validity, 0, sizeof(th->validity));
+		th->have_key = false;
 }
 
 static int calcu_signature(struct ceph_x_authorizer *au,
diff --git a/net/ceph/auth_x.h b/net/ceph/auth_x.h
index e8b7c6917d47..5334b9b159c5 100644
--- a/net/ceph/auth_x.h
+++ b/net/ceph/auth_x.h
@@ -17,6 +17,7 @@ struct ceph_x_ticket_handler {
 
 	struct ceph_crypto_key session_key;
 	struct ceph_timespec validity;
+	bool have_key;
 
 	u64 secret_id;
 	struct ceph_buffer *ticket_blob;
-- 
2.4.3

