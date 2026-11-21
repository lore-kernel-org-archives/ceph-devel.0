Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795224085;
	b=giKZ2bljU6RfokgLl5QSD3TUqrn2ASAC+BAmJtBcDIpnCk5XNp9ffXuMURBQcnsDzPiC
	 MSZUM7uzmIxjPuJbU3St0KtxWaelq2SEf7PT+3p6QQb2zH703mRkZa/PRnz5+dKlz/2pB
	 sd7R+pVtZsc2u3uNCa1NsPkzS2Eb/PtFpVgvYHiFp9y3UCi0pcCx8kfZNM3S9Gy6x64NG
	 7Q7wSr3K5MwiG43z06dOQPYGrG52oa1uSR/DIvCCWzG1Muh0qaLdkau9KryvhX9gbkoJS
	 izmSFwziRtwQ4PQWNkBYG2sEyT0qkquxYTHpoLyHDDXBJkRpPnLCH1AWji2e3AjPEhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224085;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CgH6+MgNTatJOiFpT/V8tacHwXCdnUWjBLQeXnUgHxw=;
	b=gU7L2ueDhgCMYLkJTRso2oXlDyDHp1TNNfK4PtiyhD3GG/IwrONloYClgvJPQJqCARU4
	 uIrbtjg16bM169/SYQI/os5KavfZKK1sWG79P4SW3Fh+F06Nn417szs97Le/XSr5xgqr2
	 r4GLZlkyjHoT9/7DcPAb3H3l9czP1H4ws7ndtwq4HAthR0q6Bcb5q1NEAn/+9PMXsPCZm
	 ueexmwAU2RmcrhJM+Qf54vLni79kbLWBNzzmBCbWcnoJTp2WrewVe+97LnWpJwgvHnWEE
	 4l/5PA2kIFkF/sHx8uaRMtZZP56iuSzI8wjTzCfc/n9/x+gkvw3CTtzURlvv3yQ72SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBLD7KKy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286BA606A684;
	Sat, 21 Nov 2026 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBLD7KKy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795224084;
	b=zIJkgYBtO70VpCpvKpOzKU2g5SFMto1hs3tACG4+jNS9SSTfJzBujpLL6/uQ0eStCNM/
	 xB6Cup4i5T6cwd3EFgaBhb/wfSz3VsFWr8HP+jk4RRFuM3t6R1YuC9RsFQJTaxI2XE8F/
	 l3W0IUrjKlx/GyHQRf1Fq4TrvY0umyCI8gpGP5PEoQ+CwWhV8mvc9ritnRsspmBQ69NaJ
	 +ozd3QDOVid8UCf6nwlRkqak/6/HbAsPDmR3uUPn/JzbytuSTVqhBuVBSylGVkwaLh6Ws
	 KwjYkNIC7Bein9zeBhhWtU8MFV56MYUOWTCZsWvD1adLWq1QHFntwoWP8I5n1d6NEag==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795224084;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CgH6+MgNTatJOiFpT/V8tacHwXCdnUWjBLQeXnUgHxw=;
	b=eDCKiFWsqGFBzVNtQcNIzaXB2PN5ofBwSzdHZA/B82udqfBA2NTkELBloLbnHxaMNz2i
	 YR/7VEQ+d3Li2P4hw28b1joRMX42Xl4lxkpfLR3IAV7qAb3lc22uu0Dr9g1zpjDoWbT+U
	 YCG5xViZkAXYBwVYHFdF8FsO9aUA3vcxAg09VuFYZ0EzPI3pcYf1FYchJuuLafDddysRi
	 wP0UAl9UGLvB/JeNptycFGhUuKu9nwkC56Jfry/K7ApMYO8aSkxrb3Hllxu2hviuO2Fi2
	 TpsYwMvI7Ma1vxzdODbfYjsmuVfwZlmUJ/1RmMJ+yJAaLL+aVGSBiE2I1zVaV43KJFQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A878F1F000D3;
	Sat, 21 Nov 2026 01:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795224084;
	bh=CgH6+MgNTatJOiFpT/V8tacHwXCdnUWjBLQeXnUgHxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QBLD7KKyqs1F5rv2vp7jYpwaaZeS7TJG9WFrJCGqHRfXZhaE8KlYuKNOum6MGWdrW
	 ALdpkF38aD8C/pr8Kg3AliAz9hW5Lyse7gbIRp211Jf7cXihiQFjhx5Jh7Xn29pMzw
	 oJuBCPzRHB/DOygLF4awdTDovh7XtRG+cslzw1jigmIrhv6SXM7WkPBC+XHS5w48Uy
	 ioctcx10DrpDqV0MMuVGKQLNBInWGL7NGM8uivpRmLYVaYF9QM5ac1n79kF8qoc/uF
	 Z9mgssLMcDrUp5ormZXPd7AscsCxYZybPr5mrHkKq10z89SaujZ1mJ8NLcJKjYKFTf
	 cbptsd1G9mzCA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 32FE54BA6D;
	Sat, 21 Nov 2026 01:21:14 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Sat, 21 Nov 2026 03:21:05 +0200
Subject: [PATCH 1/2] ceph: send the cap messages of an inode in the order
 they were prepared
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
Message-Id: <20261121-ceph-append-excl-v1-1-5870375edeb8@clyso.com>
References: <20261121-ceph-append-excl-v1-0-5870375edeb8@clyso.com>
In-Reply-To: <20261121-ceph-append-excl-v1-0-5870375edeb8@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Anthony D'Atri <anthony.datri@gmail.com>, Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795224072; l=5427;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=y3woOdrYDlCWZyslXlQYRQjjWOiA5KFxuYSJ/ghk1wc=;
 b=pAzz36lDnKBe6GW+JH/A3ZbgQJdDuirSX3l0oRjPsTOXIxbej57hRsSk5VNCvkLQGeBXy+jJu
 XZmWFf9L7vGCcDyXDoXFvkUtKyn8FR+oKH2feFqNVFB2DCrTDZyNqPs
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

__prep_cap() runs under i_ceph_lock: it drops the released caps from
cap->implemented and moves the dirty caps to flushing.  __send_cap()
then allocates and sends the message after the lock was dropped, so
two threads that check the caps of an inode at the same time, e.g. one
putting its last cap refs and one handling a revoke, can send their
messages in the opposite order.

The later message no longer has the dirty caps, nor the caps that the
earlier one gives up.  If it reaches the MDS first, the MDS sees those
caps released with nothing dirty, finishes its gather and may hand the
caps to another client before the flush with our new size and mtime
arrives.  Seen with two clients appending to a file with O_DIRECT: the
MDS completed the gather of Fw on an update with dirty=-, sent Fx with
the old size to the other client, and the flush with the new size
arrived 1 ms later; the other client wrote over our last record.

Number the messages of an inode in __prep_cap() and let __send_cap()
send them in that order.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c  | 29 +++++++++++++++++++++++++++++
 fs/ceph/inode.c |  3 +++
 fs/ceph/super.h |  3 +++
 3 files changed, 35 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 3f4ac4d94d5b..fd6f3a372271 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1398,6 +1398,7 @@ struct cap_msg_args {
 	umode_t			mode;
 	bool			inline_data;
 	bool			wake;
+	u32			ticket;		/* send order, see __send_cap() */
 	bool			encrypted;
 	u32			fscrypt_auth_len;
 	u8			fscrypt_auth[sizeof(struct ceph_fscrypt_auth)]; // for context
@@ -1575,6 +1576,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci,
 	clear_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
 
 	cap->issued &= retain;  /* drop bits we don't want */
+	arg->ticket = ci->i_cap_msg_next++;
 	/*
 	 * Wake up any waiters on wanted -> needed transition. This is due to
 	 * the weird transition from buffered to sync IO... we need to flush
@@ -1698,6 +1700,30 @@ static inline int cap_msg_size(struct cap_msg_args *arg)
  *
  * Caller should hold snap_rwsem (read), s_mutex.
  */
+/*
+ * __prep_cap() updates cap->implemented and moves the dirty caps to
+ * flushing under i_ceph_lock, but the message goes out after the lock
+ * was dropped.  Another thread may prepare a later message for the same
+ * inode meanwhile, which then no longer has the dirty caps nor the caps
+ * we are giving up: if it went out first, the MDS would see those caps
+ * released with nothing dirty, finish its gather and hand them (with an
+ * out of date size, say) to another client before our flush arrived.
+ * Send the messages of an inode in the order they were prepared.
+ */
+static void __cap_msg_wait_turn(struct ceph_inode_info *ci, u32 ticket)
+{
+	wait_event(ci->i_cap_msg_wq,
+		   READ_ONCE(ci->i_cap_msg_sent) == ticket);
+}
+
+static void __cap_msg_done(struct ceph_inode_info *ci)
+{
+	spin_lock(&ci->i_ceph_lock);
+	ci->i_cap_msg_sent++;
+	spin_unlock(&ci->i_ceph_lock);
+	wake_up_all(&ci->i_cap_msg_wq);
+}
+
 static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci)
 {
 	struct ceph_msg *msg;
@@ -1706,6 +1732,7 @@ static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci)
 
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, cap_msg_size(arg), GFP_NOFS,
 			   false);
+	__cap_msg_wait_turn(ci, arg->ticket);
 	if (!msg) {
 		pr_err_client(cl,
 			      "error allocating cap msg: ino (%llx.%llx)"
@@ -1715,6 +1742,7 @@ static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci)
 		spin_lock(&ci->i_ceph_lock);
 		__cap_delay_requeue(arg->session->s_mdsc, ci);
 		spin_unlock(&ci->i_ceph_lock);
+		__cap_msg_done(ci);
 		ceph_buffer_put(arg->old_xattr_buf);
 		ceph_buffer_put(arg->xattr_buf);
 		return;
@@ -1722,6 +1750,7 @@ static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci)
 
 	encode_cap_msg(msg, arg);
 	ceph_con_send(&arg->session->s_con, msg);
+	__cap_msg_done(ci);
 	ceph_buffer_put(arg->old_xattr_buf);
 	ceph_buffer_put(arg->xattr_buf);
 	if (arg->wake)
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index b615326f83bf..2e5d1256a3a5 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -675,6 +675,9 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	ci->i_prealloc_cap_flush = NULL;
 	INIT_LIST_HEAD(&ci->i_cap_flush_list);
 	init_waitqueue_head(&ci->i_cap_wq);
+	ci->i_cap_msg_next = 0;
+	ci->i_cap_msg_sent = 0;
+	init_waitqueue_head(&ci->i_cap_msg_wq);
 	ci->i_hold_caps_max = 0;
 	INIT_LIST_HEAD(&ci->i_cap_delay_list);
 	INIT_LIST_HEAD(&ci->i_cap_snaps);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 0e6c8968b80d..b11083ad1da7 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -483,6 +483,9 @@ struct ceph_inode_info {
 	struct ceph_cap_flush *i_prealloc_cap_flush;
 	struct list_head i_cap_flush_list;
 	wait_queue_head_t i_cap_wq;      /* threads waiting on a capability */
+	/* cap messages prepared and sent, see __send_cap() */
+	u32 i_cap_msg_next, i_cap_msg_sent;
+	wait_queue_head_t i_cap_msg_wq;
 	unsigned long i_hold_caps_max; /* jiffies */
 	struct list_head i_cap_delay_list;  /* for delayed cap release to mds */
 	struct list_head i_cap_snaps;   /* snapped state pending flush to mds */

-- 
2.53.0


