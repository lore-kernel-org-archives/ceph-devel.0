From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 1/3] libceph: properly release STAT request's raw_data_in
Date: Mon, 27 Apr 2015 16:24:54 +0800
Message-ID: <1430123096-11516-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48906 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbbD0IZK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Apr 2015 04:25:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 net/ceph/osd_client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 41a4abc..b93531f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -296,6 +296,9 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
 	case CEPH_OSD_OP_CMPXATTR:
 		ceph_osd_data_release(&op->xattr.osd_data);
 		break;
+	case CEPH_OSD_OP_STAT:
+		ceph_osd_data_release(&op->raw_data_in);
+		break;
 	default:
 		break;
 	}
-- 
1.9.3

