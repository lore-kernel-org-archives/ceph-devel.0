From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] rbd: Clear ceph_msg->bio_iter for retransmitted message
Date: Wed,  6 Jun 2012 16:03:17 +0800
Message-ID: <1338969797-8412-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61415 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885Ab2FFIDT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Jun 2012 04:03:19 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The bug can cause NULL pointer dereference in write_partial_msg_pages

Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
---
 net/ceph/messenger.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 1a80907..785b953 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -598,6 +598,7 @@ static void prepare_write_message(struct ceph_connection *con)
 	     le32_to_cpu(con->out_msg->footer.front_crc),
 	     le32_to_cpu(con->out_msg->footer.middle_crc));
 
+	m->bio_iter = NULL;
 	/* is there a data payload? */
 	if (le32_to_cpu(m->hdr.data_len) > 0) {
 		/* initialize page iterator */
-- 
1.7.7.6

