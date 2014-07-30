From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: [PATCH]ECBackend: Using ROUND_UP_TO to refactor
  get_recovery_chunk_size()
Date: Wed, 30 Jul 2014 06:12:27 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C897ED0@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57202 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbaG3GMh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 02:12:37 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sage@redhat.com" <sage@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Signed-off-by: Ma Jianpeng <jianpeng.ma@intel.com>
---
 src/osd/ECBackend.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/osd/ECBackend.h b/src/osd/ECBackend.h
index 28bcf8a..0e96407 100644
--- a/src/osd/ECBackend.h
+++ b/src/osd/ECBackend.h
@@ -149,10 +149,8 @@ public:
 private:
   friend struct ECRecoveryHandle;
   uint64_t get_recovery_chunk_size() const {
-    uint64_t max = cct->_conf->osd_recovery_max_chunk;
-    max -= max % sinfo.get_stripe_width();
-    max += sinfo.get_stripe_width();
-    return max;
+    return ROUND_UP_TO(cct->_conf->osd_recovery_max_chunk,
+                       sinfo.get_stripe_width());
   }

   /**
--
1.9.1
