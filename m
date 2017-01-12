From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 4/4] ceph: fix bad endianness handling in parse_reply_info_extra
Date: Thu, 12 Jan 2017 11:12:45 -0500
Message-ID: <1484237565-27423-5-git-send-email-jlayton@redhat.com>
References: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbdALQMu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 12 Jan 2017 11:12:50 -0500
In-Reply-To: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

sparse says:

    fs/ceph/mds_client.c:291:23: warning: restricted __le32 degrades to integer
    fs/ceph/mds_client.c:293:28: warning: restricted __le32 degrades to integer
    fs/ceph/mds_client.c:294:28: warning: restricted __le32 degrades to integer
    fs/ceph/mds_client.c:296:28: warning: restricted __le32 degrades to integer

The op value is __le32, so we need to convert it before comparing it.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/mds_client.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4568f80308f8..176512960b14 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -288,12 +288,13 @@ static int parse_reply_info_extra(void **p, void *end,
 				  struct ceph_mds_reply_info_parsed *info,
 				  u64 features)
 {
-	if (info->head->op == CEPH_MDS_OP_GETFILELOCK)
+	u32 op = le32_to_cpu(info->head->op);
+
+	if (op == CEPH_MDS_OP_GETFILELOCK)
 		return parse_reply_info_filelock(p, end, info, features);
-	else if (info->head->op == CEPH_MDS_OP_READDIR ||
-		 info->head->op == CEPH_MDS_OP_LSSNAP)
+	else if (op == CEPH_MDS_OP_READDIR || op == CEPH_MDS_OP_LSSNAP)
 		return parse_reply_info_dir(p, end, info, features);
-	else if (info->head->op == CEPH_MDS_OP_CREATE)
+	else if (op == CEPH_MDS_OP_CREATE)
 		return parse_reply_info_create(p, end, info, features);
 	else
 		return -EIO;
-- 
2.7.4

