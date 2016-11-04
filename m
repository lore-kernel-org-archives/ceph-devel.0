From: Jeff Layton <jlayton@redhat.com>
Subject: [RFC PATCH 02/10] ceph: move xattr initialzation before the encoding past the ceph_mds_caps
Date: Fri,  4 Nov 2016 07:34:25 -0400
Message-ID: <1478259273-3471-3-git-send-email-jlayton@redhat.com>
References: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761091AbcKDLeg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 07:34:36 -0400
In-Reply-To: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

Just for clarity. This part is inside the header, so it makes sense to
group it with the rest of the stuff in the header.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d37a04b87d2c..2a5caee2fb17 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1057,6 +1057,13 @@ static int send_cap_msg(struct ceph_mds_session *session,
 	fc->gid = cpu_to_le32(from_kgid(&init_user_ns, gid));
 	fc->mode = cpu_to_le32(mode);
 
+	fc->xattr_version = cpu_to_le64(xattr_version);
+	if (xattrs_buf) {
+		msg->middle = ceph_buffer_get(xattrs_buf);
+		fc->xattr_len = cpu_to_le32(xattrs_buf->vec.iov_len);
+		msg->hdr.middle_len = cpu_to_le32(xattrs_buf->vec.iov_len);
+	}
+
 	p = fc + 1;
 	/* flock buffer size */
 	ceph_encode_32(&p, 0);
@@ -1069,13 +1076,6 @@ static int send_cap_msg(struct ceph_mds_session *session,
 	/* oldest_flush_tid */
 	ceph_encode_64(&p, oldest_flush_tid);
 
-	fc->xattr_version = cpu_to_le64(xattr_version);
-	if (xattrs_buf) {
-		msg->middle = ceph_buffer_get(xattrs_buf);
-		fc->xattr_len = cpu_to_le32(xattrs_buf->vec.iov_len);
-		msg->hdr.middle_len = cpu_to_le32(xattrs_buf->vec.iov_len);
-	}
-
 	ceph_con_send(&session->s_con, msg);
 	return 0;
 }
-- 
2.7.4

