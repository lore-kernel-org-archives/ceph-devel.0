From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH v2 5/5] libceph: read_from_replica option
Date: Sat, 30 May 2020 17:34:39 +0200
Message-ID: <20200530153439.31312-6-idryomov@gmail.com>
References: <20200530153439.31312-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgE3Peq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 30 May 2020 11:34:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494D8C08C5C9
        for <ceph-devel@vger.kernel.org>; Sat, 30 May 2020 08:34:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so7101574wrr.10
        for <ceph-devel@vger.kernel.org>; Sat, 30 May 2020 08:34:45 -0700 (PDT)
In-Reply-To: <20200530153439.31312-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>

Expose replica reads through read_from_replica=balance and
read_from_replica=localize.  The default is to read from primary
(read_from_replica=no).

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/libceph.h |  2 ++
 net/ceph/ceph_common.c       | 39 ++++++++++++++++++++++++++++++++++++
 net/ceph/osd_client.c        |  5 ++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 4733959f1ec7..0a9f807ceda6 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -52,6 +52,8 @@ struct ceph_options {
 	unsigned long osd_idle_ttl;		/* jiffies */
 	unsigned long osd_keepalive_timeout;	/* jiffies */
 	unsigned long osd_request_timeout;	/* jiffies */
+	unsigned int osd_req_flags;  /* CEPH_OSD_FLAG_*, applied to
+					each OSD request */
 
 	/*
 	 * any type that can't be simply compared or doesn't need
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 44770b60bc38..9bab3e9a039b 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -265,6 +265,7 @@ enum {
 	Opt_key,
 	Opt_ip,
 	Opt_crush_location,
+	Opt_read_from_replica,
 	/* string args above */
 	Opt_share,
 	Opt_crc,
@@ -274,6 +275,19 @@ enum {
 	Opt_abort_on_full,
 };
 
+enum {
+	Opt_read_from_replica_no,
+	Opt_read_from_replica_balance,
+	Opt_read_from_replica_localize,
+};
+
+static const struct constant_table ceph_param_read_from_replica[] = {
+	{"no",		Opt_read_from_replica_no},
+	{"balance",	Opt_read_from_replica_balance},
+	{"localize",	Opt_read_from_replica_localize},
+	{}
+};
+
 static const struct fs_parameter_spec ceph_parameters[] = {
 	fsparam_flag	("abort_on_full",		Opt_abort_on_full),
 	fsparam_flag_no ("cephx_require_signatures",	Opt_cephx_require_signatures),
@@ -290,6 +304,8 @@ static const struct fs_parameter_spec ceph_parameters[] = {
 	fsparam_u32	("osdkeepalive",		Opt_osdkeepalivetimeout),
 	__fsparam	(fs_param_is_s32, "osdtimeout", Opt_osdtimeout,
 			 fs_param_deprecated, NULL),
+	fsparam_enum	("read_from_replica",		Opt_read_from_replica,
+			 ceph_param_read_from_replica),
 	fsparam_string	("secret",			Opt_secret),
 	fsparam_flag_no ("share",			Opt_share),
 	fsparam_flag_no ("tcp_nodelay",			Opt_tcp_nodelay),
@@ -472,6 +488,24 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
 			return err;
 		}
 		break;
+	case Opt_read_from_replica:
+		switch (result.uint_32) {
+		case Opt_read_from_replica_no:
+			opt->osd_req_flags &= ~(CEPH_OSD_FLAG_BALANCE_READS |
+						CEPH_OSD_FLAG_LOCALIZE_READS);
+			break;
+		case Opt_read_from_replica_balance:
+			opt->osd_req_flags |= CEPH_OSD_FLAG_BALANCE_READS;
+			opt->osd_req_flags &= ~CEPH_OSD_FLAG_LOCALIZE_READS;
+			break;
+		case Opt_read_from_replica_localize:
+			opt->osd_req_flags |= CEPH_OSD_FLAG_LOCALIZE_READS;
+			opt->osd_req_flags &= ~CEPH_OSD_FLAG_BALANCE_READS;
+			break;
+		default:
+			BUG();
+		}
+		break;
 
 	case Opt_osdtimeout:
 		warn_plog(&log, "Ignoring osdtimeout");
@@ -580,6 +614,11 @@ int ceph_print_client_options(struct seq_file *m, struct ceph_client *client,
 		}
 		seq_putc(m, ',');
 	}
+	if (opt->osd_req_flags & CEPH_OSD_FLAG_BALANCE_READS) {
+		seq_puts(m, "read_from_replica=balance,");
+	} else if (opt->osd_req_flags & CEPH_OSD_FLAG_LOCALIZE_READS) {
+		seq_puts(m, "read_from_replica=localize,");
+	}
 
 	if (opt->flags & CEPH_OPT_FSID)
 		seq_printf(m, "fsid=%pU,", &opt->fsid);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 4ce6cdc744e4..22733e844be1 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2425,11 +2425,14 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 
 static void account_request(struct ceph_osd_request *req)
 {
+	struct ceph_osd_client *osdc = req->r_osdc;
+
 	WARN_ON(req->r_flags & (CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK));
 	WARN_ON(!(req->r_flags & (CEPH_OSD_FLAG_READ | CEPH_OSD_FLAG_WRITE)));
 
 	req->r_flags |= CEPH_OSD_FLAG_ONDISK;
-	atomic_inc(&req->r_osdc->num_requests);
+	req->r_flags |= osdc->client->options->osd_req_flags;
+	atomic_inc(&osdc->num_requests);
 
 	req->r_start_stamp = jiffies;
 	req->r_start_latency = ktime_get();
-- 
2.19.2
