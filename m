From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 2/3] libceph: add an option to configure client behavior when osds are full
Date: Tue,  3 Dec 2013 15:12:52 -0800
Message-ID: <1386112373-25610-3-git-send-email-josh.durgin@inktank.com>
References: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53155 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316Ab3LDAFa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Dec 2013 19:05:30 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 59F9B26679
	for <ceph-devel@vger.kernel.org>; Tue,  3 Dec 2013 15:59:38 -0800 (PST)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 46A012667E
	for <ceph-devel@vger.kernel.org>; Tue,  3 Dec 2013 15:59:38 -0800 (PST)
In-Reply-To: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Default to blocking requests to be consistent with userspace. Some
applications may prefer the previous behavior of returning an error
instead, so make that an option. CephFS implements returning -ENOSPC
at a higher level, so only rbd is really affected by this.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 include/linux/ceph/libceph.h |    7 +++++++
 net/ceph/ceph_common.c       |   13 +++++++++++++
 net/ceph/osd_client.c        |    5 ++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 2e30248..77b28ac 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -32,6 +32,12 @@
 
 #define CEPH_OPT_DEFAULT   (0)
 
+/* osd full behavior */
+enum {
+	CEPH_OSD_FULL_ERROR,
+	CEPH_OSD_FULL_BLOCK,
+};
+
 #define ceph_set_opt(client, opt) \
 	(client)->options->flags |= CEPH_OPT_##opt;
 #define ceph_test_opt(client, opt) \
@@ -44,6 +50,7 @@ struct ceph_options {
 	int mount_timeout;
 	int osd_idle_ttl;
 	int osd_keepalive_timeout;
+	int osd_full_behavior;
 
 	/*
 	 * any type that can't be simply compared or doesn't need need
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 34b11ee..d029fc5 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -217,6 +217,7 @@ enum {
 	Opt_secret,
 	Opt_key,
 	Opt_ip,
+	Opt_osd_full_behavior,
 	Opt_last_string,
 	/* string args above */
 	Opt_share,
@@ -236,6 +237,7 @@ static match_table_t opt_tokens = {
 	{Opt_secret, "secret=%s"},
 	{Opt_key, "key=%s"},
 	{Opt_ip, "ip=%s"},
+	{Opt_osd_full_behavior, "osd_full_behavior=%s"},
 	/* string args above */
 	{Opt_share, "share"},
 	{Opt_noshare, "noshare"},
@@ -329,6 +331,7 @@ ceph_parse_options(char *options, const char *dev_name,
 	opt->osd_keepalive_timeout = CEPH_OSD_KEEPALIVE_DEFAULT;
 	opt->mount_timeout = CEPH_MOUNT_TIMEOUT_DEFAULT; /* seconds */
 	opt->osd_idle_ttl = CEPH_OSD_IDLE_TTL_DEFAULT;   /* seconds */
+	opt->osd_full_behavior = CEPH_OSD_FULL_BLOCK;
 
 	/* get mon ip(s) */
 	/* ip1[:port1][,ip2[:port2]...] */
@@ -408,6 +411,16 @@ ceph_parse_options(char *options, const char *dev_name,
 			if (err < 0)
 				goto out;
 			break;
+		case Opt_osd_full_behavior:
+			if (!strcmp(argstr[0].from, "error")) {
+				opt->osd_full_behavior = CEPH_OSD_FULL_ERROR;
+			} else if (!strcmp(argstr[0].from, "block")) {
+				opt->osd_full_behavior = CEPH_OSD_FULL_BLOCK;
+			} else {
+				err = -EINVAL;
+				goto out;
+			}
+			break;
 
 			/* misc */
 		case Opt_osdtimeout:
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 21476be..664432e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1240,9 +1240,12 @@ EXPORT_SYMBOL(ceph_osdc_set_request_linger);
 static bool __req_should_be_paused(struct ceph_osd_client *osdc,
 				   struct ceph_osd_request *req)
 {
+	bool block_on_full =
+		osdc->client->options->osd_full_behavior & CEPH_OSD_FULL_BLOCK;
 	bool pauserd = ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_PAUSERD);
 	bool pausewr = ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_PAUSEWR) ||
-		ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL);
+		(ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL) &&
+			block_on_full);
 	return (req->r_flags & CEPH_OSD_FLAG_READ && pauserd) ||
 		(req->r_flags & CEPH_OSD_FLAG_WRITE && pausewr);
 }
-- 
1.7.10.4

