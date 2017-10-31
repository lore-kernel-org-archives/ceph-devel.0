From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] ceph: silence sparse endianness warning in encode_caps_cb
Date: Tue, 31 Oct 2017 16:09:24 -0400
Message-ID: <20171031200924.27875-1-jlayton@kernel.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752023AbdJaUJ1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 31 Oct 2017 16:09:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

fs/ceph/mds_client.c:2887:34: warning: incorrect type in assignment (different base types)
fs/ceph/mds_client.c:2887:34:    expected restricted __le32 [assigned] [usertype] flock_len
fs/ceph/mds_client.c:2887:34:    got int

At this point, it's just being used as a flag. It gets
overwritten later if the rest of the encoding succeeds.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/mds_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f5b1e8d73e85..927afb612e43 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2884,8 +2884,8 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
 		rec.v2.issued = cpu_to_le32(cap->issued);
 		rec.v2.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
 		rec.v2.pathbase = cpu_to_le64(pathbase);
-		rec.v2.flock_len =
-			(ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1;
+		rec.v2.flock_len = (__force __le32)
+			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
 	} else {
 		rec.v1.cap_id = cpu_to_le64(cap->cap_id);
 		rec.v1.wanted = cpu_to_le32(__ceph_caps_wanted(ci));
-- 
2.13.6

