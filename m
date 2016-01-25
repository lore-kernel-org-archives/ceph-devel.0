From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/9] libceph: revamp subs code, switch to SUBSCRIBE2 protocol
Date: Mon, 25 Jan 2016 12:29:35 +0100
Message-ID: <1453721381-20612-4-git-send-email-idryomov@gmail.com>
References: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35261 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907AbcAYLaM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 06:30:12 -0500
Received: by mail-wm0-f68.google.com with SMTP id 123so10693230wmz.2
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 03:30:11 -0800 (PST)
Received: from localhost.localdomain.com (ip-78-102-114-179.net.upcbroadband.cz. [78.102.114.179])
        by smtp.gmail.com with ESMTPSA id 75sm15796950wmo.22.2016.01.25.03.30.10
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:30:10 -0800 (PST)
In-Reply-To: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It is currently hard-coded in the mon_client that mdsmap and monmap
subs are continuous, while osdmap sub is always "onetime".  To better
handle full clusters/pools in the osd_client, we need to be able to
issue continuous osdmap subs.  Revamp subs code to allow us to specify
for each sub whether it should be continuous or not.

Although not strictly required for the above, switch to SUBSCRIBE2
protocol while at it, eliminating the ambiguity between a request for
"every map since X" and a request for "just the latest" when we don't
have a map yet (i.e. have epoch 0).  SUBSCRIBE2 feature bit is now
required - it's been supported since pre-argonaut (2010).

Move "got mdsmap" call to the end of ceph_mdsc_handle_map() - calling
in before we validate the epoch and successfully install the new map
can mess up mon_client sub state.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/mds_client.c               |   3 +-
 fs/ceph/super.c                    |   2 +-
 include/linux/ceph/ceph_features.h |   2 +
 include/linux/ceph/ceph_fs.h       |   4 +-
 include/linux/ceph/mon_client.h    |  28 +++--
 net/ceph/debugfs.c                 |  17 +--
 net/ceph/mon_client.c              | 210 +++++++++++++++++++++++--------------
 net/ceph/osd_client.c              |   3 +-
 8 files changed, 174 insertions(+), 95 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index e7b130a637f9..7fcb5940dcc6 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3748,7 +3748,6 @@ void ceph_mdsc_handle_map(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	dout("handle_map epoch %u len %d\n", epoch, (int)maplen);
 
 	/* do we need it? */
-	ceph_monc_got_mdsmap(&mdsc->fsc->client->monc, epoch);
 	mutex_lock(&mdsc->mutex);
 	if (mdsc->mdsmap && epoch <= mdsc->mdsmap->m_epoch) {
 		dout("handle_map epoch %u <= our %u\n",
@@ -3775,6 +3774,8 @@ void ceph_mdsc_handle_map(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	mdsc->fsc->sb->s_maxbytes = mdsc->mdsmap->m_max_file_size;
 
 	__wake_requests(mdsc, &mdsc->waiting_for_map);
+	ceph_monc_got_map(&mdsc->fsc->client->monc, CEPH_SUB_MDSMAP,
+			  mdsc->mdsmap->m_epoch);
 
 	mutex_unlock(&mdsc->mutex);
 	schedule_delayed(mdsc);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index ca4d5e8457f1..c941fd1a8eb8 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -530,7 +530,7 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 		goto fail;
 	}
 	fsc->client->extra_mon_dispatch = extra_mon_dispatch;
-	fsc->client->monc.want_mdsmap = 1;
+	ceph_monc_want_map(&fsc->client->monc, CEPH_SUB_MDSMAP, 0, true);
 
 	fsc->mount_options = fsopt;
 
diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index f89b31d45cc8..fa3f82aae3be 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -92,6 +92,7 @@ static inline u64 ceph_sanitize_features(u64 features)
  */
 #define CEPH_FEATURES_SUPPORTED_DEFAULT		\
 	(CEPH_FEATURE_NOSRCADDR |		\
+	 CEPH_FEATURE_SUBSCRIBE2 |		\
 	 CEPH_FEATURE_RECONNECT_SEQ |		\
 	 CEPH_FEATURE_PGID64 |			\
 	 CEPH_FEATURE_PGPOOL3 |			\
@@ -112,6 +113,7 @@ static inline u64 ceph_sanitize_features(u64 features)
 
 #define CEPH_FEATURES_REQUIRED_DEFAULT   \
 	(CEPH_FEATURE_NOSRCADDR |	 \
+	 CEPH_FEATURE_SUBSCRIBE2 |	 \
 	 CEPH_FEATURE_RECONNECT_SEQ |	 \
 	 CEPH_FEATURE_PGID64 |		 \
 	 CEPH_FEATURE_PGPOOL3 |		 \
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index d7d072a25c27..bf74005eedec 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -198,8 +198,8 @@ struct ceph_client_mount {
 #define CEPH_SUBSCRIBE_ONETIME    1  /* i want only 1 update after have */
 
 struct ceph_mon_subscribe_item {
-	__le64 have_version;    __le64 have;
-	__u8 onetime;
+	__le64 start;
+	__u8 flags;
 } __attribute__ ((packed));
 
 struct ceph_mon_subscribe_ack {
diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index 81810dc21f06..8b2d2f0b659e 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -68,7 +68,8 @@ struct ceph_mon_client {
 
 	bool hunting;
 	int cur_mon;                       /* last monitor i contacted */
-	unsigned long sub_sent, sub_renew_after;
+	unsigned long sub_renew_after;
+	unsigned long sub_renew_sent;
 	struct ceph_connection con;
 
 	/* pending generic requests */
@@ -76,10 +77,12 @@ struct ceph_mon_client {
 	int num_generic_requests;
 	u64 last_tid;
 
-	/* mds/osd map */
-	int want_mdsmap;
-	int want_next_osdmap; /* 1 = want, 2 = want+asked */
-	u32 have_osdmap, have_mdsmap;
+	/* subs, indexed with CEPH_SUB_* */
+	struct {
+		struct ceph_mon_subscribe_item item;
+		bool want;
+		u32 have; /* epoch */
+	} subs[3];
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_file;
@@ -93,14 +96,23 @@ extern int ceph_monmap_contains(struct ceph_monmap *m,
 extern int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl);
 extern void ceph_monc_stop(struct ceph_mon_client *monc);
 
+enum {
+	CEPH_SUB_MDSMAP = 0,
+	CEPH_SUB_MONMAP,
+	CEPH_SUB_OSDMAP,
+};
+
+extern const char *ceph_sub_str[];
+
 /*
  * The model here is to indicate that we need a new map of at least
- * epoch @want, and also call in when we receive a map.  We will
+ * epoch @epoch, and also call in when we receive a map.  We will
  * periodically rerequest the map from the monitor cluster until we
  * get what we want.
  */
-extern int ceph_monc_got_mdsmap(struct ceph_mon_client *monc, u32 have);
-extern int ceph_monc_got_osdmap(struct ceph_mon_client *monc, u32 have);
+bool ceph_monc_want_map(struct ceph_mon_client *monc, int sub, u32 epoch,
+			bool continuous);
+void ceph_monc_got_map(struct ceph_mon_client *monc, int sub, u32 epoch);
 
 extern void ceph_monc_request_next_osdmap(struct ceph_mon_client *monc);
 extern int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 593dc2eabcc8..b902fbc7863e 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -112,15 +112,20 @@ static int monc_show(struct seq_file *s, void *p)
 	struct ceph_mon_generic_request *req;
 	struct ceph_mon_client *monc = &client->monc;
 	struct rb_node *rp;
+	int i;
 
 	mutex_lock(&monc->mutex);
 
-	if (monc->have_mdsmap)
-		seq_printf(s, "have mdsmap %u\n", (unsigned int)monc->have_mdsmap);
-	if (monc->have_osdmap)
-		seq_printf(s, "have osdmap %u\n", (unsigned int)monc->have_osdmap);
-	if (monc->want_next_osdmap)
-		seq_printf(s, "want next osdmap\n");
+	for (i = 0; i < ARRAY_SIZE(monc->subs); i++) {
+		seq_printf(s, "have %s %u", ceph_sub_str[i],
+			   monc->subs[i].have);
+		if (monc->subs[i].want)
+			seq_printf(s, " want %llu%s",
+				   le64_to_cpu(monc->subs[i].item.start),
+				   (monc->subs[i].item.flags &
+					CEPH_SUBSCRIBE_ONETIME ?  "" : "+"));
+		seq_putc(s, '\n');
+	}
 
 	for (rp = rb_first(&monc->generic_request_tree); rp; rp = rb_next(rp)) {
 		__u16 op;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index d6af6ca26e8d..89029916315c 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -140,9 +140,8 @@ static int __open_session(struct ceph_mon_client *monc)
 		monc->cur_mon = r % monc->monmap->num_mon;
 		dout("open_session num=%d r=%d -> mon%d\n",
 		     monc->monmap->num_mon, r, monc->cur_mon);
-		monc->sub_sent = 0;
 		monc->sub_renew_after = jiffies;  /* i.e., expired */
-		monc->want_next_osdmap = !!monc->want_next_osdmap;
+		monc->sub_renew_sent = 0;
 
 		dout("open_session mon%d opening\n", monc->cur_mon);
 		ceph_con_open(&monc->con,
@@ -189,59 +188,58 @@ static void __schedule_delayed(struct ceph_mon_client *monc)
 			      round_jiffies_relative(delay));
 }
 
+const char *ceph_sub_str[] = {
+	[CEPH_SUB_MDSMAP] = "mdsmap",
+	[CEPH_SUB_MONMAP] = "monmap",
+	[CEPH_SUB_OSDMAP] = "osdmap",
+};
+
 /*
- * Send subscribe request for mdsmap and/or osdmap.
+ * Send subscribe request for one or more maps, according to
+ * monc->subs.
  */
 static void __send_subscribe(struct ceph_mon_client *monc)
 {
-	dout("__send_subscribe sub_sent=%u exp=%u want_osd=%d\n",
-	     (unsigned int)monc->sub_sent, __sub_expired(monc),
-	     monc->want_next_osdmap);
-	if ((__sub_expired(monc) && !monc->sub_sent) ||
-	    monc->want_next_osdmap == 1) {
-		struct ceph_msg *msg = monc->m_subscribe;
-		struct ceph_mon_subscribe_item *i;
-		void *p, *end;
-		int num;
-
-		p = msg->front.iov_base;
-		end = p + msg->front_alloc_len;
-
-		num = 1 + !!monc->want_next_osdmap + !!monc->want_mdsmap;
-		ceph_encode_32(&p, num);
-
-		if (monc->want_next_osdmap) {
-			dout("__send_subscribe to 'osdmap' %u\n",
-			     (unsigned int)monc->have_osdmap);
-			ceph_encode_string(&p, end, "osdmap", 6);
-			i = p;
-			i->have = cpu_to_le64(monc->have_osdmap);
-			i->onetime = 1;
-			p += sizeof(*i);
-			monc->want_next_osdmap = 2;  /* requested */
-		}
-		if (monc->want_mdsmap) {
-			dout("__send_subscribe to 'mdsmap' %u+\n",
-			     (unsigned int)monc->have_mdsmap);
-			ceph_encode_string(&p, end, "mdsmap", 6);
-			i = p;
-			i->have = cpu_to_le64(monc->have_mdsmap);
-			i->onetime = 0;
-			p += sizeof(*i);
-		}
-		ceph_encode_string(&p, end, "monmap", 6);
-		i = p;
-		i->have = 0;
-		i->onetime = 0;
-		p += sizeof(*i);
-
-		msg->front.iov_len = p - msg->front.iov_base;
-		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
-		ceph_msg_revoke(msg);
-		ceph_con_send(&monc->con, ceph_msg_get(msg));
-
-		monc->sub_sent = jiffies | 1;  /* never 0 */
+	struct ceph_msg *msg = monc->m_subscribe;
+	void *p = msg->front.iov_base;
+	void *const end = p + msg->front_alloc_len;
+	int num = 0;
+	int i;
+
+	dout("%s sent %lu\n", __func__, monc->sub_renew_sent);
+
+	BUG_ON(monc->cur_mon < 0);
+
+	if (!monc->sub_renew_sent)
+		monc->sub_renew_sent = jiffies | 1; /* never 0 */
+
+	msg->hdr.version = cpu_to_le16(2);
+
+	for (i = 0; i < ARRAY_SIZE(monc->subs); i++) {
+		if (monc->subs[i].want)
+			num++;
 	}
+	BUG_ON(num < 1); /* monmap sub is always there */
+	ceph_encode_32(&p, num);
+	for (i = 0; i < ARRAY_SIZE(monc->subs); i++) {
+		const char *s = ceph_sub_str[i];
+
+		if (!monc->subs[i].want)
+			continue;
+
+		dout("%s %s start %llu flags 0x%x\n", __func__, s,
+		     le64_to_cpu(monc->subs[i].item.start),
+		     monc->subs[i].item.flags);
+		ceph_encode_string(&p, end, s, strlen(s));
+		memcpy(p, &monc->subs[i].item, sizeof(monc->subs[i].item));
+		p += sizeof(monc->subs[i].item);
+	}
+
+	BUG_ON(p != (end - 35 - (ARRAY_SIZE(monc->subs) - num) * 19));
+	msg->front.iov_len = p - msg->front.iov_base;
+	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
+	ceph_msg_revoke(msg);
+	ceph_con_send(&monc->con, ceph_msg_get(msg));
 }
 
 static void handle_subscribe_ack(struct ceph_mon_client *monc,
@@ -255,9 +253,16 @@ static void handle_subscribe_ack(struct ceph_mon_client *monc,
 	seconds = le32_to_cpu(h->duration);
 
 	mutex_lock(&monc->mutex);
-	dout("handle_subscribe_ack after %d seconds\n", seconds);
-	monc->sub_renew_after = monc->sub_sent + (seconds >> 1)*HZ - 1;
-	monc->sub_sent = 0;
+	if (monc->sub_renew_sent) {
+		monc->sub_renew_after = monc->sub_renew_sent +
+					    (seconds >> 1) * HZ - 1;
+		dout("%s sent %lu duration %d renew after %lu\n", __func__,
+		     monc->sub_renew_sent, seconds, monc->sub_renew_after);
+		monc->sub_renew_sent = 0;
+	} else {
+		dout("%s sent %lu renew after %lu, ignoring\n", __func__,
+		     monc->sub_renew_sent, monc->sub_renew_after);
+	}
 	mutex_unlock(&monc->mutex);
 	return;
 bad:
@@ -266,36 +271,82 @@ bad:
 }
 
 /*
- * Keep track of which maps we have
+ * Register interest in a map
+ *
+ * @sub: one of CEPH_SUB_*
+ * @epoch: X for "every map since X", or 0 for "just the latest"
  */
-int ceph_monc_got_mdsmap(struct ceph_mon_client *monc, u32 got)
+static bool __ceph_monc_want_map(struct ceph_mon_client *monc, int sub,
+				 u32 epoch, bool continuous)
+{
+	__le64 start = cpu_to_le64(epoch);
+	u8 flags = !continuous ? CEPH_SUBSCRIBE_ONETIME : 0;
+
+	dout("%s %s epoch %u continuous %d\n", __func__, ceph_sub_str[sub],
+	     epoch, continuous);
+
+	if (monc->subs[sub].want &&
+	    monc->subs[sub].item.start == start &&
+	    monc->subs[sub].item.flags == flags)
+		return false;
+
+	monc->subs[sub].item.start = start;
+	monc->subs[sub].item.flags = flags;
+	monc->subs[sub].want = true;
+
+	return true;
+}
+
+bool ceph_monc_want_map(struct ceph_mon_client *monc, int sub, u32 epoch,
+			bool continuous)
 {
+	bool need_request;
+
 	mutex_lock(&monc->mutex);
-	monc->have_mdsmap = got;
+	need_request = __ceph_monc_want_map(monc, sub, epoch, continuous);
 	mutex_unlock(&monc->mutex);
-	return 0;
+
+	return need_request;
 }
-EXPORT_SYMBOL(ceph_monc_got_mdsmap);
+EXPORT_SYMBOL(ceph_monc_want_map);
 
-int ceph_monc_got_osdmap(struct ceph_mon_client *monc, u32 got)
+/*
+ * Keep track of which maps we have
+ *
+ * @sub: one of CEPH_SUB_*
+ */
+static void __ceph_monc_got_map(struct ceph_mon_client *monc, int sub,
+				u32 epoch)
+{
+	dout("%s %s epoch %u\n", __func__, ceph_sub_str[sub], epoch);
+
+	if (monc->subs[sub].want) {
+		if (monc->subs[sub].item.flags & CEPH_SUBSCRIBE_ONETIME)
+			monc->subs[sub].want = false;
+		else
+			monc->subs[sub].item.start = cpu_to_le64(epoch + 1);
+	}
+
+	monc->subs[sub].have = epoch;
+}
+
+void ceph_monc_got_map(struct ceph_mon_client *monc, int sub, u32 epoch)
 {
 	mutex_lock(&monc->mutex);
-	monc->have_osdmap = got;
-	monc->want_next_osdmap = 0;
+	__ceph_monc_got_map(monc, sub, epoch);
 	mutex_unlock(&monc->mutex);
-	return 0;
 }
+EXPORT_SYMBOL(ceph_monc_got_map);
 
 /*
  * Register interest in the next osdmap
  */
 void ceph_monc_request_next_osdmap(struct ceph_mon_client *monc)
 {
-	dout("request_next_osdmap have %u\n", monc->have_osdmap);
+	dout("%s have %u\n", __func__, monc->subs[CEPH_SUB_OSDMAP].have);
 	mutex_lock(&monc->mutex);
-	if (!monc->want_next_osdmap)
-		monc->want_next_osdmap = 1;
-	if (monc->want_next_osdmap < 2)
+	if (__ceph_monc_want_map(monc, CEPH_SUB_OSDMAP,
+				 monc->subs[CEPH_SUB_OSDMAP].have + 1, false))
 		__send_subscribe(monc);
 	mutex_unlock(&monc->mutex);
 }
@@ -314,15 +365,15 @@ int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
 	long ret;
 
 	mutex_lock(&monc->mutex);
-	while (monc->have_osdmap < epoch) {
+	while (monc->subs[CEPH_SUB_OSDMAP].have < epoch) {
 		mutex_unlock(&monc->mutex);
 
 		if (timeout && time_after_eq(jiffies, started + timeout))
 			return -ETIMEDOUT;
 
 		ret = wait_event_interruptible_timeout(monc->client->auth_wq,
-						monc->have_osdmap >= epoch,
-						ceph_timeout_jiffies(timeout));
+				     monc->subs[CEPH_SUB_OSDMAP].have >= epoch,
+				     ceph_timeout_jiffies(timeout));
 		if (ret < 0)
 			return ret;
 
@@ -335,11 +386,14 @@ int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
 EXPORT_SYMBOL(ceph_monc_wait_osdmap);
 
 /*
- *
+ * Open a session with a random monitor.  Request monmap and osdmap,
+ * which are waited upon in __ceph_open_session().
  */
 int ceph_monc_open_session(struct ceph_mon_client *monc)
 {
 	mutex_lock(&monc->mutex);
+	__ceph_monc_want_map(monc, CEPH_SUB_MONMAP, 0, true);
+	__ceph_monc_want_map(monc, CEPH_SUB_OSDMAP, 0, false);
 	__open_session(monc);
 	__schedule_delayed(monc);
 	mutex_unlock(&monc->mutex);
@@ -375,6 +429,7 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
 	client->monc.monmap = monmap;
 	kfree(old);
 
+	__ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc->monmap->epoch);
 	client->have_fsid = true;
 
 out:
@@ -725,8 +780,14 @@ static void delayed_work(struct work_struct *work)
 			__validate_auth(monc);
 		}
 
-		if (is_auth)
-			__send_subscribe(monc);
+		if (is_auth) {
+			unsigned long now = jiffies;
+
+			dout("%s renew subs? now %lu renew after %lu\n",
+			     __func__, now, monc->sub_renew_after);
+			if (time_after_eq(now, monc->sub_renew_after))
+				__send_subscribe(monc);
+		}
 	}
 	__schedule_delayed(monc);
 	mutex_unlock(&monc->mutex);
@@ -815,16 +876,13 @@ int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl)
 	monc->cur_mon = -1;
 	monc->hunting = true;
 	monc->sub_renew_after = jiffies;
-	monc->sub_sent = 0;
+	monc->sub_renew_sent = 0;
 
 	INIT_DELAYED_WORK(&monc->delayed_work, delayed_work);
 	monc->generic_request_tree = RB_ROOT;
 	monc->num_generic_requests = 0;
 	monc->last_tid = 0;
 
-	monc->have_mdsmap = 0;
-	monc->have_osdmap = 0;
-	monc->want_next_osdmap = 1;
 	return 0;
 
 out_auth_reply:
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f8f235930d88..a1babb77b813 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2177,7 +2177,8 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 		goto bad;
 done:
 	downgrade_write(&osdc->map_sem);
-	ceph_monc_got_osdmap(&osdc->client->monc, osdc->osdmap->epoch);
+	ceph_monc_got_map(&osdc->client->monc, CEPH_SUB_OSDMAP,
+			  osdc->osdmap->epoch);
 
 	/*
 	 * subscribe to subsequent osdmap updates if full to ensure
-- 
2.4.3

