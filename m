From: Iulius Curt <iulius.curt@gmail.com>
Subject: [PATCH v2] libceph: Fix sparse warning
Date: Thu, 23 Aug 2012 15:14:29 +0300
Message-ID: <1345724069-12405-1-git-send-email-icurt@ixiacom.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:59090 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930Ab2HWMOF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Aug 2012 08:14:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com
Cc: davem@davemloft.net, ceph-devel@vger.kernel.org, netdev@vger.kernel.org, dbaluta@ixiacom.com, Iulius Curt <iulius.curt@gmail.com>, Iulius Curt <icurt@ixiacom.com>

From: Iulius Curt <iulius.curt@gmail.com>

Make ceph_monc_do_poolop() static to remove the following sparse warning:
 * net/ceph/mon_client.c:616:5: warning: symbol 'ceph_monc_do_poolop' was not
   declared. Should it be static?
Also drops the 'ceph_monc_' prefix, now being a private function.

Signed-off-by: Iulius Curt <icurt@ixiacom.com>
---
v1 ---> v2
 * drop the 'ceph_monc_' prefix
---
 net/ceph/mon_client.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 105d533..84ce495 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -613,7 +613,7 @@ bad:
 /*
  * Do a synchronous pool op.
  */
-int ceph_monc_do_poolop(struct ceph_mon_client *monc, u32 op,
+static int do_poolop(struct ceph_mon_client *monc, u32 op,
 			u32 pool, u64 snapid,
 			char *buf, int len)
 {
@@ -663,7 +663,7 @@ out:
 int ceph_monc_create_snapid(struct ceph_mon_client *monc,
 			    u32 pool, u64 *snapid)
 {
-	return ceph_monc_do_poolop(monc,  POOL_OP_CREATE_UNMANAGED_SNAP,
+	return do_poolop(monc,  POOL_OP_CREATE_UNMANAGED_SNAP,
 				   pool, 0, (char *)snapid, sizeof(*snapid));

 }
@@ -672,7 +672,7 @@ EXPORT_SYMBOL(ceph_monc_create_snapid);
 int ceph_monc_delete_snapid(struct ceph_mon_client *monc,
 			    u32 pool, u64 snapid)
 {
-	return ceph_monc_do_poolop(monc,  POOL_OP_CREATE_UNMANAGED_SNAP,
+	return do_poolop(monc,  POOL_OP_CREATE_UNMANAGED_SNAP,
 				   pool, snapid, 0, 0);

 }
--
1.7.9.5

