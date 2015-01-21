From: Chaitanya Huilgol <chaitanya.huilgol@gmail.com>
Subject: [PATCH] ceph: rbd option listing and tcp_nodelay support
Date: Thu, 22 Jan 2015 00:30:54 +0530 (IST)
Message-ID: <alpine.DEB.2.10.1501220029310.28090@Ubuntu-VirtualBox>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:57934 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbbAUTA7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jan 2015 14:00:59 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so11855475pdj.9
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2015 11:00:58 -0800 (PST)
Received: from [10.0.2.15] ([115.118.77.96])
        by mx.google.com with ESMTPSA id qp4sm6641913pbc.63.2015.01.21.11.00.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jan 2015 11:00:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Chaitanya Huilgol <chaitanya.huilgol@sandisk.com>

Option keys supported by libceph and rbd modules is readable
as a comma separated string via /sys/bus/rbd/options read-only
interface. This will allow user app (rbd cli) to check for
supported option keys before passing options to the kernel and
remain compatible with older kernels which do not support a
particular feature.
Messenger specific options moved to messenger layer.
tcp_nodelay(default)/no_tcp_nodelay option added for setting
TCP_NODELAY on messenger socket connections. Covers both rbd
and cephfs

Signed-off-by: Chaitanya Huilgol <chaitanya.huilgol@sandisk.com>
---
 drivers/block/rbd.c            | 21 +++++++++++++++++
 fs/ceph/super.c                |  5 +++-
 include/linux/ceph/libceph.h   |  5 ++--
 include/linux/ceph/messenger.h | 26 +++++++++++++++++++--
 net/ceph/ceph_common.c         | 52 ++++++++++++++++++++++++++++++++++++++----
 net/ceph/messenger.c           | 33 ++++++++++++++++++++++-----
 6 files changed, 126 insertions(+), 16 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e818c2a..507fd16 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -423,6 +423,7 @@ static ssize_t rbd_add_single_major(struct bus_type *bus, const char *buf,
 				    size_t count);
 static ssize_t rbd_remove_single_major(struct bus_type *bus, const char *buf,
 				       size_t count);
+static ssize_t rbd_enumerate_options(struct bus_type *bus, char *buf);
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping);
 static void rbd_spec_put(struct rbd_spec *spec);
 
@@ -440,12 +441,14 @@ static BUS_ATTR(add, S_IWUSR, NULL, rbd_add);
 static BUS_ATTR(remove, S_IWUSR, NULL, rbd_remove);
 static BUS_ATTR(add_single_major, S_IWUSR, NULL, rbd_add_single_major);
 static BUS_ATTR(remove_single_major, S_IWUSR, NULL, rbd_remove_single_major);
+static BUS_ATTR(options, S_IRUSR, rbd_enumerate_options, NULL);
 
 static struct attribute *rbd_bus_attrs[] = {
 	&bus_attr_add.attr,
 	&bus_attr_remove.attr,
 	&bus_attr_add_single_major.attr,
 	&bus_attr_remove_single_major.attr,
+	&bus_attr_options.attr,
 	NULL,
 };
 
@@ -746,6 +749,12 @@ static match_table_t rbd_opts_tokens = {
 	{-1, NULL}
 };
 
+/*
+ * Supported options comma separated string. Readable by the rbd cli, so that
+ * an informed decision can be made on passing options to the kernel modules.
+ */
+static const char *rbd_supported_option_keys = "rw";
+
 struct rbd_options {
 	bool	read_only;
 };
@@ -5569,6 +5578,18 @@ static ssize_t rbd_remove_single_major(struct bus_type *bus,
 	return do_rbd_remove(bus, buf, count);
 }
 
+static ssize_t rbd_enumerate_options(struct bus_type *bus,
+		char *buf)
+{
+	ssize_t sz;
+	sz = snprintf(buf, PAGE_SIZE, "%s", rbd_supported_option_keys);
+	if ((sz + 1) < PAGE_SIZE) {
+		sz += snprintf (buf + sz, PAGE_SIZE - sz, ",%s",
+			ceph_get_supported_options());
+	}
+	sz += 1; /* '0' String Termination */
+	return sz;
+}
 /*
  * create control files in sysfs
  * /sys/bus/rbd/...
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 50f06cd..4632ae4 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -423,7 +423,10 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",fsid=%pU", &opt->fsid);
 	if (opt->flags & CEPH_OPT_NOSHARE)
 		seq_puts(m, ",noshare");
-	if (opt->flags & CEPH_OPT_NOCRC)
+	if (ceph_test_msgr_opt(&opt->msgr_options,
+			CEPH_MSGR_OPT_NO_TCP_NODELAY))
+		seq_puts(m, ",no_tcp_nodelay");
+	if (ceph_test_msgr_opt(&opt->msgr_options, CEPH_MSGR_OPT_NOCRC))
 		seq_puts(m, ",nocrc");
 
 	if (opt->name)
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 8b11a79..9306a47 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -28,8 +28,7 @@
 #define CEPH_OPT_FSID             (1<<0)
 #define CEPH_OPT_NOSHARE          (1<<1) /* don't share client with other sbs */
 #define CEPH_OPT_MYIP             (1<<2) /* specified my ip */
-#define CEPH_OPT_NOCRC            (1<<3) /* no data crc on writes */
-#define CEPH_OPT_NOMSGAUTH	  (1<<4) /* not require cephx message signature */
+#define CEPH_OPT_NOMSGAUTH	  (1<<3) /* not require cephx message signature */
 
 #define CEPH_OPT_DEFAULT   (0)
 
@@ -42,6 +41,7 @@ struct ceph_options {
 	int flags;
 	struct ceph_fsid fsid;
 	struct ceph_entity_addr my_addr;
+	struct ceph_messenger_options msgr_options;
 	int mount_timeout;
 	int osd_idle_ttl;
 	int osd_keepalive_timeout;
@@ -190,6 +190,7 @@ extern struct ceph_options *ceph_parse_options(char *options,
 			      const char *dev_name, const char *dev_name_end,
 			      int (*parse_extra_token)(char *c, void *private),
 			      void *private);
+extern const char* ceph_get_supported_options(void);
 extern void ceph_destroy_options(struct ceph_options *opt);
 extern int ceph_compare_options(struct ceph_options *new_opt,
 				struct ceph_client *client);
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index d9d396c..471f622 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -51,12 +51,34 @@ struct ceph_connection_operations {
 /* use format string %s%d */
 #define ENTITY_NAME(n) ceph_entity_type_name((n).type), le64_to_cpu((n).num)
 
+/*
+ * Messenger specific ceph options
+ */
+struct ceph_messenger_options {
+	u32 flags;
+};
+
+#define CEPH_MSGR_OPT_NOCRC          (1<<0) /* no data crc on writes */
+#define CEPH_MSGR_OPT_NO_TCP_NODELAY (1<<1) /* No TCP_NODELAY on con sock */
+#define CEPH_MSGR_OPT_DEFAULT        (0)
+
+#define ceph_messenger_options_init(_msgr_opts)  \
+	((_msgr_opts)->flags = CEPH_MSGR_OPT_DEFAULT)
+
+#define ceph_set_msgr_opt(_msgr_opts, _opt) \
+	((_msgr_opts)->flags |= _opt)
+#define ceph_clr_msgr_opt(_msgr_opts, _opt) \
+	((_msgr_opts)->flags &= ~(_opt))
+#define ceph_test_msgr_opt(_msgr_opts, _opt) \
+	(!!((_msgr_opts)->flags & (_opt)))
+
+
 struct ceph_messenger {
 	struct ceph_entity_inst inst;    /* my name+address */
 	struct ceph_entity_addr my_enc_addr;
 
 	atomic_t stopping;
-	bool nocrc;
+	struct ceph_messenger_options *options;
 
 	/*
 	 * the global_seq counts connections i (attempt to) initiate
@@ -264,7 +286,7 @@ extern void ceph_messenger_init(struct ceph_messenger *msgr,
 			struct ceph_entity_addr *myaddr,
 			u64 supported_features,
 			u64 required_features,
-			bool nocrc);
+			struct ceph_messenger_options *msgr_options);
 
 extern void ceph_con_init(struct ceph_connection *con, void *private,
 			const struct ceph_connection_operations *ops,
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 5d5ab67..25f1515 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -239,6 +239,8 @@ enum {
 	Opt_nocrc,
 	Opt_cephx_require_signatures,
 	Opt_nocephx_require_signatures,
+	Opt_tcp_nodelay,
+	Opt_no_tcp_nodelay,
 };
 
 static match_table_t opt_tokens = {
@@ -259,8 +261,28 @@ static match_table_t opt_tokens = {
 	{Opt_nocrc, "nocrc"},
 	{Opt_cephx_require_signatures, "cephx_require_signatures"},
 	{Opt_nocephx_require_signatures, "nocephx_require_signatures"},
+	{Opt_tcp_nodelay, "tcp_nodelay"},
+	{Opt_no_tcp_nodelay, "no_tcp_nodelay"},
 	{-1, NULL}
 };
+/*
+ * Supported option keys. Readable by the rbd cli, so that an informed
+ * decision can be made on passing options to the kernel modules.
+ */
+static const char *libceph_supported_options_keys =
+	"osdtimeout,"
+	"osdkeepalive,"
+	"mount_timeout,"
+	"osd_idle_ttl,"
+	"fsid,"
+	"name,"
+	"secret,"
+	"key,"
+	"ip,"
+	"share,"
+	"crc,"
+	"cephx_require_signatures,"
+	"tcp_nodelay";
 
 void ceph_destroy_options(struct ceph_options *opt)
 {
@@ -320,8 +342,7 @@ out:
 	return err;
 }
 
-struct ceph_options *
-ceph_parse_options(char *options, const char *dev_name,
+struct ceph_options * ceph_parse_options(char *options, const char *dev_name,
 			const char *dev_name_end,
 			int (*parse_extra_token)(char *c, void *private),
 			void *private)
@@ -350,6 +371,7 @@ ceph_parse_options(char *options, const char *dev_name,
 	opt->osd_keepalive_timeout = CEPH_OSD_KEEPALIVE_DEFAULT;
 	opt->mount_timeout = CEPH_MOUNT_TIMEOUT_DEFAULT; /* seconds */
 	opt->osd_idle_ttl = CEPH_OSD_IDLE_TTL_DEFAULT;   /* seconds */
+	ceph_messenger_options_init(&opt->msgr_options);
 
 	/* get mon ip(s) */
 	/* ip1[:port1][,ip2[:port2]...] */
@@ -452,11 +474,14 @@ ceph_parse_options(char *options, const char *dev_name,
 			break;
 
 		case Opt_crc:
-			opt->flags &= ~CEPH_OPT_NOCRC;
+			ceph_clr_msgr_opt(&opt->msgr_options,
+				CEPH_MSGR_OPT_NOCRC);
 			break;
 		case Opt_nocrc:
-			opt->flags |= CEPH_OPT_NOCRC;
+			ceph_set_msgr_opt(&opt->msgr_options,
+				CEPH_MSGR_OPT_NOCRC);
 			break;
+
 		case Opt_cephx_require_signatures:
 			opt->flags &= ~CEPH_OPT_NOMSGAUTH;
 			break;
@@ -464,6 +489,15 @@ ceph_parse_options(char *options, const char *dev_name,
 			opt->flags |= CEPH_OPT_NOMSGAUTH;
 			break;
 
+		case Opt_tcp_nodelay:
+			ceph_clr_msgr_opt(&opt->msgr_options,
+				CEPH_MSGR_OPT_NO_TCP_NODELAY);
+			break;
+		case Opt_no_tcp_nodelay:
+			ceph_set_msgr_opt(&opt->msgr_options,
+				CEPH_MSGR_OPT_NO_TCP_NODELAY);
+			break;
+
 		default:
 			BUG_ON(token);
 		}
@@ -478,6 +512,14 @@ out:
 }
 EXPORT_SYMBOL(ceph_parse_options);
 
+
+const char* ceph_get_supported_options(void)
+{
+    return  libceph_supported_options_keys;
+}
+EXPORT_SYMBOL(ceph_get_supported_options);
+
+
 u64 ceph_client_id(struct ceph_client *client)
 {
 	return client->monc.auth->global_id;
@@ -521,7 +563,7 @@ struct ceph_client *ceph_create_client(struct ceph_options *opt, void *private,
 	ceph_messenger_init(&client->msgr, myaddr,
 		client->supported_features,
 		client->required_features,
-		ceph_test_opt(client, NOCRC));
+		&opt->msgr_options);
 
 	/* subsystems */
 	err = ceph_monc_init(&client->monc, client);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 33a2f20..9a056fe 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -469,6 +469,21 @@ static void set_sock_callbacks(struct socket *sock,
 /*
  * socket helpers
  */
+static void ceph_tcp_set_sock_options(struct ceph_connection *con)
+{
+	int rc;
+
+	if (!ceph_test_msgr_opt(con->msgr->options,
+		CEPH_MSGR_OPT_NO_TCP_NODELAY)) {
+		/* Not requested to disable TCP_NODELAY, set it by default */
+		int optval = 1;
+		rc = kernel_setsockopt(con->sock, IPPROTO_TCP, TCP_NODELAY,
+		    (char *)&optval, sizeof(optval));
+		if (rc != 0) {
+			pr_warn("Warn: CEPH_CON_OPT: TCP_NODELAY: Fails=%d\n", rc);
+		}
+	}
+}
 
 /*
  * initiate connection to a remote socket.
@@ -513,6 +528,9 @@ static int ceph_tcp_connect(struct ceph_connection *con)
 	sk_set_memalloc(sock->sk);
 
 	con->sock = sock;
+	/* process socket options if any */
+	ceph_tcp_set_sock_options(con);
+
 	return 0;
 }
 
@@ -749,7 +767,6 @@ void ceph_con_init(struct ceph_connection *con, void *private,
 }
 EXPORT_SYMBOL(ceph_con_init);
 
-
 /*
  * We maintain a global counter to order connection attempts.  Get
  * a unique seq greater than @gt.
@@ -1511,7 +1528,8 @@ static int write_partial_message_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->out_msg;
 	struct ceph_msg_data_cursor *cursor = &msg->cursor;
-	bool do_datacrc = !con->msgr->nocrc;
+	bool do_datacrc = !ceph_test_msgr_opt(con->msgr->options,
+				CEPH_MSGR_OPT_NOCRC);
 	u32 crc;
 
 	dout("%s %p msg %p\n", __func__, con, msg);
@@ -2212,7 +2230,8 @@ static int read_partial_msg_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->in_msg;
 	struct ceph_msg_data_cursor *cursor = &msg->cursor;
-	const bool do_datacrc = !con->msgr->nocrc;
+	const bool do_datacrc = !ceph_test_msgr_opt(con->msgr->options,
+				CEPH_MSGR_OPT_NOCRC);
 	struct page *page;
 	size_t page_offset;
 	size_t length;
@@ -2258,7 +2277,8 @@ static int read_partial_message(struct ceph_connection *con)
 	int end;
 	int ret;
 	unsigned int front_len, middle_len, data_len;
-	bool do_datacrc = !con->msgr->nocrc;
+	bool do_datacrc = !ceph_test_msgr_opt(con->msgr->options,
+				CEPH_MSGR_OPT_NOCRC);
 	bool need_sign = (con->peer_features & CEPH_FEATURE_MSG_AUTH);
 	u64 seq;
 	u32 crc;
@@ -2922,7 +2942,7 @@ void ceph_messenger_init(struct ceph_messenger *msgr,
 			struct ceph_entity_addr *myaddr,
 			u64 supported_features,
 			u64 required_features,
-			bool nocrc)
+			struct ceph_messenger_options *msgr_options)
 {
 	msgr->supported_features = supported_features;
 	msgr->required_features = required_features;
@@ -2936,7 +2956,8 @@ void ceph_messenger_init(struct ceph_messenger *msgr,
 	msgr->inst.addr.type = 0;
 	get_random_bytes(&msgr->inst.addr.nonce, sizeof(msgr->inst.addr.nonce));
 	encode_my_addr(msgr);
-	msgr->nocrc = nocrc;
+	BUG_ON(msgr_options == NULL);
+	msgr->options = msgr_options;
 
 	atomic_set(&msgr->stopping, 0);
 
-- 
1.9.1

