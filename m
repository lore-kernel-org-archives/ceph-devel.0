From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: [PATCH] fs/ceph: cleanup code.
Date: Mon, 17 Aug 2015 08:45:16 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C1D19FC0E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14196 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbbHQIpU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Aug 2015 04:45:20 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "zyan@redhat.com" <zyan@redhat.com>


Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
---
 fs/ceph/mds_client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 6aa07af..0c65d77 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2520,8 +2520,7 @@ out_err:
                if (err) {
                        req->r_err = err;
                } else {
-                       req->r_reply = msg;
-                       ceph_msg_get(msg);
+                       req->r_reply = ceph_msg_get(msg);
                        req->r_got_result = true;
                }
        } else {
--
2.4.3

