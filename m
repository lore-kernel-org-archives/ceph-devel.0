From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH] ceph: use ktime_get_real_seconds()
Date: Wed, 20 Jun 2018 15:30:01 +0530
Message-ID: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, y2038@lists.linaro.org, Allen Pais <allen.lkml@gmail.com>
List-Id: ceph-devel.vger.kernel.org

Use ktime_get_real_seconds() as get_seconds() is deprecated.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 net/ceph/auth_x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 2f4a1ba..99561c2 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -154,7 +154,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	void **ptp;
 	struct ceph_crypto_key new_session_key = { 0 };
 	struct ceph_buffer *new_ticket_blob;
-	unsigned long new_expires, new_renew_after;
+	u32 new_expires, new_renew_after;
 	u64 new_secret_id;
 	int ret;
 
@@ -191,9 +191,9 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 
 	ceph_decode_timespec(&validity, dp);
 	dp += sizeof(struct ceph_timespec);
-	new_expires = get_seconds() + validity.tv_sec;
+	new_expires = (u32)ktime_get_real_seconds() + validity.tv_sec;
 	new_renew_after = new_expires - (validity.tv_sec / 4);
-	dout(" expires=%lu renew_after=%lu\n", new_expires,
+	dout(" expires=%u renew_after=%u\n", new_expires,
 	     new_renew_after);
 
 	/* ticket blob for service */
@@ -385,13 +385,13 @@ static bool need_key(struct ceph_x_ticket_handler *th)
 	if (!th->have_key)
 		return true;
 
-	return get_seconds() >= th->renew_after;
+	return ktime_get_real_seconds() >= th->renew_after;
 }
 
 static bool have_key(struct ceph_x_ticket_handler *th)
 {
 	if (th->have_key) {
-		if (get_seconds() >= th->expires)
+		if (ktime_get_real_seconds() >= th->expires)
 			th->have_key = false;
 	}
 
-- 
2.7.4
