From: Jeff Layton <jlayton@redhat.com>
Subject: [RFC PATCH 10/10] ceph: turn on btime and change_attr support
Date: Fri,  4 Nov 2016 07:34:33 -0400
Message-ID: <1478259273-3471-11-git-send-email-jlayton@redhat.com>
References: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761180AbcKDLem (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 07:34:42 -0400
In-Reply-To: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

All of the necessary plumbing is in place.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b382e5910eea..35355ee88744 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -536,7 +536,8 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	struct ceph_fs_client *fsc;
 	const u64 supported_features =
 		CEPH_FEATURE_FLOCK | CEPH_FEATURE_DIRLAYOUTHASH |
-		CEPH_FEATURE_MDSENC | CEPH_FEATURE_MDS_INLINE_DATA;
+		CEPH_FEATURE_MDSENC | CEPH_FEATURE_MDS_INLINE_DATA |
+		CEPH_FEATURE_FS_BTIME;
 	const u64 required_features = 0;
 	int page_count;
 	size_t size;
-- 
2.7.4

