Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937682F3C18;
	Wed, 12 Aug 2026 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518988; cv=none; b=NvOqt82/6THAhfW6IAdQ+ukQ8OJcYr4l+H4QsBu/IsmPMFRfqSuuvkyRJsMTlBK9hXYeFFj/7tY8aWCowogqpwRhuchQVECY1i/4LU1pDdKPOA+d90IF/B82QtZCWBWY7jRoNx4iYKYmQByECZK7TfA19xtydik4Dfw+Li3/0GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518988; c=relaxed/simple;
	bh=NRy+vc4hWJQrUiBYfp3itTG4myVbZh4BfWueZTePwcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdEFJyPEE5fs6/3z2bXbLERfnmCW+Vt7zAqhZKubFhu5Z6vlaDJLWhRdPrP3SVxJA6C/1lX6BTvYcakZcK6aAUxQFYmQ/hnS4vhp5bnYehwghKLzMivOM0VtijpmnuDIx+i9ah1WamTxVAuzWk4ukSl9m4Bsr8kAlCV+aHH6++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKvYtHb0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKvYtHb0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AB1BC2BCB9;
	Wed, 12 Aug 2026 07:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786518988;
	bh=NRy+vc4hWJQrUiBYfp3itTG4myVbZh4BfWueZTePwcI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TKvYtHb0t24u9g8JYzVL2npsEDsJF+Af0Eb6ixAZNMcFtmOvIgk5P7KCeR9Pk3qnl
	 YmRS8a4+pRj3PwkDTH/TwDqgG3SBLbuwB9myN6aVLUZ07TyuQz0En7Oy8n18DwI19p
	 s8JmtPPoLrYeutQd9+NAyGA7bisUgL2mt1KrnCTF8V3+h94UIo2+3gPi7+Jv0EaYF4
	 asi7/b6NixP2RtIf/jXOHk0poBfffxNT9pP0/DsgBYuqlf3zVI8PkaOB5m8jj27mF1
	 NoAjwtOvdQhvNJhncDUOAfciK/x31fCSnBUnODWX7YYIoJm5WMqbylApOLO1br+/7s
	 9S1IH/HaQHwIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D73EC5B567;
	Wed, 12 Aug 2026 07:16:28 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Wed, 12 Aug 2026 00:16:17 -0700
Subject: [PATCH v4 1/5] ceph: use READ_ONCE/WRITE_ONCE for oldest_tid
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-ceph-mdsc-mutex-optimization-v4-1-fca3b7462f94@clyso.com>
References: <20260812-ceph-mdsc-mutex-optimization-v4-0-fca3b7462f94@clyso.com>
In-Reply-To: <20260812-ceph-mdsc-mutex-optimization-v4-0-fca3b7462f94@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786518984; l=3350;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=exqvyxSW2xd5rzPWwAc/Vr8hxgWOg5BerR4rCyEJz+w=;
 b=kQYPs6CIZ+Wkh2tERRTSaogQoLGEs2zkSTVMFuZC9ocHomL5b789/CKL+KLFENjFeszaAjYvr
 sWYXUhBr7i0AxrSwUSm+W1Mdw+lYCvKbcYfkxTv3ROzOx0XpgLDE64k
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
index f365e434e35d..2c51edd0e9cd 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1240,8 +1240,8 @@ static void __register_request(struct ceph_mds_client *mdsc,
 	if (!req->r_mnt_idmap)
 		req->r_mnt_idmap = &nop_mnt_idmap;
 
-	if (mdsc->oldest_tid == 0 && req->r_op != CEPH_MDS_OP_SETFILELOCK)
-		mdsc->oldest_tid = req->r_tid;
+	if (READ_ONCE(mdsc->oldest_tid) == 0 && req->r_op != CEPH_MDS_OP_SETFILELOCK)
+		WRITE_ONCE(mdsc->oldest_tid, req->r_tid);
 
 	if (dir) {
 		struct ceph_inode_info *ci = ceph_inode(dir);
@@ -1262,14 +1262,14 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
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
@@ -1698,7 +1698,7 @@ create_session_full_msg(struct ceph_mds_client *mdsc, int op, u64 seq)
 	ceph_encode_32(&p, 0);
 
 	/* version == 7, oldest_client_tid */
-	ceph_encode_64(&p, mdsc->oldest_tid);
+	ceph_encode_64(&p, READ_ONCE(mdsc->oldest_tid));
 
 	msg->front.iov_len = p - msg->front.iov_base;
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
@@ -2764,7 +2764,7 @@ static struct ceph_mds_request *__get_oldest_req(struct ceph_mds_client *mdsc)
 
 static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 {
-	return mdsc->oldest_tid;
+	return READ_ONCE(mdsc->oldest_tid);
 }
 
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
@@ -3443,9 +3443,6 @@ static void complete_request(struct ceph_mds_client *mdsc,
 	complete_all(&req->r_completion);
 }
 
-/*
- * called under mdsc->mutex
- */
 static int __prepare_send_request(struct ceph_mds_session *session,
 				  struct ceph_mds_request *req,
 				  bool drop_cap_releases)
@@ -3560,9 +3557,6 @@ static int __prepare_send_request(struct ceph_mds_session *session,
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


