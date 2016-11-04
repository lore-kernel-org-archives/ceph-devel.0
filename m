From: Jeff Layton <jlayton@redhat.com>
Subject: [RFC PATCH 08/10] ceph: add sync parameter to send_cap_msg
Date: Fri,  4 Nov 2016 07:34:31 -0400
Message-ID: <1478259273-3471-9-git-send-email-jlayton@redhat.com>
References: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761679AbcKDLel (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 07:34:41 -0400
In-Reply-To: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

So we can request an MDS log flush on a cap message when we know that
we'll be waiting on the result.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 452f5024589f..e92c6ce53af6 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -999,7 +999,7 @@ struct cap_msg_args {
 	kuid_t			uid;
 	kgid_t			gid;
 	umode_t			mode;
-	bool			inline_data;
+	bool			inline_data, sync;
 };
 
 /*
@@ -1090,7 +1090,7 @@ static int send_cap_msg(struct cap_msg_args *arg)
 	ceph_encode_timespec(p, &arg->btime);
 	p += sizeof(struct ceph_timespec);
 	ceph_encode_64(&p, arg->change_attr);
-	ceph_encode_8(&p, 0);
+	ceph_encode_8(&p, arg->sync);
 
 	ceph_con_send(&arg->session->s_con, msg);
 	return 0;
@@ -1223,6 +1223,7 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	arg.mode = inode->i_mode;
 
 	arg.inline_data = ci->i_inline_version != CEPH_INLINE_NONE;
+	arg.sync = false;
 
 	spin_unlock(&ci->i_ceph_lock);
 
@@ -1278,6 +1279,7 @@ static inline int __send_flush_snap(struct inode *inode,
 	arg.mode = capsnap->mode;
 
 	arg.inline_data = capsnap->inline_data;
+	arg.sync = false;
 
 	return send_cap_msg(&arg);
 }
-- 
2.7.4

