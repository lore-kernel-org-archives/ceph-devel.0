From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/5] libceph: a couple tweaks for wait loops
Date: Thu, 21 May 2015 15:35:04 +0300
Message-ID: <1432211706-10473-4-git-send-email-idryomov@gmail.com>
References: <1432211706-10473-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37410 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbbEUMfe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 08:35:34 -0400
Received: by wibt6 with SMTP id t6so12235886wib.0
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 05:35:33 -0700 (PDT)
In-Reply-To: <1432211706-10473-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

- return -ETIMEDOUT instead of -EIO in case of timeout
- wait_event_interruptible_timeout() returns time left until timeout
  and since it can be almost LONG_MAX we had better assign it to long

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/ceph_common.c | 7 +++----
 net/ceph/mon_client.c  | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index a80e91c2c9a3..925d0c890b80 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -647,8 +647,8 @@ static int have_mon_and_osd_map(struct ceph_client *client)
  */
 int __ceph_open_session(struct ceph_client *client, unsigned long started)
 {
-	int err;
 	unsigned long timeout = client->options->mount_timeout;
+	long err;
 
 	/* open session, and wait for mon and osd maps */
 	err = ceph_monc_open_session(&client->monc);
@@ -656,16 +656,15 @@ int __ceph_open_session(struct ceph_client *client, unsigned long started)
 		return err;
 
 	while (!have_mon_and_osd_map(client)) {
-		err = -EIO;
 		if (timeout && time_after_eq(jiffies, started + timeout))
-			return err;
+			return -ETIMEDOUT;
 
 		/* wait */
 		dout("mount waiting for mon_map\n");
 		err = wait_event_interruptible_timeout(client->auth_wq,
 			have_mon_and_osd_map(client) || (client->auth_err < 0),
 			ceph_timeout_jiffies(timeout));
-		if (err == -EINTR || err == -ERESTARTSYS)
+		if (err < 0)
 			return err;
 		if (client->auth_err < 0)
 			return client->auth_err;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 0da3bdc116f7..9d6ff1215928 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -308,7 +308,7 @@ int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
 			  unsigned long timeout)
 {
 	unsigned long started = jiffies;
-	int ret;
+	long ret;
 
 	mutex_lock(&monc->mutex);
 	while (monc->have_osdmap < epoch) {
-- 
1.9.3

