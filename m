From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 1/2] libceph: multiple filesystem support
Date: Fri,  8 Apr 2016 14:50:25 +0800
Message-ID: <1460098226-69141-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49637 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbcDHGui (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 Apr 2016 02:50:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

When accessing non-default filesystem, cephfs client subscribes to
"mdsmap.<id>". To support this, we can't use number to stand for
map name. Instead, we need to pass map name to ceph_monc_want_map().
Map name caller provided is saved in monc->subs[] and later encoded
in MON_SUBSCRIBE message.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 include/linux/ceph/mon_client.h | 23 +++++------
 net/ceph/debugfs.c              |  2 +-
 net/ceph/mon_client.c           | 87 +++++++++++++++++++++++++----------------
 3 files changed, 67 insertions(+), 45 deletions(-)

diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index e230e7e..4aa8b3c 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -55,6 +55,13 @@ struct ceph_mon_generic_request {
 	struct ceph_msg *reply;    /* and reply */
 };
 
+/* may subscribe to mdsmap.<int> */
+#define CEPH_SUB_MAP_MAXLEN 32
+
+#define CEPH_SUB_MONMAP "mommap"
+#define CEPH_SUB_OSDMAP "osdmap"
+#define CEPH_SUB_MDSMAP "mdsmap"
+
 struct ceph_mon_client {
 	struct ceph_client *client;
 	struct ceph_monmap *monmap;
@@ -85,6 +92,7 @@ struct ceph_mon_client {
 		struct ceph_mon_subscribe_item item;
 		bool want;
 		u32 have; /* epoch */
+		char map[CEPH_SUB_MAP_MAXLEN];
 	} subs[3];
 
 #ifdef CONFIG_DEBUG_FS
@@ -99,23 +107,16 @@ extern int ceph_monmap_contains(struct ceph_monmap *m,
 extern int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl);
 extern void ceph_monc_stop(struct ceph_mon_client *monc);
 
-enum {
-	CEPH_SUB_MDSMAP = 0,
-	CEPH_SUB_MONMAP,
-	CEPH_SUB_OSDMAP,
-};
-
-extern const char *ceph_sub_str[];
-
 /*
  * The model here is to indicate that we need a new map of at least
  * epoch @epoch, and also call in when we receive a map.  We will
  * periodically rerequest the map from the monitor cluster until we
  * get what we want.
  */
-bool ceph_monc_want_map(struct ceph_mon_client *monc, int sub, u32 epoch,
-			bool continuous);
-void ceph_monc_got_map(struct ceph_mon_client *monc, int sub, u32 epoch);
+bool ceph_monc_want_map(struct ceph_mon_client *monc, const char *sub,
+			u32 epoch, bool continuous);
+void ceph_monc_got_map(struct ceph_mon_client *monc, const char *sub,
+		       u32 epoch);
 
 extern void ceph_monc_request_next_osdmap(struct ceph_mon_client *monc);
 extern int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index d44d866..7b55553 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -117,7 +117,7 @@ static int monc_show(struct seq_file *s, void *p)
 	mutex_lock(&monc->mutex);
 
 	for (i = 0; i < ARRAY_SIZE(monc->subs); i++) {
-		seq_printf(s, "have %s %u", ceph_sub_str[i],
+		seq_printf(s, "have %s %u", monc->subs[i].map,
 			   monc->subs[i].have);
 		if (monc->subs[i].want)
 			seq_printf(s, " want %llu%s",
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index cf638c0..a77b536 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -226,12 +226,6 @@ static void __schedule_delayed(struct ceph_mon_client *monc)
 			 round_jiffies_relative(delay));
 }
 
-const char *ceph_sub_str[] = {
-	[CEPH_SUB_MDSMAP] = "mdsmap",
-	[CEPH_SUB_MONMAP] = "monmap",
-	[CEPH_SUB_OSDMAP] = "osdmap",
-};
-
 /*
  * Send subscribe request for one or more maps, according to
  * monc->subs.
@@ -260,7 +254,7 @@ static void __send_subscribe(struct ceph_mon_client *monc)
 	BUG_ON(num < 1); /* monmap sub is always there */
 	ceph_encode_32(&p, num);
 	for (i = 0; i < ARRAY_SIZE(monc->subs); i++) {
-		const char *s = ceph_sub_str[i];
+		const char *s = monc->subs[i].map;
 
 		if (!monc->subs[i].want)
 			continue;
@@ -269,11 +263,11 @@ static void __send_subscribe(struct ceph_mon_client *monc)
 		     le64_to_cpu(monc->subs[i].item.start),
 		     monc->subs[i].item.flags);
 		ceph_encode_string(&p, end, s, strlen(s));
+		BUG_ON(p + sizeof(monc->subs[i].item) > end);
 		memcpy(p, &monc->subs[i].item, sizeof(monc->subs[i].item));
 		p += sizeof(monc->subs[i].item);
 	}
 
-	BUG_ON(p != (end - 35 - (ARRAY_SIZE(monc->subs) - num) * 19));
 	msg->front.iov_len = p - msg->front.iov_base;
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
 	ceph_msg_revoke(msg);
@@ -308,35 +302,58 @@ bad:
 	ceph_msg_dump(msg);
 }
 
+enum {
+	CEPH_SUB_MONMAP_IDX = 0,
+	CEPH_SUB_OSDMAP_IDX,
+	CEPH_SUB_MDSMAP_IDX,
+};
+
+static int __ceph_monc_map_idx(const char *sub)
+{
+	if (!strcmp(sub, CEPH_SUB_MONMAP))
+		return CEPH_SUB_MONMAP_IDX;
+	if (!strcmp(sub, CEPH_SUB_OSDMAP))
+		return CEPH_SUB_OSDMAP_IDX;
+	/* may subscribe to mdsmap.<int> */
+	if (!strncmp(sub, CEPH_SUB_MDSMAP, strlen(CEPH_SUB_MDSMAP)))
+		return CEPH_SUB_MDSMAP_IDX;
+	BUG_ON(1);
+	return -1;
+}
+
 /*
  * Register interest in a map
  *
  * @sub: one of CEPH_SUB_*
  * @epoch: X for "every map since X", or 0 for "just the latest"
  */
-static bool __ceph_monc_want_map(struct ceph_mon_client *monc, int sub,
+static bool __ceph_monc_want_map(struct ceph_mon_client *monc, const char *sub,
 				 u32 epoch, bool continuous)
 {
 	__le64 start = cpu_to_le64(epoch);
 	u8 flags = !continuous ? CEPH_SUBSCRIBE_ONETIME : 0;
+	int idx = __ceph_monc_map_idx(sub);
 
-	dout("%s %s epoch %u continuous %d\n", __func__, ceph_sub_str[sub],
-	     epoch, continuous);
+	dout("%s %s epoch %u continuous %d\n", __func__,
+	     sub, epoch, continuous);
 
-	if (monc->subs[sub].want &&
-	    monc->subs[sub].item.start == start &&
-	    monc->subs[sub].item.flags == flags)
+	if (monc->subs[idx].want &&
+	    monc->subs[idx].item.start == start &&
+	    monc->subs[idx].item.flags == flags)
 		return false;
 
-	monc->subs[sub].item.start = start;
-	monc->subs[sub].item.flags = flags;
-	monc->subs[sub].want = true;
+	monc->subs[idx].item.start = start;
+	monc->subs[idx].item.flags = flags;
+	monc->subs[idx].want = true;
+
+	strncpy(monc->subs[idx].map, sub, CEPH_SUB_MAP_MAXLEN);
+	monc->subs[idx].map[CEPH_SUB_MAP_MAXLEN] = 0;
 
 	return true;
 }
 
-bool ceph_monc_want_map(struct ceph_mon_client *monc, int sub, u32 epoch,
-			bool continuous)
+bool ceph_monc_want_map(struct ceph_mon_client *monc, const char *sub,
+			u32 epoch, bool continuous)
 {
 	bool need_request;
 
@@ -353,22 +370,24 @@ EXPORT_SYMBOL(ceph_monc_want_map);
  *
  * @sub: one of CEPH_SUB_*
  */
-static void __ceph_monc_got_map(struct ceph_mon_client *monc, int sub,
-				u32 epoch)
+static void __ceph_monc_got_map(struct ceph_mon_client *monc,
+				const char *sub, u32 epoch)
 {
-	dout("%s %s epoch %u\n", __func__, ceph_sub_str[sub], epoch);
+	int idx = __ceph_monc_map_idx(sub);
+	dout("%s %s epoch %u\n", __func__, monc->subs[idx].map, epoch);
 
-	if (monc->subs[sub].want) {
-		if (monc->subs[sub].item.flags & CEPH_SUBSCRIBE_ONETIME)
-			monc->subs[sub].want = false;
+	if (monc->subs[idx].want) {
+		if (monc->subs[idx].item.flags & CEPH_SUBSCRIBE_ONETIME)
+			monc->subs[idx].want = false;
 		else
-			monc->subs[sub].item.start = cpu_to_le64(epoch + 1);
+			monc->subs[idx].item.start = cpu_to_le64(epoch + 1);
 	}
 
-	monc->subs[sub].have = epoch;
+	monc->subs[idx].have = epoch;
 }
 
-void ceph_monc_got_map(struct ceph_mon_client *monc, int sub, u32 epoch)
+void ceph_monc_got_map(struct ceph_mon_client *monc,
+		       const char *sub, u32 epoch)
 {
 	mutex_lock(&monc->mutex);
 	__ceph_monc_got_map(monc, sub, epoch);
@@ -381,10 +400,11 @@ EXPORT_SYMBOL(ceph_monc_got_map);
  */
 void ceph_monc_request_next_osdmap(struct ceph_mon_client *monc)
 {
-	dout("%s have %u\n", __func__, monc->subs[CEPH_SUB_OSDMAP].have);
+	int idx = __ceph_monc_map_idx(CEPH_SUB_OSDMAP);
+	dout("%s have %u\n", __func__, monc->subs[idx].have);
 	mutex_lock(&monc->mutex);
 	if (__ceph_monc_want_map(monc, CEPH_SUB_OSDMAP,
-				 monc->subs[CEPH_SUB_OSDMAP].have + 1, false))
+				 monc->subs[idx].have + 1, false))
 		__send_subscribe(monc);
 	mutex_unlock(&monc->mutex);
 }
@@ -399,18 +419,19 @@ EXPORT_SYMBOL(ceph_monc_request_next_osdmap);
 int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
 			  unsigned long timeout)
 {
+	int idx = __ceph_monc_map_idx(CEPH_SUB_OSDMAP);
 	unsigned long started = jiffies;
 	long ret;
 
 	mutex_lock(&monc->mutex);
-	while (monc->subs[CEPH_SUB_OSDMAP].have < epoch) {
+	while (monc->subs[idx].have < epoch) {
 		mutex_unlock(&monc->mutex);
 
 		if (timeout && time_after_eq(jiffies, started + timeout))
 			return -ETIMEDOUT;
 
 		ret = wait_event_interruptible_timeout(monc->client->auth_wq,
-				     monc->subs[CEPH_SUB_OSDMAP].have >= epoch,
+				     monc->subs[idx].have >= epoch,
 				     ceph_timeout_jiffies(timeout));
 		if (ret < 0)
 			return ret;
@@ -890,7 +911,7 @@ int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl)
 	if (!monc->m_subscribe_ack)
 		goto out_auth;
 
-	monc->m_subscribe = ceph_msg_new(CEPH_MSG_MON_SUBSCRIBE, 96, GFP_NOFS,
+	monc->m_subscribe = ceph_msg_new(CEPH_MSG_MON_SUBSCRIBE, 256, GFP_NOFS,
 					 true);
 	if (!monc->m_subscribe)
 		goto out_subscribe_ack;
-- 
2.5.0

