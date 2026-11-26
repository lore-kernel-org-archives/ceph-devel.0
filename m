Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795691220;
	b=3DeSMQarMF9xydh5CYkyhzXD9aC9kQJvgKITPuq3ov9Tv6VviO2g/0DL99dWuTdBowo7
	 fcxxIePiI0l8BL3lZCO1JHeTXGNvOCGqDMq8oKD58TNiPDZVOSqFuKEFZe7BI+V1hDErn
	 jnwUGQbO0+kCUGfMyYl/EG+P1ECAaBw9SpnVXREeRFhUp25NLgOLOuVn9UTeR9s/HJgV5
	 mwWLzIOx3kxAH0Gs7go76Nx747yvkbzX4E5F5L5I4K9GrsJmZt5tBKqhBQ+8/Iqexhf0L
	 fXdgpuDYi1GXjx020yPTh8+7d/6XbWBvRTGBk8z5vrHkzbn/9O6xcDMS69Zfju2ykLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691220;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3ujQcAXwSQh01u/e/L7r1yLSAZzyU10lVOfUMXqAK1k=;
	b=iFWhJXJH3DhwMbSC7vsep7Z/5VfbLGnNn8iwCaaGKYlr99fqDT4ScvrAYppAU8AkwLYj
	 fjeXeksRs+BkpR9r1RanYHmD+zuGgi26CMmO0HE/q8FVgjQjpTKTBEdKAUcjHEIwiQoKH
	 NHKy/Tx73wWMjlnmK1IDoef0hnN4+YQMwp6HjtH4cGnf3yxk2W5D/MKArDiGsLyrGxzDS
	 5rFipsHjgQ7uXcsKM384XFJ+8vhYbnZhJDlRS4hLwQvUxeYNRcFr867zzeBeXgWgjQRPG
	 T2TjS5jc3aV5vxs8nSu+VJWVaMtUnu5+WtfEGwELj+1f6CNFffbzR/7Svcro4MOlSUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a62NKWXY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF3606A31C;
	Thu, 26 Nov 2026 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a62NKWXY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795691220;
	b=YPmMzBTuWYpi8xDBbI5LlFtk70wwHngEGivLhgQH+HpviCNAyXfIMGgmrFb1P5K5+QmE
	 SUaiIrqx0ZifxRX+WQlScernaHB0hdtT8EHQMR+R/cznXfZf8qB/FXk8k7FKaPYMLByQd
	 riV1a3oisU29YEf/FXq99nhQzbdVzM+C0YcooGb+p3/67Jfzq6E+GSry3rEnqknf7J1oj
	 jSodVjnSa1xvW3mOxOF60d/sMV60QYvNCv5bf4mUiJsnXeFsFdJ/dz3NIWDKnyc75/l8s
	 ONQTnCDwN+ZXgkaLsstqy5nIz+lNm8XTxJ8oDLBhVmpedVKs+k/oiR1TmgycpnwCLjA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795691220;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3ujQcAXwSQh01u/e/L7r1yLSAZzyU10lVOfUMXqAK1k=;
	b=Pt7iGbeFhh4iE0CDe5sQKeaqJKPVtVTQXdxkp/HlRqLwvUzn0EF4aPc6rLUYZMszKg8z
	 3XDD2dl+KaMyCw6Ro/me4BPwJbRi4zkoLW5La6+uuWTOf2VDlcEg1c5fKyoa/Vd/svLSy
	 FWLG4o6cMIRXOBHAKH6MC+Gj0WfMsXqp3nsCa2j2l4inDGs8dyQe44ATCMRFBevhHys/h
	 agZbMJCqpY2F1HEDbhmXfHte4vMGAWFGJkStrv+l4/F+KtUEDWB00WpV7OcuDLo5epJuw
	 DBOGwiDnZQYuc7fCwaaQsxz4KEaWSFQziYVUyQ7eEmdjd1ACsBSulTMT4S2QxPfCo8g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DE9771F000C6;
	Thu, 26 Nov 2026 11:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691220;
	bh=3ujQcAXwSQh01u/e/L7r1yLSAZzyU10lVOfUMXqAK1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=a62NKWXYDyQemeEgp8KSOsmeII7wwgsuTjM8egi0VJhjS7KKclxvRuzaJNsvbsGyh
	 OdtruZEa9LHk+0KcCka201TJUU47ubTxDWsvYE2rGlgAmuLnKWQnm69Zys4dsCShNu
	 GCkIRQ74yc0Gsh0Gozm5Eus+k9rxscGVYDKDvv9ZwgB5Zhm9YH1iLJ60QZLSR/3632
	 A2pd/D8X6w7rmYxeNTy2CRzrezbNhopoEedWmgEv/OV/v2CilXMKGG4saejVAJlb+O
	 S53fY15UFT+zPcHZAPDv0Ol4MoqEHubpyvDTppBffsPgEQiP/GNBhLBm11zfnc7EmL
	 +EK+96CMvfNFg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 630C24D469;
	Thu, 26 Nov 2026 11:06:56 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Thu, 26 Nov 2026 12:06:11 +0100
Subject: [PATCH v8 1/5] ceph: use READ_ONCE/WRITE_ONCE for oldest_tid
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-ceph-mdsc-mutex-optimization-v8-1-5bb2299ef4ee@clyso.com>
References: <20261126-ceph-mdsc-mutex-optimization-v8-0-5bb2299ef4ee@clyso.com>
In-Reply-To: <20261126-ceph-mdsc-mutex-optimization-v8-0-5bb2299ef4ee@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795691181; l=3350;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=18WejL2UEV4doOiN98828eEMSZB+FE6A4iIzuLLp1Lw=;
 b=Gi+6bN6qYrWUqxuixcmIi+uvlYVkoTL93khGnd12h0Dc+xO/4cW62keo1y77oay2GX0KIY4WN
 /T3a55BmMbpDYPPnXVtyUerCJ01CwDzvwelfNtH3JmH3QBrqlJHxu8n
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

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


