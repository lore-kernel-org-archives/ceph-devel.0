From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/9] libceph: move debugfs initialization into __ceph_open_session()
Date: Mon, 25 Jan 2016 12:29:33 +0100
Message-ID: <1453721381-20612-2-git-send-email-idryomov@gmail.com>
References: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35244 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021AbcAYLaK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 06:30:10 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so10693111wmz.2
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 03:30:09 -0800 (PST)
Received: from localhost.localdomain.com (ip-78-102-114-179.net.upcbroadband.cz. [78.102.114.179])
        by smtp.gmail.com with ESMTPSA id 75sm15796950wmo.22.2016.01.25.03.30.08
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:30:08 -0800 (PST)
In-Reply-To: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Our debugfs dir name is a concatenation of cluster fsid and client
unique ID ("global_id").  It used to be the case that we learned
global_id first, nowadays we always learn fsid first - the monmap is
sent before any auth replies are.  ceph_debugfs_client_init() call in
ceph_monc_handle_map() is therefore never executed and can be removed.

Its counterpart in handle_auth_reply() doesn't really belong there
either: having to do monc->client and unlocking early to work around
lockdep is a testament to that.  Move it into __ceph_open_session(),
where it can be called unconditionally.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/ceph_common.c |  3 +++
 net/ceph/mon_client.c  | 52 +-------------------------------------------------
 2 files changed, 4 insertions(+), 51 deletions(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index bcbec33c6a14..389dbabba17b 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -686,6 +686,9 @@ int __ceph_open_session(struct ceph_client *client, unsigned long started)
 			return client->auth_err;
 	}
 
+	pr_info("client%llu fsid %pU\n", ceph_client_id(client), &client->fsid);
+	ceph_debugfs_client_init(client);
+
 	return 0;
 }
 EXPORT_SYMBOL(__ceph_open_session);
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index de85dddc3dc0..5ab737ce4f6d 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -353,29 +353,15 @@ int ceph_monc_open_session(struct ceph_mon_client *monc)
 }
 EXPORT_SYMBOL(ceph_monc_open_session);
 
-/*
- * We require the fsid and global_id in order to initialize our
- * debugfs dir.
- */
-static bool have_debugfs_info(struct ceph_mon_client *monc)
-{
-	dout("have_debugfs_info fsid %d globalid %lld\n",
-	     (int)monc->client->have_fsid, monc->auth->global_id);
-	return monc->client->have_fsid && monc->auth->global_id > 0;
-}
-
 static void ceph_monc_handle_map(struct ceph_mon_client *monc,
 				 struct ceph_msg *msg)
 {
 	struct ceph_client *client = monc->client;
 	struct ceph_monmap *monmap = NULL, *old = monc->monmap;
 	void *p, *end;
-	int had_debugfs_info, init_debugfs = 0;
 
 	mutex_lock(&monc->mutex);
 
-	had_debugfs_info = have_debugfs_info(monc);
-
 	dout("handle_monmap\n");
 	p = msg->front.iov_base;
 	end = p + msg->front.iov_len;
@@ -395,29 +381,10 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
 	client->monc.monmap = monmap;
 	kfree(old);
 
-	if (!client->have_fsid) {
-		client->have_fsid = true;
-		if (!had_debugfs_info && have_debugfs_info(monc)) {
-			pr_info("client%lld fsid %pU\n",
-				ceph_client_id(monc->client),
-				&monc->client->fsid);
-			init_debugfs = 1;
-		}
-		mutex_unlock(&monc->mutex);
+	client->have_fsid = true;
 
-		if (init_debugfs) {
-			/*
-			 * do debugfs initialization without mutex to avoid
-			 * creating a locking dependency
-			 */
-			ceph_debugfs_client_init(monc->client);
-		}
-
-		goto out_unlocked;
-	}
 out:
 	mutex_unlock(&monc->mutex);
-out_unlocked:
 	wake_up_all(&client->auth_wq);
 }
 
@@ -915,10 +882,8 @@ static void handle_auth_reply(struct ceph_mon_client *monc,
 {
 	int ret;
 	int was_auth = 0;
-	int had_debugfs_info, init_debugfs = 0;
 
 	mutex_lock(&monc->mutex);
-	had_debugfs_info = have_debugfs_info(monc);
 	was_auth = ceph_auth_is_authenticated(monc->auth);
 	monc->pending_auth = 0;
 	ret = ceph_handle_auth_reply(monc->auth, msg->front.iov_base,
@@ -940,22 +905,7 @@ static void handle_auth_reply(struct ceph_mon_client *monc,
 		__send_subscribe(monc);
 		__resend_generic_request(monc);
 	}
-
-	if (!had_debugfs_info && have_debugfs_info(monc)) {
-		pr_info("client%lld fsid %pU\n",
-			ceph_client_id(monc->client),
-			&monc->client->fsid);
-		init_debugfs = 1;
-	}
 	mutex_unlock(&monc->mutex);
-
-	if (init_debugfs) {
-		/*
-		 * do debugfs initialization without mutex to avoid
-		 * creating a locking dependency
-		 */
-		ceph_debugfs_client_init(monc->client);
-	}
 }
 
 static int __validate_auth(struct ceph_mon_client *monc)
-- 
2.4.3

