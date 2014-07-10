From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: [PATCH] ReplicatedPG: For async-read, set the real result after
  completing read.
Date: Thu, 10 Jul 2014 09:23:31 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C88781F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49812 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbaGJJXf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jul 2014 05:23:35 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sam.just@inktank.com" <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When reading an object from replicated pool, ceph uses sync mode, so it can set the results in execute_ctx correctly. 
However, For the async-read in EC Pool, current code didn't set the real results after read in complete_read_ctx.

Signed-off-by: Ma Jianpeng <jianpeng.ma@intel.com>
---
 src/osd/ReplicatedPG.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index cab3fde..ac0e8ad 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -5318,7 +5318,7 @@ void ReplicatedPG::complete_read_ctx(int result, OpContext *ctx)
     // on ENOENT, set a floor for what the next user version will be.
     reply->set_enoent_reply_versions(info.last_update, info.last_user_version);
   }
-
+  reply->set_result(result);
   reply->add_flags(CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK);
   osd->send_message_osd_client(reply, m->get_connection());
   close_op_ctx(ctx, 0);
--
1.9.1
