From: Iulius Curt <iulius.curt@gmail.com>
Subject: [PATCH] libceph: Fix sparse warning
Date: Tue, 14 Aug 2012 16:27:37 +0300
Message-ID: <1344950857-32139-1-git-send-email-icurt@ixiacom.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: davem@davemloft.net
Cc: sage@inktank.com, ceph-devel@vger.kernel.org, netdev@vger.kernel.org, dbaluta@ixiacom.com, Iulius Curt <iulius.curt@gmail.com>, Iulius Curt <icurt@ixiacom.com>
List-Id: ceph-devel.vger.kernel.org

From: Iulius Curt <iulius.curt@gmail.com>

Make ceph_monc_do_poolop() static to remove the following sparse warning:
 * net/ceph/mon_client.c:616:5: warning: symbol 'ceph_monc_do_poolop' was not
   declared. Should it be static?

Signed-off-by: Iulius Curt <icurt@ixiacom.com>
---
 net/ceph/mon_client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 105d533..3875c60 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -613,7 +613,7 @@ bad:
 /*
  * Do a synchronous pool op.
  */
-int ceph_monc_do_poolop(struct ceph_mon_client *monc, u32 op,
+static int ceph_monc_do_poolop(struct ceph_mon_client *monc, u32 op,
 			u32 pool, u64 snapid,
 			char *buf, int len)
 {
-- 
1.7.9.5
