From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] libceph: use keepalive2 to verify the mon session is alive
Date: Tue,  1 Sep 2015 22:21:55 +0800
Message-ID: <1441117315-96386-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38782 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147AbbIAOWP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Sep 2015 10:22:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 include/linux/ceph/libceph.h   |  2 ++
 include/linux/ceph/messenger.h |  4 +++
 include/linux/ceph/msgr.h      |  4 ++-
 net/ceph/ceph_common.c         | 18 ++++++++++++-
 net/ceph/messenger.c           | 60 ++++++++++++++++++++++++++++++++++++++----
 net/ceph/mon_client.c          | 38 ++++++++++++++++++++------
 6 files changed, 111 insertions(+), 15 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 9ebee53..9a0b471 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -46,6 +46,7 @@ struct ceph_options {
 	unsigned long mount_timeout;		/* jiffies */
 	unsigned long osd_idle_ttl;		/* jiffies */
 	unsigned long osd_keepalive_timeout;	/* jiffies */
+	unsigned long mon_keepalive_timeout;	/* jiffies */
 
 	/*
 	 * any type that can't be simply compared or doesn't need need
@@ -66,6 +67,7 @@ struct ceph_options {
 #define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
 #define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
 #define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
+#define CEPH_MON_KEEPALIVE_DEFAULT	msecs_to_jiffies(30 * 1000)
 
 #define CEPH_MSG_MAX_FRONT_LEN	(16*1024*1024)
 #define CEPH_MSG_MAX_MIDDLE_LEN	(16*1024*1024)
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 3775327..83063b6 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -248,6 +248,8 @@ struct ceph_connection {
 	int in_base_pos;     /* bytes read */
 	__le64 in_temp_ack;  /* for reading an ack */
 
+	struct timespec last_keepalive_ack;
+
 	struct delayed_work work;	    /* send|recv work */
 	unsigned long       delay;          /* current delay interval */
 };
@@ -285,6 +287,8 @@ extern void ceph_msg_revoke(struct ceph_msg *msg);
 extern void ceph_msg_revoke_incoming(struct ceph_msg *msg);
 
 extern void ceph_con_keepalive(struct ceph_connection *con);
+extern int ceph_con_keepalive_expired(struct ceph_connection *con,
+				      unsigned long interval);
 
 extern void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
 				size_t length, size_t alignment);
diff --git a/include/linux/ceph/msgr.h b/include/linux/ceph/msgr.h
index 1c18872..0fe2656 100644
--- a/include/linux/ceph/msgr.h
+++ b/include/linux/ceph/msgr.h
@@ -84,10 +84,12 @@ struct ceph_entity_inst {
 #define CEPH_MSGR_TAG_MSG           7  /* message */
 #define CEPH_MSGR_TAG_ACK           8  /* message ack */
 #define CEPH_MSGR_TAG_KEEPALIVE     9  /* just a keepalive byte! */
-#define CEPH_MSGR_TAG_BADPROTOVER  10  /* bad protocol version */
+#define CEPH_MSGR_TAG_BADPROTOVER   10 /* bad protocol version */
 #define CEPH_MSGR_TAG_BADAUTHORIZER 11 /* bad authorizer */
 #define CEPH_MSGR_TAG_FEATURES      12 /* insufficient features */
 #define CEPH_MSGR_TAG_SEQ           13 /* 64-bit int follows with seen seq number */
+#define CEPH_MSGR_TAG_KEEPALIVE2    14 /* keepalive2 byte + ceph_timespec */
+#define CEPH_MSGR_TAG_KEEPALIVE2_ACK 15 /* keepalive2 reply */
 
 
 /*
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index f30329f..5143f6e 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -226,6 +226,7 @@ static int parse_fsid(const char *str, struct ceph_fsid *fsid)
  * ceph options
  */
 enum {
+	Opt_monkeepalivetimeout,
 	Opt_osdtimeout,
 	Opt_osdkeepalivetimeout,
 	Opt_mount_timeout,
@@ -250,6 +251,7 @@ enum {
 };
 
 static match_table_t opt_tokens = {
+	{Opt_monkeepalivetimeout, "monkeepalive=%d"},
 	{Opt_osdtimeout, "osdtimeout=%d"},
 	{Opt_osdkeepalivetimeout, "osdkeepalive=%d"},
 	{Opt_mount_timeout, "mount_timeout=%d"},
@@ -354,9 +356,10 @@ ceph_parse_options(char *options, const char *dev_name,
 
 	/* start with defaults */
 	opt->flags = CEPH_OPT_DEFAULT;
-	opt->osd_keepalive_timeout = CEPH_OSD_KEEPALIVE_DEFAULT;
 	opt->mount_timeout = CEPH_MOUNT_TIMEOUT_DEFAULT;
 	opt->osd_idle_ttl = CEPH_OSD_IDLE_TTL_DEFAULT;
+	opt->osd_keepalive_timeout = CEPH_OSD_KEEPALIVE_DEFAULT;
+	opt->mon_keepalive_timeout = CEPH_MON_KEEPALIVE_DEFAULT;
 
 	/* get mon ip(s) */
 	/* ip1[:port1][,ip2[:port2]...] */
@@ -460,6 +463,16 @@ ceph_parse_options(char *options, const char *dev_name,
 			}
 			opt->osd_idle_ttl = msecs_to_jiffies(intval * 1000);
 			break;
+		case Opt_monkeepalivetimeout:
+			/* 0 isn't well defined right now, reject it */
+			if (intval < 1 || intval > INT_MAX / 1000) {
+				pr_err("monkeepalive out of range\n");
+				err = -EINVAL;
+				goto out;
+			}
+			opt->mon_keepalive_timeout =
+					msecs_to_jiffies(intval * 1000);
+			break;
 		case Opt_mount_timeout:
 			/* 0 is "wait forever" (i.e. infinite timeout) */
 			if (intval < 0 || intval > INT_MAX / 1000) {
@@ -542,6 +555,9 @@ int ceph_print_client_options(struct seq_file *m, struct ceph_client *client)
 	if (opt->osd_keepalive_timeout != CEPH_OSD_KEEPALIVE_DEFAULT)
 		seq_printf(m, "osdkeepalivetimeout=%d,",
 		    jiffies_to_msecs(opt->osd_keepalive_timeout) / 1000);
+	if (opt->mon_keepalive_timeout != CEPH_MON_KEEPALIVE_DEFAULT)
+		seq_printf(m, "monkeepalivetimeout=%d,",
+		    jiffies_to_msecs(opt->mon_keepalive_timeout) / 1000);
 
 	/* drop redundant comma */
 	if (m->count != pos)
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 101ab62..6dfdd87 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -163,6 +163,7 @@ static struct kmem_cache	*ceph_msg_data_cache;
 static char tag_msg = CEPH_MSGR_TAG_MSG;
 static char tag_ack = CEPH_MSGR_TAG_ACK;
 static char tag_keepalive = CEPH_MSGR_TAG_KEEPALIVE;
+static char tag_keepalive2 = CEPH_MSGR_TAG_KEEPALIVE2;
 
 #ifdef CONFIG_LOCKDEP
 static struct lock_class_key socket_class;
@@ -1351,7 +1352,16 @@ static void prepare_write_keepalive(struct ceph_connection *con)
 {
 	dout("prepare_write_keepalive %p\n", con);
 	con_out_kvec_reset(con);
-	con_out_kvec_add(con, sizeof (tag_keepalive), &tag_keepalive);
+
+	if (con->peer_features & CEPH_FEATURE_MSGR_KEEPALIVE2) {
+		struct timespec ts = CURRENT_TIME;
+		struct ceph_timespec ceph_ts;
+		ceph_encode_timespec(&ceph_ts, &ts);
+		con_out_kvec_add(con, sizeof(tag_keepalive2), &tag_keepalive2);
+		con_out_kvec_add(con, sizeof(ceph_ts), &ceph_ts);
+	} else {
+		con_out_kvec_add(con, sizeof(tag_keepalive), &tag_keepalive);
+	}
 	con_flag_set(con, CON_FLAG_WRITE_PENDING);
 }
 
@@ -1625,6 +1635,12 @@ static void prepare_read_tag(struct ceph_connection *con)
 	con->in_tag = CEPH_MSGR_TAG_READY;
 }
 
+static void prepare_read_keepalive_ack(struct ceph_connection *con)
+{
+	dout("prepare_read_keepalive_ack %p\n", con);
+	con->in_base_pos = 0;
+}
+
 /*
  * Prepare to read a message.
  */
@@ -2457,6 +2473,17 @@ static void process_message(struct ceph_connection *con)
 	mutex_lock(&con->mutex);
 }
 
+static int read_keepalive_ack(struct ceph_connection *con)
+{
+	struct ceph_timespec ceph_ts;
+	size_t size = sizeof(ceph_ts);
+	int ret = read_partial(con, size, size, &ceph_ts);
+	if (ret <= 0)
+		return ret;
+	ceph_decode_timespec(&con->last_keepalive_ack, &ceph_ts);
+	prepare_read_tag(con);
+	return 1;
+}
 
 /*
  * Write something to the socket.  Called in a worker thread when the
@@ -2526,6 +2553,10 @@ more_kvec:
 
 do_next:
 	if (con->state == CON_STATE_OPEN) {
+		if (con_flag_test_and_clear(con, CON_FLAG_KEEPALIVE_PENDING)) {
+			prepare_write_keepalive(con);
+			goto more;
+		}
 		/* is anything else pending? */
 		if (!list_empty(&con->out_queue)) {
 			prepare_write_message(con);
@@ -2535,10 +2566,6 @@ do_next:
 			prepare_write_ack(con);
 			goto more;
 		}
-		if (con_flag_test_and_clear(con, CON_FLAG_KEEPALIVE_PENDING)) {
-			prepare_write_keepalive(con);
-			goto more;
-		}
 	}
 
 	/* Nothing to do! */
@@ -2641,6 +2668,9 @@ more:
 		case CEPH_MSGR_TAG_ACK:
 			prepare_read_ack(con);
 			break;
+		case CEPH_MSGR_TAG_KEEPALIVE2_ACK:
+			prepare_read_keepalive_ack(con);
+			break;
 		case CEPH_MSGR_TAG_CLOSE:
 			con_close_socket(con);
 			con->state = CON_STATE_CLOSED;
@@ -2684,6 +2714,12 @@ more:
 		process_ack(con);
 		goto more;
 	}
+	if (con->in_tag == CEPH_MSGR_TAG_KEEPALIVE2_ACK) {
+		ret = read_keepalive_ack(con);
+		if (ret <= 0)
+			goto out;
+		goto more;
+	}
 
 out:
 	dout("try_read done on %p ret %d\n", con, ret);
@@ -3101,6 +3137,20 @@ void ceph_con_keepalive(struct ceph_connection *con)
 }
 EXPORT_SYMBOL(ceph_con_keepalive);
 
+int ceph_con_keepalive_expired(struct ceph_connection *con,
+			       unsigned long interval)
+{
+	if (con->peer_features & CEPH_FEATURE_MSGR_KEEPALIVE2) {
+		struct timespec now = CURRENT_TIME;
+		struct timespec ts;
+		jiffies_to_timespec(interval, &ts);
+		ts = timespec_add(con->last_keepalive_ack, ts);
+		return timespec_compare(&now, &ts) >= 0;
+	}
+	return false;
+}
+EXPORT_SYMBOL(ceph_con_keepalive_expired);
+
 static struct ceph_msg_data *ceph_msg_data_create(enum ceph_msg_data_type type)
 {
 	struct ceph_msg_data *data;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 9d6ff12..3bcd332 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -149,6 +149,10 @@ static int __open_session(struct ceph_mon_client *monc)
 			      CEPH_ENTITY_TYPE_MON, monc->cur_mon,
 			      &monc->monmap->mon_inst[monc->cur_mon].addr);
 
+		/* send an initial keepalive to ensure our timestamp is
+		 * valid by the time we are in an OPENED state */
+		ceph_con_keepalive(&monc->con);
+
 		/* initiatiate authentication handshake */
 		ret = ceph_auth_build_hello(monc->auth,
 					    monc->m_auth->front.iov_base,
@@ -170,14 +174,19 @@ static bool __sub_expired(struct ceph_mon_client *monc)
  */
 static void __schedule_delayed(struct ceph_mon_client *monc)
 {
-	unsigned int delay;
+	struct ceph_options *opt = monc->client->options;
+	unsigned long delay;
 
-	if (monc->cur_mon < 0 || __sub_expired(monc))
+	if (monc->cur_mon < 0 || __sub_expired(monc)) {
 		delay = 10 * HZ;
-	else
+	} else {
 		delay = 20 * HZ;
-	dout("__schedule_delayed after %u\n", delay);
-	schedule_delayed_work(&monc->delayed_work, delay);
+		if (opt->mon_keepalive_timeout > 0)
+			delay = min(delay, opt->mon_keepalive_timeout >> 2);
+	}
+	dout("__schedule_delayed after %lu\n", delay);
+	schedule_delayed_work(&monc->delayed_work,
+			      round_jiffies_relative(delay));
 }
 
 /*
@@ -743,11 +752,24 @@ static void delayed_work(struct work_struct *work)
 		__close_session(monc);
 		__open_session(monc);  /* continue hunting */
 	} else {
-		ceph_con_keepalive(&monc->con);
+		struct ceph_options *opt = monc->client->options;
+		int is_auth = ceph_auth_is_authenticated(monc->auth);
+		if (is_auth && opt->mon_keepalive_timeout > 0 &&
+		    ceph_con_keepalive_expired(&monc->con,
+					opt->mon_keepalive_timeout)) {
+			dout("monc keepalive timeout\n");
+			is_auth = 0;
+			__close_session(monc);
+			monc->hunting = true;
+			__open_session(monc);
+		}
 
-		__validate_auth(monc);
+		if (!monc->hunting) {
+			ceph_con_keepalive(&monc->con);
+			__validate_auth(monc);
+		}
 
-		if (ceph_auth_is_authenticated(monc->auth))
+		if (is_auth)
 			__send_subscribe(monc);
 	}
 	__schedule_delayed(monc);
-- 
1.9.3

