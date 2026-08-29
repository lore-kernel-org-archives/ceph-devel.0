Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3437C908;
	Sat, 29 Aug 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788003307; cv=none; b=BBQ2rLPEq4oFJnKFQM4H4zEJ9KlofYy2TauFTgd5LjjdnBXzKHXy1WAmqTlGJlmaMSJGlCfRtgvzo2OfNgc1nVdhmu9A6lqNLnDoG3liba7ZyT1nbx/WPBpEODZHCTFKeM030MrCrYJryhtEi9GwqlEOWuI3uw42t5RFtxvhn1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788003307; c=relaxed/simple;
	bh=Un15Zkti7N8QBJ3hax4+aNLOrYGzO78aZ94v4qOMqQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grnCNiXOBkH8p529W0O2r6tpniSUmo5Sh7asrkorq0Bqri8QuQ/BogP1rygjqfb/y8GPVPYqJzusOnT/rKfCEoYxZXiZu7gy+W2rMRMCjt0gsSnyI0JXizrws+QplDaCfjuYLmzZRhofBPk3IdlLHQg1Cz8NIuORPcUZK3ubQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWKEPt5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWKEPt5b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FA16C2BCF5;
	Sat, 29 Aug 2026 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788003307;
	bh=Un15Zkti7N8QBJ3hax4+aNLOrYGzO78aZ94v4qOMqQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IWKEPt5brm8pdMgdDcLg9SIKbq+ThGBT/2W0UzUXK2pEOMJ3hLKDBA3b+84O3qITW
	 EaCp+MLPgydyS1CP9u7gyxkYOoO8blhus6IVZljPtAbu/Jse4sN73LEYoV6L8nIjRa
	 gnO+IqXjRNiJGLq1aWsURiXFMtsuELM+NbgPAAw4OdzmLv5h3E/oAztSlZmhX57eRE
	 75AZI8w6qbPFIizKrVjybXTciNOAO1LrKS3vk93+rTST+I8P54wUA5tekxgviwd31h
	 jcnvztJWn4wY7nggICUcVGCTOL3TESXQHr3brqrc5XsecvFXpXN00cdOTnaPvt6+vu
	 kDqlW9FUFrh7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32722C61DBE;
	Sat, 29 Aug 2026 11:35:07 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Sat, 29 Aug 2026 04:35:01 -0700
Subject: [PATCH v6 1/5] ceph: use READ_ONCE/WRITE_ONCE for oldest_tid
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-ceph-mdsc-mutex-optimization-v6-1-466936ccbd9d@clyso.com>
References: <20260829-ceph-mdsc-mutex-optimization-v6-0-466936ccbd9d@clyso.com>
In-Reply-To: <20260829-ceph-mdsc-mutex-optimization-v6-0-466936ccbd9d@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788003303; l=3350;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=18WejL2UEV4doOiN98828eEMSZB+FE6A4iIzuLLp1Lw=;
 b=hhmdkgc8tM+DJQQxEVC2W9IIwaIlN3qGI2L6LhJ73PrckNiweFr8y2avztmz6vPKyCTFwrj+6
 AENhPH3wRFQCSNhXsgc670WcImha4SILozFYgA3hC3R9CPdIFn06zr1
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

The oldest_client_tid sent in the MDS request header is advisory:
a stale value is harmless --- at worst the MDS may resend a reply
the client already has, or trim its completed-requests table
slightly earlier or later than optimal, both of which the protocol
handles correctly.  The field is monotonic and does not need lock
serialization to stay correct.

Switch all accesses to READ_ONCE() and WRITE_ONCE() to prevent
the compiler from tearing or inventing loads, documenting that
these lockless accesses are intentional.  This removes the last
reason the MDS request-send path had to be serialized under
mdsc->mutex.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/mds_client.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 85f8ceb10377..b84d04835329 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1309,8 +1309,8 @@ static void __register_request(struct ceph_mds_client *mdsc,
 	if (!req->r_mnt_idmap)
 		req->r_mnt_idmap = &nop_mnt_idmap;
 
-	if (mdsc->oldest_tid == 0 && req->r_op != CEPH_MDS_OP_SETFILELOCK)
-		mdsc->oldest_tid = req->r_tid;
+	if (READ_ONCE(mdsc->oldest_tid) == 0 && req->r_op != CEPH_MDS_OP_SETFILELOCK)
+		WRITE_ONCE(mdsc->oldest_tid, req->r_tid);
 
 	if (dir) {
 		struct ceph_inode_info *ci = ceph_inode(dir);
@@ -1331,14 +1331,14 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
 	/* Never leave an unregistered request on an unsafe list! */
 	list_del_init(&req->r_unsafe_item);
 
-	if (req->r_tid == mdsc->oldest_tid) {
+	if (req->r_tid == READ_ONCE(mdsc->oldest_tid)) {
 		struct rb_node *p = rb_next(&req->r_node);
-		mdsc->oldest_tid = 0;
+		WRITE_ONCE(mdsc->oldest_tid, 0);
 		while (p) {
 			struct ceph_mds_request *next_req =
 				rb_entry(p, struct ceph_mds_request, r_node);
 			if (next_req->r_op != CEPH_MDS_OP_SETFILELOCK) {
-				mdsc->oldest_tid = next_req->r_tid;
+				WRITE_ONCE(mdsc->oldest_tid, next_req->r_tid);
 				break;
 			}
 			p = rb_next(p);
@@ -1767,7 +1767,7 @@ create_session_full_msg(struct ceph_mds_client *mdsc, int op, u64 seq)
 	ceph_encode_32(&p, 0);
 
 	/* version == 7, oldest_client_tid */
-	ceph_encode_64(&p, mdsc->oldest_tid);
+	ceph_encode_64(&p, READ_ONCE(mdsc->oldest_tid));
 
 	msg->front.iov_len = p - msg->front.iov_base;
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
@@ -2834,7 +2834,7 @@ static struct ceph_mds_request *__get_oldest_req(struct ceph_mds_client *mdsc)
 
 static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 {
-	return mdsc->oldest_tid;
+	return READ_ONCE(mdsc->oldest_tid);
 }
 
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
@@ -3513,9 +3513,6 @@ static void complete_request(struct ceph_mds_client *mdsc,
 	complete_all(&req->r_completion);
 }
 
-/*
- * called under mdsc->mutex
- */
 static int __prepare_send_request(struct ceph_mds_session *session,
 				  struct ceph_mds_request *req,
 				  bool drop_cap_releases)
@@ -3630,9 +3627,6 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 	return 0;
 }
 
-/*
- * called under mdsc->mutex
- */
 static int __send_request(struct ceph_mds_session *session,
 			  struct ceph_mds_request *req,
 			  bool drop_cap_releases)

-- 
2.53.0


