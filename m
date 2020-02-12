From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 7/9] ceph: add new MDS req field to hold delegated inode number
Date: Wed, 12 Feb 2020 12:27:27 -0500
Message-ID: <20200212172729.260752-8-jlayton@kernel.org>
References: <20200212172729.260752-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728673AbgBLR1h (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:27:37 -0500
In-Reply-To: <20200212172729.260752-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idridryomov@gmail.com, sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com

Add new request field to hold the delegated inode number. Encode that
into the message when it's set.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/mds_client.c | 3 +--
 fs/ceph/mds_client.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 314dd0f6f5a9..2321c955439b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2464,7 +2464,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
 	head->op = cpu_to_le32(req->r_op);
 	head->caller_uid = cpu_to_le32(from_kuid(&init_user_ns, req->r_uid));
 	head->caller_gid = cpu_to_le32(from_kgid(&init_user_ns, req->r_gid));
-	head->ino = 0;
+	head->ino = cpu_to_le64(req->r_deleg_ino);
 	head->args = req->r_args;
 
 	ceph_encode_filepath(&p, end, ino1, path1);
@@ -2625,7 +2625,6 @@ static int __prepare_send_request(struct ceph_mds_client *mdsc,
 	rhead->flags = cpu_to_le32(flags);
 	rhead->num_fwd = req->r_num_fwd;
 	rhead->num_retry = req->r_attempts - 1;
-	rhead->ino = 0;
 
 	dout(" r_parent = %p\n", req->r_parent);
 	return 0;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index acad9adca0af..4f25fd6df3f9 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -308,6 +308,7 @@ struct ceph_mds_request {
 	int               r_num_fwd;    /* number of forward attempts */
 	int               r_resend_mds; /* mds to resend to next, if any*/
 	u32               r_sent_on_mseq; /* cap mseq request was sent at*/
+	u64		  r_deleg_ino;
 
 	struct list_head  r_wait;
 	struct completion r_completion;
-- 
2.24.1
