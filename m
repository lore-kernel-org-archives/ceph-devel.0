From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 12/12] ceph: support inline data feature
Date: Mon, 17 Nov 2014 15:57:06 +0800
Message-ID: <1416211026-11524-13-git-send-email-zyan@redhat.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42267 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbaKQH6a (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:58:30 -0500
In-Reply-To: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 2b5481f..c37f1b9 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -515,7 +515,8 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	struct ceph_fs_client *fsc;
 	const u64 supported_features =
 		CEPH_FEATURE_FLOCK |
-		CEPH_FEATURE_DIRLAYOUTHASH;
+		CEPH_FEATURE_DIRLAYOUTHASH |
+		CEPH_FEATURE_MDS_INLINE_DATA;
 	const u64 required_features = 0;
 	int page_count;
 	size_t size;
-- 
1.9.3

