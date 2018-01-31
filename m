From: jlayton@poochiereds.net
Subject: [nfs-ganesha RFC PATCH 3/6] SAL: add nodeid config value to RADOS_KV section
Date: Wed, 31 Jan 2018 09:12:16 -0500
Message-ID: <20180131141219.16929-4-jlayton@poochiereds.net>
References: <20180131141219.16929-1-jlayton@poochiereds.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753256AbeAaOMZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:12:25 -0500
In-Reply-To: <20180131141219.16929-1-jlayton@poochiereds.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: nfs-ganesha-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

The global "clustered" configuration value is true by default. Its only
meaning is as an indicator of whether the g_nodeid value is valid, and
that value is only used in the recovery backends.

The g_nodeid however, is almost always zero. The only exception is when
GPFS creates an export, at which point it'll ask the cluster about its
nodeid and set the value. That value is apparently never zero.

My suspicion is that the intersection of people using the RADOS recovery
backends with GPFS is probably quite small.

Allow the admin to set a nodeid value in the RADOS_KV configuration
block.  This value defaults to UINT32_MAX which will make the RADOS_KV
store act as non-clustered by default (using the hostname as the basis
of the OID name).

With this, the RADOS recovery backends will just ignore the "clustered"
config option.

Change-Id: I03fedc53f35aa54475a4045375d6b38964a72545
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 src/SAL/recovery/recovery_rados.h    | 2 ++
 src/SAL/recovery/recovery_rados_kv.c | 6 ++++--
 src/SAL/recovery/recovery_rados_ng.c | 4 ++--
 src/config_samples/config.txt        | 2 ++
 src/doc/man/ganesha-core-config.rst  | 4 ++++
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/src/SAL/recovery/recovery_rados.h b/src/SAL/recovery/recovery_rados.h
index 16aae1315220..b2eda0019938 100644
--- a/src/SAL/recovery/recovery_rados.h
+++ b/src/SAL/recovery/recovery_rados.h
@@ -37,6 +37,8 @@ struct rados_kv_parameter {
 	char *userid;
 	/** Pool for client info */
 	char *pool;
+	/** Node ID for this cluster node */
+	uint32_t nodeid;
 };
 extern struct rados_kv_parameter rados_kv_param;
 
diff --git a/src/SAL/recovery/recovery_rados_kv.c b/src/SAL/recovery/recovery_rados_kv.c
index bb6f70c76b41..bd0ecbf0e5ee 100644
--- a/src/SAL/recovery/recovery_rados_kv.c
+++ b/src/SAL/recovery/recovery_rados_kv.c
@@ -32,6 +32,8 @@ static struct config_item rados_kv_params[] = {
 		       rados_kv_parameter, userid),
 	CONF_ITEM_STR("pool", 1, MAXPATHLEN, DEFAULT_POOL,
 		       rados_kv_parameter, pool),
+	CONF_ITEM_UI32("nodeid", 0, UINT32_MAX, UINT32_MAX,
+			rados_kv_parameter, nodeid),
 	CONFIG_EOL
 };
 
@@ -350,8 +352,8 @@ void rados_kv_init(void)
 	int ret;
 	char host[NI_MAXHOST];
 
-	if (nfs_param.core_param.clustered) {
-		snprintf(host, sizeof(host), "node%d", g_nodeid);
+	if (rados_kv_param.nodeid != UINT32_MAX) {
+		snprintf(host, sizeof(host), "node%d", rados_kv_param.nodeid);
 	} else {
 		ret = gethostname(host, sizeof(host));
 		if (ret) {
diff --git a/src/SAL/recovery/recovery_rados_ng.c b/src/SAL/recovery/recovery_rados_ng.c
index 91b2b5ff0837..5c26542ba0c8 100644
--- a/src/SAL/recovery/recovery_rados_ng.c
+++ b/src/SAL/recovery/recovery_rados_ng.c
@@ -117,8 +117,8 @@ static void rados_ng_init(void)
 	char host[NI_MAXHOST];
 	rados_write_op_t op;
 
-	if (nfs_param.core_param.clustered) {
-		snprintf(host, sizeof(host), "node%d", g_nodeid);
+	if (rados_kv_param.nodeid != UINT32_MAX) {
+		snprintf(host, sizeof(host), "node%d", rados_kv_param.nodeid);
 	} else {
 		ret = gethostname(host, sizeof(host));
 		if (ret) {
diff --git a/src/config_samples/config.txt b/src/config_samples/config.txt
index d30c65fbc926..26459d4afca3 100644
--- a/src/config_samples/config.txt
+++ b/src/config_samples/config.txt
@@ -730,6 +730,8 @@ RADOS_KV {}
 
 	pool(string, no default)
 
+	nodeid(uint32, default UINT32_MAX)
+
 RADOS_URLS {}
 --------
 
diff --git a/src/doc/man/ganesha-core-config.rst b/src/doc/man/ganesha-core-config.rst
index 75b84cbc8c9b..8c76106568da 100644
--- a/src/doc/man/ganesha-core-config.rst
+++ b/src/doc/man/ganesha-core-config.rst
@@ -305,3 +305,7 @@ userid(path, no default)
 
 pool(string, no default)
     Pool for client info.
+
+nodeid(uint32, range 0 to UINT32_MAX, default UINT32_MAX)
+    The nodeid value for this cluster node. Defaults to UINT32_MAX which is a
+    special value meaning "non-clustered".
-- 
2.14.3

