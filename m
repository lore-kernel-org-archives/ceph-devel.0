From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 4/5] ceph: update cap message struct version to 10
Date: Thu, 10 Nov 2016 07:52:13 -0500
Message-ID: <1478782334-20667-5-git-send-email-jlayton@redhat.com>
References: <1478782334-20667-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932821AbcKJMwS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 10 Nov 2016 07:52:18 -0500
In-Reply-To: <1478782334-20667-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: ceph-devel@vger.kernel.org

The userland ceph has MClientCaps at struct version 10. This brings the
kernel up the same version.

For now, all of the the new stuff is set to default values including
the flags field, which will be conditionally set in a later patch.

Note that we don't need to set the change_attr and btime to anything
since we aren't currently setting the feature flag. The MDS should
ignore those values.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d1c02646cd51..c4886b1a9470 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1013,6 +1013,7 @@ static int send_cap_msg(struct cap_msg_args *arg)
 	struct ceph_msg *msg;
 	void *p;
 	size_t extra_len;
+	struct timespec zerotime = {0};
 
 	dout("send_cap_msg %s %llx %llx caps %s wanted %s dirty %s"
 	     " seq %u/%u tid %llu/%llu mseq %u follows %lld size %llu/%llu"
@@ -1026,13 +1027,13 @@ static int send_cap_msg(struct cap_msg_args *arg)
 
 	/* flock buffer size + inline version + inline data size +
 	 * osd_epoch_barrier + oldest_flush_tid */
-	extra_len = 4 + 8 + 4 + 4 + 8;
+	extra_len = 4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 4;
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, sizeof(*fc) + extra_len,
 			   GFP_NOFS, false);
 	if (!msg)
 		return -ENOMEM;
 
-	msg->hdr.version = cpu_to_le16(6);
+	msg->hdr.version = cpu_to_le16(10);
 	msg->hdr.tid = cpu_to_le64(arg->flush_tid);
 
 	fc = msg->front.iov_base;
@@ -1068,17 +1069,43 @@ static int send_cap_msg(struct cap_msg_args *arg)
 	}
 
 	p = fc + 1;
-	/* flock buffer size */
+	/* flock buffer size (version 2) */
 	ceph_encode_32(&p, 0);
-	/* inline version */
+	/* inline version (version 4) */
 	ceph_encode_64(&p, arg->inline_data ? 0 : CEPH_INLINE_NONE);
 	/* inline data size */
 	ceph_encode_32(&p, 0);
-	/* osd_epoch_barrier */
+	/* osd_epoch_barrier (version 5) */
 	ceph_encode_32(&p, 0);
-	/* oldest_flush_tid */
+	/* oldest_flush_tid (version 6) */
 	ceph_encode_64(&p, arg->oldest_flush_tid);
 
+	/*
+	 * caller_uid/caller_gid (version 7)
+	 *
+	 * Currently, we don't properly track which caller dirtied the caps
+	 * last, and force a flush of them when there is a conflict. For now,
+	 * just set this to 0:0, to emulate how the MDS has worked up to now.
+	 */
+	ceph_encode_32(&p, 0);
+	ceph_encode_32(&p, 0);
+
+	/* pool namespace (version 8) (mds always ignores this) */
+	ceph_encode_32(&p, 0);
+
+	/*
+	 * btime and change_attr (version 9)
+	 *
+	 * We just zero these out for now, as the MDS ignores them unless
+	 * the requisite feature flags are set (which we don't do yet).
+	 */
+	ceph_encode_timespec(p, &zerotime);
+	p += sizeof(struct ceph_timespec);
+	ceph_encode_64(&p, 0);
+
+	/* Advisory flags (version 10) */
+	ceph_encode_32(&p, 0);
+
 	ceph_con_send(&arg->session->s_con, msg);
 	return 0;
 }
-- 
2.7.4

