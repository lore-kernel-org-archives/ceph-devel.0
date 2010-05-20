From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 10/11] ceph: Storage class should be before const qualifier
Date: Thu, 20 May 2010 10:40:19 +0200
Message-ID: <1274344819-9278-1-git-send-email-tklauser@distanz.ch>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:41979 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947Ab0ETIkW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 20 May 2010 04:40:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net, ceph-devel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the beginning
of the declaration specifiers in a declaration is an obsolescent
feature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 fs/ceph/mds_client.c |    4 ++--
 fs/ceph/mon_client.c |    4 ++--
 fs/ceph/osd_client.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 1b786cf..885aa57 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -40,7 +40,7 @@
 static void __wake_requests(struct ceph_mds_client *mdsc,
 			    struct list_head *head);
 
-const static struct ceph_connection_operations mds_con_ops;
+static const struct ceph_connection_operations mds_con_ops;
 
 
 /*
@@ -3120,7 +3120,7 @@ static int invalidate_authorizer(struct ceph_connection *con)
 	return ceph_monc_validate_auth(&mdsc->client->monc);
 }
 
-const static struct ceph_connection_operations mds_con_ops = {
+static const struct ceph_connection_operations mds_con_ops = {
 	.get = con_get,
 	.put = con_put,
 	.dispatch = dispatch,
diff --git a/fs/ceph/mon_client.c b/fs/ceph/mon_client.c
index 79417fb..c03d84d 100644
--- a/fs/ceph/mon_client.c
+++ b/fs/ceph/mon_client.c
@@ -28,7 +28,7 @@
  * resend any outstanding requests.
  */
 
-const static struct ceph_connection_operations mon_con_ops;
+static const struct ceph_connection_operations mon_con_ops;
 
 static int __validate_auth(struct ceph_mon_client *monc);
 
@@ -1009,7 +1009,7 @@ out:
 	mutex_unlock(&monc->mutex);
 }
 
-const static struct ceph_connection_operations mon_con_ops = {
+static const struct ceph_connection_operations mon_con_ops = {
 	.get = ceph_con_get,
 	.put = ceph_con_put,
 	.dispatch = dispatch,
diff --git a/fs/ceph/osd_client.c b/fs/ceph/osd_client.c
index ab6989b..57ddeae 100644
--- a/fs/ceph/osd_client.c
+++ b/fs/ceph/osd_client.c
@@ -17,7 +17,7 @@
 #define OSD_OP_FRONT_LEN	4096
 #define OSD_OPREPLY_FRONT_LEN	512
 
-const static struct ceph_connection_operations osd_con_ops;
+static const struct ceph_connection_operations osd_con_ops;
 static int __kick_requests(struct ceph_osd_client *osdc,
 			  struct ceph_osd *kickosd);
 
@@ -1607,7 +1607,7 @@ static int invalidate_authorizer(struct ceph_connection *con)
 	return ceph_monc_validate_auth(&osdc->client->monc);
 }
 
-const static struct ceph_connection_operations osd_con_ops = {
+static const struct ceph_connection_operations osd_con_ops = {
 	.get = get_osd_con,
 	.put = put_osd_con,
 	.dispatch = dispatch,
-- 
1.6.3.3

