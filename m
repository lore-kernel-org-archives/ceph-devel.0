From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/5] ceph: use timespec64 in for keepalive
Date: Wed, 20 Jun 2018 17:50:33 +0200
Message-ID: <20180620155101.57685-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "David S. Miller" <davem@davemloft.net>
Cc: y2038@lists.linaro.org, ceph-devel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

ceph_con_keepalive_expired() is the last user of timespec_add() and some
of the last uses of ktime_get_real_ts().  Replacing this with timespec64
based interfaces  lets us remove that deprecated API.

I'm introducing new ceph_encode_timespec64()/ceph_decode_timespec64()
here that take timespec64 structures and convert to/from ceph_timespec,
which is defined to have an unsigned 32-bit tv_sec member. This extends
the range of valid times to year 2106, avoiding the year 2038 overflow.

The ceph file system portion still uses the old functions for inode
timestamps, this will be done separately after the VFS layer is converted.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/ceph/decode.h    | 20 +++++++++++++++++++-
 include/linux/ceph/messenger.h |  2 +-
 net/ceph/auth_x.c              | 14 +++++++-------
 net/ceph/auth_x.h              |  2 +-
 net/ceph/cls_lock_client.c     |  4 ++--
 net/ceph/messenger.c           | 20 ++++++++++----------
 6 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index d143ac8879c6..45efe09fb7b4 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -194,8 +194,26 @@ ceph_decode_skip_n(p, end, sizeof(u8), bad)
 	} while (0)
 
 /*
- * struct ceph_timespec <-> struct timespec
+ * struct ceph_timespec <-> struct timespec64
  */
+static inline void ceph_decode_timespec64(struct timespec64 *ts,
+					const struct ceph_timespec *tv)
+{
+	/*
+	 * this will still overflow in year 2106. We could extend
+	 * the protocol to steal two more bits from tv_nsec to
+	 * add three more 136 year epochs after that the way ext4
+	 * does if necessary.
+	 */
+	ts->tv_sec = (time64_t)le32_to_cpu(tv->tv_sec);
+	ts->tv_nsec = (long)le32_to_cpu(tv->tv_nsec);
+}
+static inline void ceph_encode_timespec64(struct ceph_timespec *tv,
+					const struct timespec64 *ts)
+{
+	tv->tv_sec = cpu_to_le32((u32)ts->tv_sec);
+	tv->tv_nsec = cpu_to_le32((u32)ts->tv_nsec);
+}
 static inline void ceph_decode_timespec(struct timespec *ts,
 					const struct ceph_timespec *tv)
 {
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index c7dfcb8a1fb2..a718b877c597 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -330,7 +330,7 @@ struct ceph_connection {
 	int in_base_pos;     /* bytes read */
 	__le64 in_temp_ack;  /* for reading an ack */
 
-	struct timespec last_keepalive_ack; /* keepalive2 ack stamp */
+	struct timespec64 last_keepalive_ack; /* keepalive2 ack stamp */
 
 	struct delayed_work work;	    /* send|recv work */
 	unsigned long       delay;          /* current delay interval */
diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 2f4a1baf5f52..b05c3a540a5a 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -149,12 +149,12 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	void *dp, *dend;
 	int dlen;
 	char is_enc;
-	struct timespec validity;
+	struct timespec64 validity;
 	void *tp, *tpend;
 	void **ptp;
 	struct ceph_crypto_key new_session_key = { 0 };
 	struct ceph_buffer *new_ticket_blob;
-	unsigned long new_expires, new_renew_after;
+	time64_t new_expires, new_renew_after;
 	u64 new_secret_id;
 	int ret;
 
@@ -189,11 +189,11 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	if (ret)
 		goto out;
 
-	ceph_decode_timespec(&validity, dp);
+	ceph_decode_timespec64(&validity, dp);
 	dp += sizeof(struct ceph_timespec);
-	new_expires = get_seconds() + validity.tv_sec;
+	new_expires = ktime_get_real_seconds() + validity.tv_sec;
 	new_renew_after = new_expires - (validity.tv_sec / 4);
-	dout(" expires=%lu renew_after=%lu\n", new_expires,
+	dout(" expires=%llu renew_after=%llu\n", new_expires,
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
 
diff --git a/net/ceph/auth_x.h b/net/ceph/auth_x.h
index 454cb54568af..57ba99f7736f 100644
--- a/net/ceph/auth_x.h
+++ b/net/ceph/auth_x.h
@@ -22,7 +22,7 @@ struct ceph_x_ticket_handler {
 	u64 secret_id;
 	struct ceph_buffer *ticket_blob;
 
-	unsigned long renew_after, expires;
+	time64_t renew_after, expires;
 };
 
 #define CEPHX_AU_ENC_BUF_LEN	128  /* big enough for encrypted blob */
diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 8d2032b2f225..2105a6eaa66c 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -32,7 +32,7 @@ int ceph_cls_lock(struct ceph_osd_client *osdc,
 	int desc_len = strlen(desc);
 	void *p, *end;
 	struct page *lock_op_page;
-	struct timespec mtime;
+	struct timespec64 mtime;
 	int ret;
 
 	lock_op_buf_size = name_len + sizeof(__le32) +
@@ -63,7 +63,7 @@ int ceph_cls_lock(struct ceph_osd_client *osdc,
 	ceph_encode_string(&p, end, desc, desc_len);
 	/* only support infinite duration */
 	memset(&mtime, 0, sizeof(mtime));
-	ceph_encode_timespec(p, &mtime);
+	ceph_encode_timespec64(p, &mtime);
 	p += sizeof(struct ceph_timespec);
 	ceph_encode_8(&p, flags);
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index c6413c360771..3f6336248509 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1417,11 +1417,11 @@ static void prepare_write_keepalive(struct ceph_connection *con)
 	dout("prepare_write_keepalive %p\n", con);
 	con_out_kvec_reset(con);
 	if (con->peer_features & CEPH_FEATURE_MSGR_KEEPALIVE2) {
-		struct timespec now;
+		struct timespec64 now;
 
-		ktime_get_real_ts(&now);
+		ktime_get_real_ts64(&now);
 		con_out_kvec_add(con, sizeof(tag_keepalive2), &tag_keepalive2);
-		ceph_encode_timespec(&con->out_temp_keepalive2, &now);
+		ceph_encode_timespec64(&con->out_temp_keepalive2, &now);
 		con_out_kvec_add(con, sizeof(con->out_temp_keepalive2),
 				 &con->out_temp_keepalive2);
 	} else {
@@ -2555,7 +2555,7 @@ static int read_keepalive_ack(struct ceph_connection *con)
 	int ret = read_partial(con, size, size, &ceph_ts);
 	if (ret <= 0)
 		return ret;
-	ceph_decode_timespec(&con->last_keepalive_ack, &ceph_ts);
+	ceph_decode_timespec64(&con->last_keepalive_ack, &ceph_ts);
 	prepare_read_tag(con);
 	return 1;
 }
@@ -3223,12 +3223,12 @@ bool ceph_con_keepalive_expired(struct ceph_connection *con,
 {
 	if (interval > 0 &&
 	    (con->peer_features & CEPH_FEATURE_MSGR_KEEPALIVE2)) {
-		struct timespec now;
-		struct timespec ts;
-		ktime_get_real_ts(&now);
-		jiffies_to_timespec(interval, &ts);
-		ts = timespec_add(con->last_keepalive_ack, ts);
-		return timespec_compare(&now, &ts) >= 0;
+		struct timespec64 now;
+		struct timespec64 ts;
+		ktime_get_real_ts64(&now);
+		jiffies_to_timespec64(interval, &ts);
+		ts = timespec64_add(con->last_keepalive_ack, ts);
+		return timespec64_compare(&now, &ts) >= 0;
 	}
 	return false;
 }
-- 
2.9.0
