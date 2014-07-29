From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: [PATCH] ceph: use the OSD time as the object mtime instead of the
 client time
Date: Tue, 29 Jul 2014 05:07:15 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C534891D8CB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7330 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbaG2FHe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 01:07:34 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>

This fixes a bug when the time of the OSDs and clients are not synchronized
(especially when client is ahead of OSD), and the cache tier dirty ratio
reaches the threshold, the agent skips the flush work because it thinks
the object is too young.

The skipping flush code is as following:

  if (obc->obs.oi.mtime + utime_t(pool.info.cache_min_flush_age, 0) > now) {
    dout(20) << __func__ << " skip (too young) " << obc->obs.oi << dendl;
    osd->logger->inc(l_osd_agent_skip);
    return false;
  }

Signed-off-by: Zhiqiang Wang <wonzhq@hotmail.com>
---
 src/osd/ReplicatedPG.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index 5d822c1..1c7c527 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -1805,7 +1805,7 @@ void ReplicatedPG::execute_ctx(OpContext *ctx)

     // version
     ctx->at_version = get_next_version();
-    ctx->mtime = m->get_mtime();
+    ctx->mtime = ceph_clock_now(cct);

     dout(10) << "do_op " << soid << " " << ctx->ops
             << " ov " << obc->obs.oi.version << " av " << ctx->at_version
--
1.9.1
