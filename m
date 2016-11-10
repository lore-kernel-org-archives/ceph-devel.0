From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 2/5] ceph: move xattr initialzation before the encoding past the ceph_mds_caps
Date: Thu, 10 Nov 2016 07:52:11 -0500
Message-ID: <1478782334-20667-3-git-send-email-jlayton@redhat.com>
References: <1478782334-20667-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932750AbcKJMwR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 10 Nov 2016 07:52:17 -0500
In-Reply-To: <1478782334-20667-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: ceph-devel@vger.kernel.org

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

