Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AF3502A8;
	Mon, 13 Jul 2026 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936021; cv=none; b=m95zK/8o8GQ8pUwSc82yBIi89n37Oc2ZNGO2bV38GxE+zXdfyzbsD9NxkjVY/1AbdKApTnQO/W6lJQ1M2C6LKDLCHFTWaZudZtHJmXjDG9OISkqBu6HFERkD1UNCBHQOBXzpsbdzd881sQdvwsTmhMe1CaIH4tzAS6b1Sj2xmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936021; c=relaxed/simple;
	bh=usXMJycNUqlqgmLibcqdwKEGzxpM8o0oSreTSQUb9aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HMME34+twzWHOY12SrH8iJk267qG5E8sUDYtiHfBZHHY2kWv6dQJRtdFi2tOMGSH+53BfvOxiYd5GQ8Pg7Kf58OGZqROW9OUCr0bgrDST3BrGmcCrm7pYO1jI4IeUzdK+Rmo6Kou0RXdUU/4edWhyblU6zpwpiJCOwcUeyJ15vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el2LSPKN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el2LSPKN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0471CC2BCF5;
	Mon, 13 Jul 2026 09:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783936021;
	bh=usXMJycNUqlqgmLibcqdwKEGzxpM8o0oSreTSQUb9aA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=el2LSPKNzHjg6LhU5aUFX3YaWjTISFWIoFAgX+XzTbVXH1goRizZn2+3NUyVHiOo7
	 nPthrZHr8LqVoijlVjhc2z/v3FImD9uBapTK+CCticnmJQ1vV2JLz+8i4GsilGqS7Q
	 5O6N/8qMh32651lhJOEXANfstH6Xd2Dbcgs9xYiSKmyabddoA+lgEejaQhpaKaC7d0
	 jFsJQxKbvEKKfPVFImiC3Bo9MFBLnJV71ep4aUajOtVXPFbdoaSgcpy0x0TZ6qIDVv
	 1zXk+diMsy0aCm+v0xe0Rp0rVNgTycn2Ne5a9ODjkSxI9/B4K8W/Mj2OyBe7fihvru
	 5HFtmhjq8UGlQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA535C44501;
	Mon, 13 Jul 2026 09:47:00 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Mon, 13 Jul 2026 17:46:07 +0800
Subject: [PATCH 1/5] ceph: convert oldest_tid to atomic64_t
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ceph-mdsc-mutex-optimization-v1-1-9ae5ac135c34@clyso.com>
References: <20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
In-Reply-To: <20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783936018; l=4251;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=Ln313jfnyI9iEkGY4T3NBIW+U7Vyr9d7sWpnTOxEXz8=;
 b=w6QCuGrFzG0BRds+mcufPiJRiYJhpuLjtvuXJWBV46ojnHI33Q2D5nXDGvhXFW3tJToswXE+2
 LmxifXAJPC4AitJzrl7xVoGrruSkOA69bo+5IfpLSGlLQFij6kxGFHY
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

The oldest_client_tid sent in the MDS request header is advisory:
a stale value is harmless -- at worst the MDS may resend a reply
we already have, or skip one we still need (which will just be
retried).  With the plain u64 read, however, the compiler is free
to split or cache the load, which is undefined behaviour when the
write side runs under mdsc->mutex on a different CPU.

Convert mdsc->oldest_tid from u64 to atomic64_t so that reads
are guaranteed to be single-copy atomic on all architectures.
This removes the one remaining reason __prepare_send_request()
and __send_request() needed to be called under mdsc->mutex, so
drop those comments as well.

All write sites (__register_request, __unregister_request) still
run under mdsc->mutex, so use atomic64_set() for clarity.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/mds_client.c | 21 ++++++++-------------
 fs/ceph/mds_client.h |  2 +-
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 9f84ef2ac6e4..98d0a5baff70 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1235,8 +1235,9 @@ static void __register_request(struct ceph_mds_client *mdsc,
 	if (!req->r_mnt_idmap)
 		req->r_mnt_idmap = &nop_mnt_idmap;
 
-	if (mdsc->oldest_tid == 0 && req->r_op != CEPH_MDS_OP_SETFILELOCK)
-		mdsc->oldest_tid = req->r_tid;
+	if (atomic64_read(&mdsc->oldest_tid) == 0 &&
+	    req->r_op != CEPH_MDS_OP_SETFILELOCK)
+		atomic64_set(&mdsc->oldest_tid, req->r_tid);
 
 	if (dir) {
 		struct ceph_inode_info *ci = ceph_inode(dir);
@@ -1257,14 +1258,14 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
 	/* Never leave an unregistered request on an unsafe list! */
 	list_del_init(&req->r_unsafe_item);
 
-	if (req->r_tid == mdsc->oldest_tid) {
+	if (req->r_tid == atomic64_read(&mdsc->oldest_tid)) {
 		struct rb_node *p = rb_next(&req->r_node);
-		mdsc->oldest_tid = 0;
+		atomic64_set(&mdsc->oldest_tid, 0);
 		while (p) {
 			struct ceph_mds_request *next_req =
 				rb_entry(p, struct ceph_mds_request, r_node);
 			if (next_req->r_op != CEPH_MDS_OP_SETFILELOCK) {
-				mdsc->oldest_tid = next_req->r_tid;
+				atomic64_set(&mdsc->oldest_tid, next_req->r_tid);
 				break;
 			}
 			p = rb_next(p);
@@ -1693,7 +1694,7 @@ create_session_full_msg(struct ceph_mds_client *mdsc, int op, u64 seq)
 	ceph_encode_32(&p, 0);
 
 	/* version == 7, oldest_client_tid */
-	ceph_encode_64(&p, mdsc->oldest_tid);
+	ceph_encode_64(&p, atomic64_read(&mdsc->oldest_tid));
 
 	msg->front.iov_len = p - msg->front.iov_base;
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
@@ -2759,7 +2760,7 @@ static struct ceph_mds_request *__get_oldest_req(struct ceph_mds_client *mdsc)
 
 static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 {
-	return mdsc->oldest_tid;
+	return atomic64_read(&mdsc->oldest_tid);
 }
 
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
@@ -3438,9 +3439,6 @@ static void complete_request(struct ceph_mds_client *mdsc,
 	complete_all(&req->r_completion);
 }
 
-/*
- * called under mdsc->mutex
- */
 static int __prepare_send_request(struct ceph_mds_session *session,
 				  struct ceph_mds_request *req,
 				  bool drop_cap_releases)
@@ -3555,9 +3553,6 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 	return 0;
 }
 
-/*
- * called under mdsc->mutex
- */
 static int __send_request(struct ceph_mds_session *session,
 			  struct ceph_mds_request *req,
 			  bool drop_cap_releases)
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 731d6ad04956..3b614b5df18c 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -532,7 +532,7 @@ struct ceph_mds_client {
 	spinlock_t              snap_empty_lock;  /* protect snap_empty */
 
 	u64                    last_tid;      /* most recent mds request */
-	u64                    oldest_tid;    /* oldest incomplete mds request,
+	atomic64_t             oldest_tid;    /* oldest incomplete mds request,
 						 excluding setfilelock requests */
 	struct rb_root         request_tree;  /* pending mds requests */
 	struct delayed_work    delayed_work;  /* delayed work */

-- 
2.53.0


