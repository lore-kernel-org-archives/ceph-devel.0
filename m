Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795158680;
	b=a6jvTnV6DmVFz26CAKeDOk7JB4MRSphFWsxq9THhjGJLDCr1S5C103wmL+mTK3ytLueR
	 NV5fx9xsab6Vj3KKTPMDVxxeKlQL4VI5vIV7lYjPi0GdrQRGcZkcF+pfqr3jrZAYr0bUi
	 WswFkLYPTacH68Lz+p+EnA+cNNHG+ydK76guJpxOh/O27w5nx73O6ECAa2tjAcEoTnsfa
	 +9MV7Q8U5KaohYqqXUtco4rgrCorF9F3OHPab5ulFWCtoi4jmVvbKQJvP9bNdRl7LiF+w
	 navGIKS8SOL0zbLBl0y5KkSNsBHjIvWaLyl4vWdon7lmoBsmQyP7wgku8CU0dBwimdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158680;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=utCwhodg5xFMHYKAzMuBmbGu+jVq2YBIw6k6+4dlJHU=;
	b=jte2gqrZ4bQd5zHzNkahxSc+/0GMbEDw1R8nqQXriTs7ldAHpDuaAv4vKpQsRDQW4I4K
	 IWcgD7qn+zTEtl+FiDhnb3IgeEF2ZAio2SqrNsH5D+MZq+NOGBNrL81jlF3Mh/+0guHQg
	 RW0qtk6bYicmIDkQWjtgST5IvN0PzHSd4BzOwdc6/MX4jedbKqiT4/nF3flp4yTDY9UL1
	 ZJ3lGZTB2B6fE8gkrDxWvsmjWe1l1n3BA44fcJIsHJatruAkvYcrzQpFDwH8BjPGv17MA
	 RHU79RRO62Fly45XYZFJ6G12o0+l++iePUKDnhHPOAx3pNmw/bJ78RYqtcK3QlGwx2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnRoM3bg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4960A261A;
	Fri, 20 Nov 2026 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnRoM3bg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795158680;
	b=ZlxSTe89faj2JeqaThGGUAoVezy6SuMd7c/P49zM/QeuXVtSeBjeHkkB1xcIdBfPVMti
	 ok/H88OqhQrpNFLEg5MfYZYGzPUmwzCA45HwnfWAR+NotPsCb2xZQrEjHucufENf/taoG
	 wZU6ezkyZzYGyDc+lB37btYcIWdWx4YAs5UQ0C8kEc3SSKwYGaMtA5F2+ous4UnZuyRbr
	 CJ9cdAoYvVf9Tc+ybVQ/MPMDxV1C10AGEM7q42xCai2BhTCo7BOtwFULuv+7ZWv/5T4Vz
	 exXZJgJXj928SOPx8UH4VXycnqf0UYJRBtbUPznhcPGXu58z9VczzzZxa4/yXCtqxWA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795158680;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=utCwhodg5xFMHYKAzMuBmbGu+jVq2YBIw6k6+4dlJHU=;
	b=X0ybuxl3aHiYEZGCEIZi2ApG9so6AjqOl/qTB8Insn/4i8b9EMiAGUrnt/vAlbFk1b30
	 h7Tb78dKq7mfwQN3Bjkld0gL5JpawAHBotyLoQjuj7Zn9gV6//d2RGBZjMe2ohcG79DxM
	 mIyfsGcGGCJRIHkqOkRqdrpOAbJ4PvPhbjpF2ZH1l4O2d/tmnridsENL9aOSTatAIeVMs
	 nSEWHI6AmY7P6Vhe9K+O6DTUHk3Za4UWf2vEgoc4+25O9pccOFVwSwAOJhCyJdI2KwcIB
	 tdzdst3wOQ+xh1cDOVNJG5Yr5trHiBRPlYwlzy8NwXeKQy/H3Rp5NrHzNICk6zvk1uA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2137C1F000E0;
	Fri, 20 Nov 2026 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795158680;
	bh=utCwhodg5xFMHYKAzMuBmbGu+jVq2YBIw6k6+4dlJHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FnRoM3bg2MLSBk1SN1qTAgE5OVsZV//8sdy4gSPNc4af73vskWCztWcPuRNjj5jjX
	 4bSyCmNQAfxuYlHFtxGppmgFcpWD181U7JEO1Y4CclVKjjF9p06h164wKs4VjCkbMK
	 PbIyCcEL0cgm4U2jN5tmCbcBQ0wu6EZo4wqV16Q/+XvxVH61FvrJJC4q/nwV7bi4i7
	 3KqFqA2N15dFNOfiAcZVvEGKk33wJHMaKM/9VCofkf2TwsCNhMjNHYRyspWDtBEi9u
	 RT/1Dmfe3io03vBoabX1wF9hG0tOml5JlsiCkqsuWuDYKG7EDkgui17ypUgYraP3gl
	 e3Hjgx5UXP4Pw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9DF904974F;
	Fri, 20 Nov 2026 07:11:17 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 20 Nov 2026 09:11:12 +0200
Subject: [PATCH v7 4/5] ceph: move mdsc->mutex into __do_request()
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
Message-Id: <20261120-ceph-mdsc-mutex-optimization-v7-4-a4eee70e0038@clyso.com>
References: <20261120-ceph-mdsc-mutex-optimization-v7-0-a4eee70e0038@clyso.com>
In-Reply-To: <20261120-ceph-mdsc-mutex-optimization-v7-0-a4eee70e0038@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795158674; l=14370;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=jOiiqm1GWSWzeMvLC9FlXH0n3DdiaHPP+E/KEWtGE28=;
 b=pUEK/WIqdHBYsBGI0xege/vAkwd5llns1hoQsSB7T7ihQ+KG6KD5Hhd7XbsrxlQ9MdpFQxu08
 TEEXX1tuPpfDWzsTtnpUQI4hvN/eFlspEIC90C7rlwjfNlku1e5zv+I
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubo.li@clyso.com>

Currently every caller must hold mdsc->mutex when invoking the
request-send machinery.  Move the mutex acquisition inside
__do_request() so that callers can fire off a request without
first serializing on the global lock.  The mutex is released
before the network send phase and re-acquired only for cleanup,
so dentry traversal and message construction run concurrently
across CPUs.

This is the primary source of the observed 2x stat throughput
improvement: the per-request send path shrinks from hundreds of
microseconds to tens of microseconds once it no longer waits on
the mutex.  Wait-list draining, session-state wake-ups, and
request kicking are reworked to either use the new wait-list
spinlock or collect candidates under the mutex and process them
outside it.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/mds_client.c | 121 +++++++++++++++++++++++++++++++++++----------------
 fs/ceph/mds_client.h |   1 +
 2 files changed, 85 insertions(+), 37 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5983ae6e3085..6d4182cfa70a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2813,6 +2813,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	init_completion(&req->r_completion);
 	init_completion(&req->r_safe_completion);
 	INIT_LIST_HEAD(&req->r_unsafe_item);
+	INIT_LIST_HEAD(&req->r_aux_item);
 
 	ktime_get_coarse_real_ts64(&req->r_stamp);
 
@@ -3532,20 +3533,23 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 	 * Avoid infinite retrying after overflow. The client will
 	 * increase the retry count and if the MDS is old version,
 	 * so we limit to retry at most 256 times.
+	 *
+	 * r_attempts was already incremented under mdsc->mutex by the
+	 * caller (__do_request or replay_unsafe_requests), so the
+	 * actual retry count is r_attempts - 1 and we skip the check
+	 * on the first dispatch (r_attempts == 1).
 	 */
-	if (req->r_attempts) {
-	       old_max_retry = sizeof_field(struct ceph_mds_request_head,
-					    num_retry);
-	       old_max_retry = 1 << (old_max_retry * BITS_PER_BYTE);
-	       if ((old_version && req->r_attempts >= old_max_retry) ||
-		   ((uint32_t)req->r_attempts >= U32_MAX)) {
+	if (req->r_attempts > 1) {
+		old_max_retry = sizeof_field(struct ceph_mds_request_head,
+					     num_retry);
+		old_max_retry = 1 << (old_max_retry * BITS_PER_BYTE);
+		if ((old_version && (req->r_attempts - 1) >= old_max_retry) ||
+		    ((uint32_t)(req->r_attempts - 1) >= U32_MAX)) {
 			pr_warn_ratelimited_client(cl, "request tid %llu seq overflow\n",
 						   req->r_tid);
 			return -EMULTIHOP;
-	       }
+		}
 	}
-
-	req->r_attempts++;
 	if (req->r_inode) {
 		struct ceph_cap *cap =
 			ceph_get_cap_for_mds(ceph_inode(req->r_inode), mds);
@@ -3657,9 +3661,36 @@ static void __do_request(struct ceph_mds_client *mdsc,
 	int err = 0;
 	bool random;
 
+	mutex_lock(&mdsc->mutex);
+
+	/*
+	 * r_attempts is bumped under mdsc->mutex just before the mutex
+	 * is dropped to send the request, and it is only ever written
+	 * back to 0 by the forward handler or cleanup_session_requests()
+	 * (both under the mutex) before re-dispatching through a new
+	 * __do_request() call.  Consequently, r_attempts > 0 at this
+	 * point always means another __do_request() instance has already
+	 * passed the point of no return for this request, i.e. a racing
+	 * kick_requests() or __wake_requests() picked up the same
+	 * request from the xarray or a wait list and is about to send
+	 * it.  Bail out to prevent a double dispatch.
+	 *
+	 * Note: kick_requests() also filters on r_attempts > 0 during
+	 * its collection pass, but that is a one-time snapshot taken
+	 * under the mutex.  Between that snapshot and the actual
+	 * __do_request() call the mutex is dropped and re-acquired, so
+	 * the protection is not atomic — this per-request gate closes
+	 * the remaining window.
+	 */
+	if (req->r_attempts > 0) {
+		mutex_unlock(&mdsc->mutex);
+		return;
+	}
+
 	if (req->r_err || test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
 		if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
 			__unregister_request(mdsc, req);
+		mutex_unlock(&mdsc->mutex);
 		return;
 	}
 
@@ -3692,6 +3723,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 			spin_lock(&mdsc->wait_list_lock);
 			list_add(&req->r_wait, &mdsc->waiting_for_map);
 			spin_unlock(&mdsc->wait_list_lock);
+			mutex_unlock(&mdsc->mutex);
 			return;
 		}
 		if (!(mdsc->fsc->mount_options->flags &
@@ -3717,6 +3749,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 		spin_lock(&mdsc->wait_list_lock);
 		list_add(&req->r_wait, &mdsc->waiting_for_map);
 		spin_unlock(&mdsc->wait_list_lock);
+		mutex_unlock(&mdsc->mutex);
 		return;
 	}
 
@@ -3790,6 +3823,9 @@ static void __do_request(struct ceph_mds_client *mdsc,
 		goto out_session;
 	}
 
+	req->r_attempts++;
+	mutex_unlock(&mdsc->mutex);
+
 	/* send request */
 	req->r_resend_mds = -1;   /* forget any previous mds hint */
 
@@ -3820,6 +3856,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 			err = wait_on_bit(&di->flags, CEPH_DENTRY_ASYNC_CREATE_BIT,
 					  TASK_KILLABLE);
 			if (err) {
+				mutex_lock(&mdsc->mutex);
 				mutex_lock(&req->r_fill_mutex);
 				set_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags);
 				mutex_unlock(&req->r_fill_mutex);
@@ -3857,6 +3894,8 @@ static void __do_request(struct ceph_mds_client *mdsc,
 
 	err = __send_request(session, req, false);
 
+	mutex_lock(&mdsc->mutex);
+
 out_session:
 	ceph_put_mds_session(session);
 finish:
@@ -3866,12 +3905,10 @@ static void __do_request(struct ceph_mds_client *mdsc,
 		complete_request(mdsc, req);
 		__unregister_request(mdsc, req);
 	}
+	mutex_unlock(&mdsc->mutex);
 	return;
 }
 
-/*
- * called under mdsc->mutex
- */
 static void __wake_requests(struct ceph_mds_client *mdsc,
 			    struct list_head *head)
 {
@@ -3901,10 +3938,14 @@ static void __wake_requests(struct ceph_mds_client *mdsc,
 static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
-	struct ceph_mds_request *req;
+	struct ceph_mds_request *req, *nreq;
 	unsigned long idx;
+	LIST_HEAD(kick_list);
 
 	doutc(cl, "kick_requests mds%d\n", mds);
+
+	/* collect matching requests under the mutex */
+	mutex_lock(&mdsc->mutex);
 	idx = 0;
 	xa_for_each(&mdsc->request_tree, idx, req) {
 		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags))
@@ -3913,14 +3954,23 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 			continue; /* only new requests */
 		if (req->r_session &&
 		    req->r_session->s_mds == mds) {
-			doutc(cl, " kicking tid %llu\n", req->r_tid);
+			ceph_mdsc_get_request(req);
 			spin_lock(&mdsc->wait_list_lock);
 			list_del_init(&req->r_wait);
 			spin_unlock(&mdsc->wait_list_lock);
-			trace_ceph_mdsc_resume_request(mdsc, req);
-			__do_request(mdsc, req);
+			list_add_tail(&req->r_aux_item, &kick_list);
 		}
 	}
+	mutex_unlock(&mdsc->mutex);
+
+	/* replay without the mutex */
+	list_for_each_entry_safe(req, nreq, &kick_list, r_aux_item) {
+		doutc(cl, " kicking tid %llu\n", req->r_tid);
+		trace_ceph_mdsc_resume_request(mdsc, req);
+		list_del_init(&req->r_aux_item);
+		__do_request(mdsc, req);
+		ceph_mdsc_put_request(req);
+	}
 }
 
 int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
@@ -3980,10 +4030,11 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 	doutc(cl, "submit_request on %p for inode %p\n", req, dir);
 	mutex_lock(&mdsc->mutex);
 	__register_request(mdsc, req, dir);
+	mutex_unlock(&mdsc->mutex);
+
 	trace_ceph_mdsc_submit_request(mdsc, req);
 	__do_request(mdsc, req);
 	err = req->r_err;
-	mutex_unlock(&mdsc->mutex);
 	return err;
 }
 
@@ -4372,13 +4423,14 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 		req->r_num_fwd = fwd_seq;
 		req->r_resend_mds = next_mds;
 		put_request_session(req);
-		__do_request(mdsc, req);
 	}
 	mutex_unlock(&mdsc->mutex);
 
 	/* kick calling process */
 	if (aborted)
 		complete_request(mdsc, req);
+	else if (!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
+		__do_request(mdsc, req);
 	ceph_mdsc_put_request(req);
 	return;
 
@@ -4706,11 +4758,9 @@ static void handle_session(struct ceph_mds_session *session,
 
 	mutex_unlock(&session->s_mutex);
 	if (wake) {
-		mutex_lock(&mdsc->mutex);
 		__wake_requests(mdsc, &session->s_waiting);
 		if (wake == 2)
 			kick_requests(mdsc, mds);
-		mutex_unlock(&mdsc->mutex);
 	}
 	if (op == CEPH_SESSION_CLOSE)
 		ceph_put_mds_session(session);
@@ -4766,8 +4816,10 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 	doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
 
 	mutex_lock(&mdsc->mutex);
-	list_for_each_entry_safe(req, nreq, &session->s_unsafe, r_unsafe_item)
+	list_for_each_entry_safe(req, nreq, &session->s_unsafe, r_unsafe_item) {
+		req->r_attempts++;
 		__send_request(session, req, true);
+	}
 
 	/*
 	 * also re-send old requests when MDS enters reconnect stage. So that MDS
@@ -4786,6 +4838,7 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 
 		ceph_mdsc_release_dir_caps_async(req);
 
+		req->r_attempts++;
 		__send_request(session, req, true);
 	}
 	mutex_unlock(&mdsc->mutex);
@@ -5346,9 +5399,7 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
 
 	mutex_unlock(&session->s_mutex);
 
-	mutex_lock(&mdsc->mutex);
 	__wake_requests(mdsc, &session->s_waiting);
-	mutex_unlock(&mdsc->mutex);
 
 	up_read(&mdsc->snap_rwsem);
 	ceph_pagelist_release(recon_state.pagelist);
@@ -5773,8 +5824,8 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 		}
 		sessions[i]->s_state = CEPH_MDS_SESSION_CLOSED;
 		__unregister_session(mdsc, sessions[i]);
-		__wake_requests(mdsc, &sessions[i]->s_waiting);
 		mutex_unlock(&mdsc->mutex);
+		__wake_requests(mdsc, &sessions[i]->s_waiting);
 
 		mutex_lock(&sessions[i]->s_mutex);
 		cleanup_session_requests(mdsc, sessions[i]);
@@ -5785,9 +5836,7 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 
 		ceph_put_mds_session(sessions[i]);
 
-		mutex_lock(&mdsc->mutex);
 		kick_requests(mdsc, mds);
-		mutex_unlock(&mdsc->mutex);
 
 		torn_down++;
 		pr_info_client(cl, "mds%d session reset complete\n", mds);
@@ -5903,8 +5952,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 			/* force close session for stopped mds */
 			ceph_get_mds_session(s);
 			__unregister_session(mdsc, s);
-			__wake_requests(mdsc, &s->s_waiting);
 			mutex_unlock(&mdsc->mutex);
+			__wake_requests(mdsc, &s->s_waiting);
 
 			mutex_lock(&s->s_mutex);
 			cleanup_session_requests(mdsc, s);
@@ -5913,8 +5962,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 
 			ceph_put_mds_session(s);
 
-			mutex_lock(&mdsc->mutex);
 			kick_requests(mdsc, i);
+			mutex_lock(&mdsc->mutex);
 			continue;
 		}
 
@@ -5962,9 +6011,9 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 			    oldstate != CEPH_MDS_STATE_STARTING)
 				pr_info_client(cl, "mds%d recovery completed\n",
 					       s->s_mds);
-			kick_requests(mdsc, i);
 			ceph_get_mds_session(s);
 			mutex_unlock(&mdsc->mutex);
+			kick_requests(mdsc, i);
 			mutex_lock(&s->s_mutex);
 			mutex_lock(&mdsc->mutex);
 			ceph_put_mds_session(s);
@@ -6877,8 +6926,8 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
 
 		if (session->s_state == CEPH_MDS_SESSION_REJECTED)
 			__unregister_session(mdsc, session);
-		__wake_requests(mdsc, &session->s_waiting);
 		mutex_unlock(&mdsc->mutex);
+		__wake_requests(mdsc, &session->s_waiting);
 
 		mutex_lock(&session->s_mutex);
 		__close_session(mdsc, session);
@@ -6889,11 +6938,11 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
 		mutex_unlock(&session->s_mutex);
 		ceph_put_mds_session(session);
 
-		mutex_lock(&mdsc->mutex);
 		kick_requests(mdsc, mds);
+		mutex_lock(&mdsc->mutex);
 	}
-	__wake_requests(mdsc, &mdsc->waiting_for_map);
 	mutex_unlock(&mdsc->mutex);
+	__wake_requests(mdsc, &mdsc->waiting_for_map);
 }
 
 static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
@@ -7035,8 +7084,8 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 err_out:
 	mutex_lock(&mdsc->mutex);
 	mdsc->mdsmap_err = err;
-	__wake_requests(mdsc, &mdsc->waiting_for_map);
 	mutex_unlock(&mdsc->mutex);
+	__wake_requests(mdsc, &mdsc->waiting_for_map);
 }
 
 /*
@@ -7087,11 +7136,11 @@ void ceph_mdsc_handle_mdsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	mdsc->fsc->max_file_size = min((loff_t)mdsc->mdsmap->m_max_file_size,
 					MAX_LFS_FILESIZE);
 
+	mutex_unlock(&mdsc->mutex);
 	__wake_requests(mdsc, &mdsc->waiting_for_map);
 	ceph_monc_got_map(&mdsc->fsc->client->monc, CEPH_SUB_MDSMAP,
 			  mdsc->mdsmap->m_epoch);
 
-	mutex_unlock(&mdsc->mutex);
 	schedule_delayed(mdsc, 0);
 	return;
 
@@ -7189,8 +7238,8 @@ static void mds_peer_reset(struct ceph_connection *con)
 		ceph_get_mds_session(s);
 		s->s_state = CEPH_MDS_SESSION_CLOSED;
 		__unregister_session(mdsc, s);
-		__wake_requests(mdsc, &s->s_waiting);
 		mutex_unlock(&mdsc->mutex);
+		__wake_requests(mdsc, &s->s_waiting);
 
 		mutex_lock(&s->s_mutex);
 		cleanup_session_requests(mdsc, s);
@@ -7199,9 +7248,7 @@ static void mds_peer_reset(struct ceph_connection *con)
 
 		wake_up_all(&mdsc->session_close_wq);
 
-		mutex_lock(&mdsc->mutex);
 		kick_requests(mdsc, s->s_mds);
-		mutex_unlock(&mdsc->mutex);
 
 		ceph_put_mds_session(s);
 		break;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0ea144ba4c7d..11059678284d 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -428,6 +428,7 @@ struct ceph_mds_request {
 	struct completion r_safe_completion;
 	ceph_mds_request_callback_t r_callback;
 	struct list_head  r_unsafe_item;  /* per-session unsafe list item */
+	struct list_head  r_aux_item;     /* auxiliary local list item */
 
 	long long	  r_dir_release_cnt;
 	long long	  r_dir_ordered_cnt;

-- 
2.53.0


