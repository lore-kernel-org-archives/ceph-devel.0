Received: from bjy-spam.kuaishou.com (bjy-spam.kuaishou.com [61.16.102.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2381E520A
	for <ceph-devel@vger.kernel.org>; Sat, 18 Apr 2026 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.16.102.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776485575; cv=none; b=c47GLoDBUPdounxixsuXYsgrVZDc0CJ9Ef04VjN0mw3Sms148msJ8Q0kbiZ/4jfO8ix7kFTyralxlYW9Nb3MEW82S3tR5W0sT3PpldCH9XOr1GYykAdfq4J9rO6XF+QF/8Qdp/rhbJxDbswK8uMeg28MBx1WyrtU0t1C4mqDDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776485575; c=relaxed/simple;
	bh=VojyUqUmks8qOD/S9FhQWubhEJDgvhm6Tsve12bLfno=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FQhyqXi1VIothh9pBSRyVVEXBbqL8JmlFgW0BBfQxVTEho9L97XKtbGJmyw98rWJXGZv5qBqVoXKgDfYZSW1Zmmk6cC6FaDLIZ5EqsEdqcdvtOt2swQqVZChWDxRT+RwIWtojcUlllmgTCxafx6BaGqg0zi0RujU2Zx3rgadM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com; spf=pass smtp.mailfrom=kuaishou.com; dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b=gRyK1NDf; arc=none smtp.client-ip=61.16.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b="gRyK1NDf"
Received: from xm-spam01.kuaishou.com (unknown [172.28.128.161])
	by bjy-spam.kuaishou.com (Postfix) with ESMTP id 057542C000360;
	Sat, 18 Apr 2026 12:12:50 +0800 (CST)
Received: from bjxm-pm-mail03.kuaishou.com (unknown [172.28.128.3])
	by xm-spam01.kuaishou.com (Postfix) with ESMTPS id 4fyJHx5MmQz9ty3n;
	Sat, 18 Apr 2026 12:12:45 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
	t=1776485565; h=from:subject:to:date:message-id;
	bh=rYRT5qEDNiatcQR2RWRgT5stC7heUrWv9EnhE8R4e2c=;
	b=gRyK1NDf+O0ykFelzoQjNIS6pRaHtvPH+gFe4+vOmUpxV2N1FwkLMMS6RlNuMZ0blhyNftpkFiG
	ktaYfycVYo/OMRpUZyH9BLhyd06p1gV29R65FTvnbgyxkB/8lrBmfXMgnCMazO3rh5jRyLbhuciWm
	71QI+H0Wn1ttDcSXt6E=
Received: from localhost.localdomain (172.28.1.32) by
 bjxm-pm-mail03.kuaishou.com (172.28.128.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Sat, 18 Apr 2026 12:12:45 +0800
From: Li Lei <lilei24@kuaishou.com>
To: <slava@dubeyko.com>, <idryomov@gmail.com>, <amarkuze@redhat.com>
CC: <ceph-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<noctis.akm@gmail.com>, Li Lei <lilei24@kuaishou.com>, Zhao Sun
	<sunzhao03@kuaishou.com>
Subject: [PATCH] Revert "ceph: when filling trace, call ceph_get_inode outside of mutexes"
Date: Sat, 18 Apr 2026 12:12:41 +0800
Message-ID: <20260418041241.17892-1-lilei24@kuaishou.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjxm-pm-mail04.kuaishou.com (172.28.128.4) To
 bjxm-pm-mail03.kuaishou.com (172.28.128.3)

This reverts commit bca9fc14c70fcbbebc84954cc39994e463fb9468.

Deadlock detected between mdsc->snap_rwsem and the I_NEW bit in
handle_reply().

- kworker/u113:1 (stat inode)
  1) Hold a inode with I_NEW set
  2) Request for mdsc->snap_rwsem
- kworker/u113:2 (readdir)
  1) Hold mdsc->snap_rwsem
  2) Wait for inode I_NEW flag to be cleared

task:kworker/u113:1  state:D stack:    0 pid:34454 ppid:     2
flags:0x00004000
Workqueue: ceph-msgr ceph_con_workfn [libceph]
Call Trace:
__schedule+0x3a9/0x8d0
schedule+0x49/0xb0
rwsem_down_write_slowpath+0x30a/0x5e0
handle_reply+0x4d7/0x7f0 [ceph]
? ceph_tcp_recvmsg+0x6f/0xa0 [libceph]
mds_dispatch+0x10a/0x690 [ceph]
? calc_signature+0xdf/0x110 [libceph]
? ceph_x_check_message_signature+0x58/0xc0 [libceph]
ceph_con_process_message+0x73/0x140 [libceph]
ceph_con_v1_try_read+0x2f2/0x860 [libceph]
ceph_con_workfn+0x31e/0x660 [libceph]
process_one_work+0x1cb/0x370
worker_thread+0x30/0x390
? process_one_work+0x370/0x370
kthread+0x13e/0x160
? set_kthread_struct+0x50/0x50
ret_from_fork+0x1f/0x30

task:kworker/u113:2  state:D stack:    0 pid:54267 ppid:     2
flags:0x00004000
Workqueue: ceph-msgr ceph_con_workfn [libceph]
Call Trace:
__schedule+0x3a9/0x8d0
? bit_wait_io+0x60/0x60
? bit_wait_io+0x60/0x60
schedule+0x49/0xb0
bit_wait+0xd/0x60
__wait_on_bit+0x2a/0x90
? ceph_force_reconnect+0x90/0x90 [ceph]
out_of_line_wait_on_bit+0x91/0xb0
? bitmap_empty+0x20/0x20
ilookup5.part.29+0x69/0x90
? ceph_force_reconnect+0x90/0x90 [ceph]
? ceph_ino_compare+0x30/0x30 [ceph]
iget5_locked+0x26/0x90
ceph_get_inode+0x45/0x130 [ceph]
ceph_readdir_prepopulate+0x59f/0xca0 [ceph]
handle_reply+0x78d/0x7f0 [ceph]
? ceph_tcp_recvmsg+0x6f/0xa0 [libceph]
mds_dispatch+0x10a/0x690 [ceph]
? calc_signature+0xdf/0x110 [libceph]
? ceph_x_check_message_signature+0x58/0xc0 [libceph]
ceph_con_process_message+0x73/0x140 [libceph]
ceph_con_v1_try_read+0x2f2/0x860 [libceph]
ceph_con_workfn+0x31e/0x660 [libceph]
process_one_work+0x1cb/0x370
worker_thread+0x30/0x390
? process_one_work+0x370/0x370
kthread+0x13e/0x160
? set_kthread_struct+0x50/0x50
ret_from_fork+0x1f/0x30

It's rather rear to be caught, but here's Fast Reproduce Steps
(multiple mds is needed):
1. Try to find 2 different directories (DIR_a DIR_b) in a cephfs cluster
    and make sure they have different auth mds nodes. In this way, a client
    may have chances to run handle_reply on different CPU for our test
    (see step 5 and step 6).
2. In DIR_b, create a hard link of DIR_a/FILE_a, namely FILE_b.
    DIR_a/FILE_a and DIR_b/FILE_b have the same ino (123456 e.g)
3. Save ino in code below, make it sleep for stat command.
    ```
    static void handle_reply(struct ceph_mds_session
    *session, struct ceph_msg *msg)
			   goto out_err;
		   }
		   req->r_target_inode = in;
    +               if (in->i_ino == 123456) {
    +                       pr_err("inode %lu found, ready to wait 10 seconds.\n",
    +				in->i_ino);
    +                       msleep(10000);
    +               }
    ```
4. Execute echo 3 > /proc/sys/vm/drop_caches
5. In a shell, do `cd DIR_a;stat DIR_a/FILE_a`, we suppose to be stuck on this shell
    because of msleep() in handle_reply().
6. In the other shell, do `cd DIR_b;ls DIR_b/` to trigger ceph_readdir_prepopulate()

Repeat step 4-6, less than 10 times is enough to see the problem.

It turns out that commit bca9fc14c70f ("ceph: when filling trace, call ceph_get_inode outside of mutexes")
moved ceph_inode_get outside snap_rmsem and made a chance for the deadlock of ceph_inode_get()
and snap_rwsem.

After the following commit, original commit(bca9fc14c70f) can be reverted safely.
commit 6a92b08fdad2 ("ceph: don't take s_mutex or snap_rwsem in ceph_check_caps")

Signed-off-by: Zhao Sun <sunzhao03@kuaishou.com>
Signed-off-by: Li Lei <lilei24@kuaishou.com>
---
 fs/ceph/inode.c      | 26 ++++++++++++++++++++++----
 fs/ceph/mds_client.c | 29 -----------------------------
 2 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d99e12d..0c241a4 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1667,10 +1667,28 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	}
 
 	if (rinfo->head->is_target) {
-		/* Should be filled in by handle_reply */
-		BUG_ON(!req->r_target_inode);
+		in = xchg(&req->r_new_inode, NULL);
+		tvino.ino  = le64_to_cpu(rinfo->targeti.in->ino);
+		tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
+
+		/*
+		 * If we ended up opening an existing inode, discard
+		 * r_new_inode
+		 */
+		if (req->r_op == CEPH_MDS_OP_CREATE &&
+			!req->r_reply_info.has_create_ino) {
+			/* This should never happen on an async create */
+			WARN_ON_ONCE(req->r_deleg_ino);
+			iput(in);
+			in = NULL;
+		}
+
+		in = ceph_get_inode(fsc->sb, tvino, in);
+		if (IS_ERR(in)) {
+			err = PTR_ERR(in);
+			goto done;
+		}
 
-		in = req->r_target_inode;
 		err = ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
 				NULL, session,
 				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
@@ -1680,13 +1698,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		if (err < 0) {
 			pr_err_client(cl, "badness %p %llx.%llx\n", in,
 				      ceph_vinop(in));
-			req->r_target_inode = NULL;
 			if (inode_state_read_once(in) & I_NEW)
 				discard_new_inode(in);
 			else
 				iput(in);
 			goto done;
 		}
+		req->r_target_inode = in;
 		if (inode_state_read_once(in) & I_NEW)
 			unlock_new_inode(in);
 	}
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b174627..8a27775 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3941,36 +3941,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 				       session->s_con.peer_features);
 	mutex_unlock(&mdsc->mutex);
 
-	/* Must find target inode outside of mutexes to avoid deadlocks */
 	rinfo = &req->r_reply_info;
-	if ((err >= 0) && rinfo->head->is_target) {
-		struct inode *in = xchg(&req->r_new_inode, NULL);
-		struct ceph_vino tvino = {
-			.ino  = le64_to_cpu(rinfo->targeti.in->ino),
-			.snap = le64_to_cpu(rinfo->targeti.in->snapid)
-		};
-
-		/*
-		 * If we ended up opening an existing inode, discard
-		 * r_new_inode
-		 */
-		if (req->r_op == CEPH_MDS_OP_CREATE &&
-		    !req->r_reply_info.has_create_ino) {
-			/* This should never happen on an async create */
-			WARN_ON_ONCE(req->r_deleg_ino);
-			iput(in);
-			in = NULL;
-		}
-
-		in = ceph_get_inode(mdsc->fsc->sb, tvino, in);
-		if (IS_ERR(in)) {
-			err = PTR_ERR(in);
-			mutex_lock(&session->s_mutex);
-			goto out_err;
-		}
-		req->r_target_inode = in;
-	}
-
 	mutex_lock(&session->s_mutex);
 	if (err < 0) {
 		pr_err_client(cl, "got corrupt reply mds%d(tid:%lld)\n",
-- 
1.8.3.1

