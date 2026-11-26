Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675849;
	b=gTrKFIqEjjA8gxb5i7ybFbap1dzJuZ3yf9sfTQJe5k1Qn1GI8h6WmbPWnvLyfI2+sS1H
	 IMzRqGKQvRhQ3qPh9o9PrHQvHNgSdosFp6eOP+N/MgkSFG6JHd36rrlTXE9BIENg/y/cK
	 KEzRpN1crag3YZkM0tu4VH5Mq7wfNTjipGDMVjIK/dVP1Wx7mxb/kAdcCntabNuc1kH5G
	 lCH5yEEkiv6zqMYmAuh2JOnZk4YFZ81B/WMh15Bw3vB8orrSpTnq8znUUzmnnq8c1JoQy
	 VvAoO6jghCLMMtJ+VxmwxbCaiV1AV/5u/Yz+Zxz+gqrRRCuxQry7idBjiAHsVOy5n2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675849;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CgH6+MgNTatJOiFpT/V8tacHwXCdnUWjBLQeXnUgHxw=;
	b=ND3aLMNSmR56o4/YKKuVx0tUKaHwjbjYFMKmazI8BndeVwJix99VUlJEru7CAE0FTu/R
	 i8xAfjAdnDJJp4/5zNk/sbs49aolp0vILTtAdrRS3oJ/I55BJtF4FAH/1ePl8gVI6vk1C
	 hCA1JjP2VX3Y9MFzV64/HqiEZSMHbD7VIMdqw+oI7nu9VhaLq2GN5UebGD5s1XzWKqSxO
	 OqQEy/7ajF1Om7av5q4QwHTRx6hjCHOubgtb33c+F1qluh44Fhu9PsbY6jYUXRI7xauGU
	 4Ed22McU2vlLxytIQJ2a2GbYghmJHGSQsgTmbMpgf+pd2lIUmc/Ay2BmWUHMDOAgzxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OQH/e8o/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB12606A321;
	Thu, 26 Nov 2026 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQH/e8o/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795675848;
	b=HZVBDNSripe1AG2zsXdd2nK3Q/XnrQh/pCXNZ+Wu990LvJdnKYonnIoUgm/0t9HrWEmk
	 ZJOBZJqH2BNqAJhe2yFY226B9r7xgwzY2gDmtrYAVy9IYMgUTyKuMCQ7s37zsrOS5v0se
	 OhoeeOUsV4gv/4OB+3UVXTxGH9rOEBgat/uGHUvs1SKLF1sMVqHc+FrQFEEJ3gRCeluCH
	 qimGB629hc5PReCyJDNzyx41lULOAi6b+pP3H4pSVMEVTcslR8E6USbZyiIhH6dHuu9T5
	 o/gt6mAoEsPe7fYXHi9ihOMl8kNApzzq0CIHchANz01Lsl+H22E27VOFTjjnfudTM0Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795675848;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CgH6+MgNTatJOiFpT/V8tacHwXCdnUWjBLQeXnUgHxw=;
	b=DiqI3N08LO2A8X20mktuV6jgA3C+Tzluswgi+XxfmHwoXJdIc5fszaTYZoNuh7CadnEE
	 aL2xMSSjTcy1aNyY/B5cymofNl7HKUwguZrGexNFPL3Qhx0ztWO665r3dzoOZAC8kTO/+
	 Nq/aC7w7Z6p6jYRMNXQtKQeplXXpklxrfsLspB7hMVeDVYHsXfyAtnozvqVrNuDWpoCK5
	 5p0ODvX/rRwjm1xUy3Rj74SMy3Q3rEsVysGqShDGkF93vDTJWhL36Dm2f3/lW8augRRI4
	 2KM7TQR7yG5iw9+k4Q8w1eoTgMDzAw1TKGk3dRfHJUWiNrXQuwbWcAMVSw8GSxBg7kw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CC81A1F000CA;
	Thu, 26 Nov 2026 06:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675848;
	bh=CgH6+MgNTatJOiFpT/V8tacHwXCdnUWjBLQeXnUgHxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OQH/e8o/nZY1JhltYMghPv6X1YYUmTEmgIPZ3NdEZ36GAA6MjZwk9CPxnjtRJPWcX
	 9aWf2TMjhdU08DpAqHvazj98TNHw+JrP2ts2AnNzkI48+qcqoUmPpvTE+U5h5VYvBs
	 PJcJ5fs30/6vRtlyBHl1VjbtAoep1Z/vjtwo33JgvXvfsCE0sUNhh9g+PvqyVqp5a1
	 zW1PC5m69DMACx8TSxKHEk+TN5+QN7Kcd/tz3xiA9pebKQ/0fzlDx6i88pNk2aed51
	 Qfu2eCNP9hFknhdKDIcEuemy/07ySnhXR6f4TE0Gp5cidZmL1rpvFmOqKnQXJuppSz
	 NvqW6dK45fIAg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 569F34D2AD;
	Thu, 26 Nov 2026 06:50:38 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Thu, 26 Nov 2026 07:50:31 +0100
Subject: [PATCH v2 1/2] ceph: send the cap messages of an inode in the
 order they were prepared
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
Message-Id: <20261126-ceph-append-excl-v2-1-e8707d123d77@clyso.com>
References: <20261126-ceph-append-excl-v2-0-e8707d123d77@clyso.com>
In-Reply-To: <20261126-ceph-append-excl-v2-0-e8707d123d77@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Anthony D'Atri <anthony.datri@gmail.com>, Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795675836; l=5427;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=y3woOdrYDlCWZyslXlQYRQjjWOiA5KFxuYSJ/ghk1wc=;
 b=Q601uewoxsAbRx4eXPEUDSQKfbz/JPWruB1QFnCxElbBREOvI4PLtHq0qWsuJO2RYkEGxtIke
 bAXBpJNRwSyAbnbOf5bar0bgpgTuDM0V8fAGHZnYiI7BY3vQT+FL4nL
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


