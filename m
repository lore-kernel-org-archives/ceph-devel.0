Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802DB3E3DB1
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jul 2026 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543333; cv=none; b=QB58JA+3UFeOWx2XfPfH1ePy4RJNjFIXAU2hULW2ynRJUXrdXJTzMkNv/Bvafw1u0kxwkpJGFg4q8hCYhhxGNS7nP1crhkn9DR6jDVcqOCcVAb7HYP1Zfn9ow6IbBcoUbK/+lgLm5ce3wb/JSQQS+EaSaNEbJAJayVKBTu/F4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543333; c=relaxed/simple;
	bh=G8gl+N2X7ZPSk4gcCDrdn5g4yuvBE5M1Z7SnFwJ/jkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqmYVGclxq9a/jroYXQiU3PqwS8tu9Dp6g7Zn5zORi4rJORPThLdDhlnYfwqt3wQBD6KigUd2vj1EZZ8qYYlFGmFeL4GGD+mYJbmuptpXZPtsbphWagBw8bVD4gvWmaSWcZoUysySC1qmN6dCDSQuau2KEtykdNLFzCkxaXpDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=X1rCtkxf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="X1rCtkxf"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so1893765e9.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 Jul 2026 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783543328; x=1784148128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wHj6NL6CO+zM2abA8DzJxqrh6c3G8Xqm0sNj5b9NoYo=;
        b=X1rCtkxfl6JPvbPgX2ZE8lUN7ZCfxO7t2A4t75u5JCxCnaUyJ3jAVpAx8r+KlLIAB9
         WDgNUPmseM/eNIcPlk2e1ycnxPFxgJqO3oRcKgrwDVhqEVcpgVrOYlHz1chSEtgtPMeC
         XFkDJVcdPfTkAK/RPg48YFF61Iz8EfQeEwvFf/vBEL7UbnpSd0C/fBFSm7EQiDC2Uc/g
         Q56YPyZ3dO6tVUyRa7Hc3Z7tD5CW3XId1t8vjuW+YxSOffzQzDzRLptlbae0Se1WZms9
         gIarb4pvV6SFokl7HMOPdLUyVe4JNEhDnwe7Q5qBbzrgzKbIIqeydRdnpggFB3GCInpz
         d4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783543328; x=1784148128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wHj6NL6CO+zM2abA8DzJxqrh6c3G8Xqm0sNj5b9NoYo=;
        b=h5btOOptYUESgZaQ3THMtEknBQmJii5hEEv15j6kiAYHtCdwuDSRXPkoeMyVcQc82D
         b7hFXeh7/QB7ikeQHaHJcwL9cXJJptkSnKNq/2HhVADD1dc5l1Q+acR85fhublP7y+bR
         nOT5BH65+wVcohFYVo5v+aU8/+n2QNRw8QPsd6T8fTsuUiMVwd2r1FG8bS0jZvMZr5FO
         mdPmPG1FiBXQh8GztDnQvnNtLfmsk63IdYlyhJk0BKRFyiKDdEBjVIyJ8oq12llSP/Nh
         c8Gu1uowkr8/ektCBWjGiTL9tZB6vu9hYE1TPhtiDrD19CqgZjPVbpofvhJWD/v3qgG5
         BusA==
X-Forwarded-Encrypted: i=1; AHgh+RpFNkjsFOOgZYhMQbf1/UqcgUSQpBhKr5Mee+BEWNTPJLbtXPUYxbN5RBONSH2EE7FwrzrPB2yFrMH7@vger.kernel.org
X-Gm-Message-State: AOJu0YzWqVVChzKkH2KjXCQAxygYRarchbU5S4fHrU9ymsnS6+parRkB
	ZCRzkP5V37hXAEtVpeIFA4SRrDoALQuC6EmJukZORgT+DHYDBumTS2ie8DxKc4gPQrg=
X-Gm-Gg: AfdE7ckTcK3d2qvJXF24SXQcO81QVl6H0mqc0d/phSIEs+MEgq3GEYCAJKFAfjzZtxK
	Ym8spMMTeSh9aOAALLCmts2alOGeCloGzdkKO6k69KGbqYMJv09gzm0Nxkl5/LySm7VYwy2pqle
	CmY3gzJWbuhYw8abeJEHYJS+TN5GUdtvucRVgLACpGPXP6+kVEYfpuIGwtNakcLDxYqLjn2vems
	RGvJkZb8AdqTKsAJNaASzliG6zpWAFbUMCTK9dm7O1ag+YvsLYDABQQ0CMrBmkilBVfNbGfVBli
	ZBpJEtx+SzSPH4yZVnmT9k93YZHkof3xFKSx8uFvCqSoEHXTwGljwHEL4rd9F4J6ajlBbizOObW
	4DKtU0nz+SoLspg1FQEv5p6ht75ugim7V4lt32rfwyXQLJoQ9iFvUtLzejIB0veiZPgpCOpNP9g
	aoOMU7qn/08AcU+OYSd+MbMLM1FGTsY0uzFF8SX1VUJs/kr5wVdR0nG7HPeI+vGXDj2NdDypdSB
	K1+ULe6ycXHKOiG9Blr2MwWGB8=
X-Received: by 2002:a05:600c:34ce:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-493e1008fb8mr97443435e9.1.1783543327801;
        Wed, 08 Jul 2026 13:42:07 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm44682306f8f.14.2026.07.08.13.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 13:42:07 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fd/ceph/mds_client: add per-request lock for completion
Date: Wed,  8 Jul 2026 22:42:04 +0200
Message-ID: <20260708204204.264138-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_mdsc_wait_request() took `ceph_mds_client.mutex` only to resolve
a request's terminal state after the wait returned: either a reply had
arrived and handle_reply() had set `r_reply`/`CEPH_MDS_R_GOT_RESULT`,
or there was an error and the waiter had to abort the request by
setting `r_err`/`CEPH_MDS_R_ABORTED` so a late reply is discarded.  It
never touched any `ceph_mds_client` fields; it used the big mutex
purely as the serialization point against the matching section at the
tail of handle_reply(), and (indirectly) against __do_request() and
handle_forward().

`ceph_mds_client.mutex` is a coarse lock, also covering the request
tree, tid counters, the session table and the mdsmap.  Making the
waiter take it means request completion contends with request
submission (ceph_mdsc_submit_request() holds it across
__register_request() and __do_request()) even though the two only
share a handful of per-request fields.

This patch adds a per-request spinlock that guards a request's
terminal state: `r_err`, `r_reply`, `CEPH_MDS_R_GOT_RESULT` and
`CEPH_MDS_R_ABORTED`.

Lock ordering is `ceph_mds_client.mutex`, `r_fill_mutex`,
`r_completion_lock`; the spinlock is always innermost and no sleeping
lock is taken while it is held.

The two BUG_ON()s in handle_forward()'s resend branch are removed.
They asserted that a request being resent had neither errored nor
completed, an invariant that held only because the client mutex
serialized the resend against the waiter's abort.  Now that the waiter
aborts under `r_completion_lock` without the client mutex, a forward
can race an abort; this is harmless because __do_request() re-checks
the terminal state under `r_completion_lock` and unregisters the
request instead of resending it.

This weakens one invariant: previously, the abort path held
`ceph_mds_client.mutex`, so it was mutually exclusive with
__do_request() and a request could never be sent once
`CEPH_MDS_R_ABORTED` was set.  With the abort now protected only by
`r_completion_lock`, the bit can be set concurrently with a
resend-path __do_request() (kick_requests(), __wake_requests(),
handle_forward()) after that function's one-time entry check, so an
aborted request may still be sent or queued.  This is harmless:
`ABORTED` is re-checked at every consumer: handle_reply() discards the
reply, ceph_fill_trace() skips the dcache work that depends on locks
held by the (now returned) caller, and the next __do_request()
unregisters it.  This matches the existing property that an
interrupted request may still execute on the MDS.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/locks.c      | 21 ++++++----
 fs/ceph/mds_client.c | 99 ++++++++++++++++++++++++++++++++++----------
 fs/ceph/mds_client.h | 10 +++++
 3 files changed, 102 insertions(+), 28 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 677221bd64e0..35cadcd7cb2a 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -177,25 +177,32 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 
 	doutc(cl, "request %llu was interrupted\n", req->r_tid);
 
+	/*
+	 * mdsc->mutex guards the r_session check below.  The terminal-state
+	 * arbitration against a concurrent reply/forward handler is done under
+	 * r_completion_lock (the same lock ceph_mdsc_wait_request() uses),
+	 * since those handlers no longer serialize on mdsc->mutex.
+	 * r_fill_mutex additionally fences ceph_fill_trace() /
+	 * ceph_readdir_prepopulate(), which consult CEPH_MDS_R_ABORTED while
+	 * relying on locks (dir mutex) held by our caller.
+	 * Lock ordering: mdsc->mutex -> r_fill_mutex -> r_completion_lock.
+	 */
 	mutex_lock(&mdsc->mutex);
+	mutex_lock(&req->r_fill_mutex);
+	spin_lock(&req->r_completion_lock);
 	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
 		err = 0;
 	} else {
-		/*
-		 * ensure we aren't running concurrently with
-		 * ceph_fill_trace or ceph_readdir_prepopulate, which
-		 * rely on locks (dir mutex) held by our caller.
-		 */
-		mutex_lock(&req->r_fill_mutex);
 		req->r_err = err;
 		set_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags);
-		mutex_unlock(&req->r_fill_mutex);
 
 		if (!req->r_session) {
 			// haven't sent the request
 			err = 0;
 		}
 	}
+	spin_unlock(&req->r_completion_lock);
+	mutex_unlock(&req->r_fill_mutex);
 	mutex_unlock(&mdsc->mutex);
 	if (!err)
 		return 0;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 853bf698b356..824d271e55c9 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2722,6 +2722,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&req->r_fill_mutex);
+	spin_lock_init(&req->r_completion_lock);
 	req->r_mdsc = mdsc;
 	req->r_started = jiffies;
 	req->r_start_latency = ktime_get();
@@ -3528,7 +3529,9 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 	}
 	msg = create_request_message(session, req, drop_cap_releases);
 	if (IS_ERR(msg)) {
+		spin_lock(&req->r_completion_lock);
 		req->r_err = PTR_ERR(msg);
+		spin_unlock(&req->r_completion_lock);
 		return PTR_ERR(msg);
 	}
 	req->r_request = msg;
@@ -3586,9 +3589,34 @@ static void __do_request(struct ceph_mds_client *mdsc,
 	int mds = -1;
 	int err = 0;
 	bool random;
+	bool done, aborted;
 
-	if (req->r_err || test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
-		if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
+	/*
+	 * The request may already have reached its terminal state,
+	 * either because a reply/forward arrived or because
+	 * ceph_mdsc_wait_request() aborted it.  Sample that state
+	 * under r_completion_lock so we agree with those paths, which
+	 * no longer all serialize on mdsc->mutex.
+	 *
+	 * This is only a point-in-time check.  Since the abort path
+	 * does not own mdsc->mutex, CEPH_MDS_R_ABORTED may be set
+	 * concurrently after this snapshot while we go on to choose a
+	 * MDS and send the request, so a request can be sent (or
+	 * queued) after it has been aborted.  That is harmless:
+	 * ABORTED is re-checked at every consumer: handle_reply()
+	 * discards the reply, ceph_fill_trace() skips the work that
+	 * relies on locks held by the (now returned) caller, and the
+	 * next __do_request() sees the flag and unregisters the
+	 * request.  ABORTED is an advisory "stop waiting" flag, not a
+	 * send barrier.
+	 */
+	spin_lock(&req->r_completion_lock);
+	done = req->r_err || test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags);
+	aborted = test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags);
+	spin_unlock(&req->r_completion_lock);
+
+	if (done) {
+		if (aborted)
 			__unregister_request(mdsc, req);
 		return;
 	}
@@ -3742,7 +3770,9 @@ static void __do_request(struct ceph_mds_client *mdsc,
 					  TASK_KILLABLE);
 			if (err) {
 				mutex_lock(&req->r_fill_mutex);
+				spin_lock(&req->r_completion_lock);
 				set_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags);
+				spin_unlock(&req->r_completion_lock);
 				mutex_unlock(&req->r_fill_mutex);
 				goto out_session;
 			}
@@ -3783,7 +3813,9 @@ static void __do_request(struct ceph_mds_client *mdsc,
 finish:
 	if (err) {
 		doutc(cl, "early error %d\n", err);
+		spin_lock(&req->r_completion_lock);
 		req->r_err = err;
+		spin_unlock(&req->r_completion_lock);
 		complete_request(mdsc, req);
 		__unregister_request(mdsc, req);
 	}
@@ -3910,6 +3942,8 @@ int ceph_mdsc_wait_request(struct ceph_mds_client *mdsc,
 			   ceph_mds_request_wait_callback_t wait_func)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	bool aborted = false;
+	bool got_result;
 	int err;
 
 	/* wait */
@@ -3928,32 +3962,47 @@ int ceph_mdsc_wait_request(struct ceph_mds_client *mdsc,
 			err = timeleft;  /* killed */
 	}
 	doutc(cl, "do_request waited, got %d\n", err);
-	mutex_lock(&mdsc->mutex);
-
-	/* only abort if we didn't race with a real reply */
-	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
-		err = le32_to_cpu(req->r_reply_info.head->result);
-	} else if (err < 0) {
-		doutc(cl, "aborted request %lld with %d\n", req->r_tid, err);
 
+	if (err < 0) {
 		/*
-		 * ensure we aren't running concurrently with
-		 * ceph_fill_trace or ceph_readdir_prepopulate, which
-		 * rely on locks (dir mutex) held by our caller.
+		 * Timed out or killed.  A reply may be getting published
+		 * concurrently, so serialize against handle_reply() on
+		 * r_completion_lock before deciding to abort.  r_fill_mutex
+		 * additionally fences ceph_fill_trace()/ceph_readdir_prepopulate(),
+		 * which consult CEPH_MDS_R_ABORTED while relying on locks (dir
+		 * mutex) held by our caller.
 		 */
 		mutex_lock(&req->r_fill_mutex);
-		req->r_err = err;
-		set_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags);
+		spin_lock(&req->r_completion_lock);
+		got_result = test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags);
+		if (!got_result) {
+			req->r_err = err;
+			set_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags);
+			aborted = true;
+		}
+		spin_unlock(&req->r_completion_lock);
 		mutex_unlock(&req->r_fill_mutex);
+	} else {
+		/*
+		 * The wait completed, so complete_all() has run and the terminal
+		 * state stored by handle_reply()/__do_request() before it is
+		 * visible without locking.
+		 */
+		got_result = test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags);
+	}
 
+	if (got_result)
+		err = le32_to_cpu(req->r_reply_info.head->result);
+	else if (!aborted)
+		err = req->r_err;
+
+	if (aborted) {
+		doutc(cl, "aborted request %lld with %d\n", req->r_tid, err);
 		if (req->r_parent &&
 		    (req->r_op & CEPH_MDS_OP_WRITE))
 			ceph_invalidate_dir_request(req);
-	} else {
-		err = req->r_err;
 	}
 
-	mutex_unlock(&mdsc->mutex);
 	return err;
 }
 
@@ -4186,7 +4235,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 		ceph_unreserve_caps(mdsc, &req->r_caps_reservation);
 	}
 out_err:
-	mutex_lock(&mdsc->mutex);
+	spin_lock(&req->r_completion_lock);
 	if (!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
 		if (err) {
 			req->r_err = err;
@@ -4197,7 +4246,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	} else {
 		doutc(cl, "reply arrived after request %lld was aborted\n", tid);
 	}
-	mutex_unlock(&mdsc->mutex);
+	spin_unlock(&req->r_completion_lock);
 
 	mutex_unlock(&session->s_mutex);
 
@@ -4259,8 +4308,10 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 		 * 8 bits.
 		 */
 		mutex_lock(&req->r_fill_mutex);
+		spin_lock(&req->r_completion_lock);
 		req->r_err = -EMULTIHOP;
 		set_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags);
+		spin_unlock(&req->r_completion_lock);
 		mutex_unlock(&req->r_fill_mutex);
 		aborted = true;
 		pr_warn_ratelimited_client(cl, "forward tid %llu seq overflow\n",
@@ -4268,8 +4319,14 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 	} else {
 		/* resend. forward race not possible; mds would drop */
 		doutc(cl, "forward tid %llu to mds%d (we resend)\n", tid, next_mds);
-		BUG_ON(req->r_err);
-		BUG_ON(test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags));
+		/*
+		 * The request had not reached its terminal state when sampled
+		 * above.  It may now race an abort from
+		 * ceph_mdsc_wait_request(), which no longer serializes on
+		 * mdsc->mutex; __do_request() re-checks the terminal state
+		 * under r_completion_lock and unregisters instead of resending
+		 * if that happened, so this is safe.
+		 */
 		req->r_attempts = 0;
 		req->r_num_fwd = fwd_seq;
 		req->r_resend_mds = next_mds;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 731d6ad04956..449b5e28b2de 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -394,6 +394,16 @@ struct ceph_mds_request {
 	struct ceph_msg  *r_reply;
 	struct ceph_mds_reply_info_parsed r_reply_info;
 	int r_err;
+
+	/*
+	 * Serializes the request's terminal state (r_err, r_reply,
+	 * CEPH_MDS_R_GOT_RESULT and CEPH_MDS_R_ABORTED) between the reply and
+	 * forward handlers, __do_request() and ceph_mdsc_wait_request().
+	 *
+	 * Lock ordering: mdsc->mutex -> r_fill_mutex -> r_completion_lock.
+	 */
+	spinlock_t r_completion_lock;
+
 	u32               r_readdir_offset;
 
 	struct page *r_locked_page;
-- 
2.47.3

