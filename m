Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B473F8809
	for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621876; cv=none; b=BhwJgtm1BEkfk/kCfFA8jwDXTh/cCN8k0WRk5u7+Ok04jVpUOVvoW4DY3fxO1V+ffymgtRlnn6wucLFBMtxHBSRpdDIhP8BZYF1suft4s28SOJDPerGwA6OW8yfrKVXdgIHf8Ol6zGvECZVB9T1b2J5afFQrQ7ilLE7pf4PyuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621876; c=relaxed/simple;
	bh=YzJj1kRODZdqEMW65AmnXNJ1Q9V7dtomvQNu1f7V3GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVYiRYOpxk+PUbs3Tkzp5dY2iHgik4nYrZtzsrGDFNIBKHM0MyA6NF2dgrMRat5HyxKwntFfDsqdVy6oUYFLtfPads/hPAMBYSAhL/iGV54G45B2CNEB+FSxOauniVmgOxwjAnAXLTOFJwaEHLTC7vxo/1rd3A6bpiJCJOt1Hoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGIMAxmf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NELioDlx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGIMAxmf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NELioDlx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774621873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBwY5uAGOou+cwTX8/MYnWNnvP6janGxXKClPFAGceg=;
	b=TGIMAxmfKhEEvZNNtU3FdJK14eCR5AhItZimnvWUIjJUDu3KWYtqitXsR3o0/QXx1cRZZi
	LYRaLeDE30S5tW40KnR63Vrl7XdgiraO08wSo3JYJ3z9Z9HHf7tOgNLed/Y1MYovdVATgN
	6l5Xo5Rd2cays4g8d/8d3lDi907nTRQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-QXkfaZilNo6GX9sOldezZg-1; Fri, 27 Mar 2026 10:31:08 -0400
X-MC-Unique: QXkfaZilNo6GX9sOldezZg-1
X-Mimecast-MFC-AGG-ID: QXkfaZilNo6GX9sOldezZg_1774621868
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd827a356aso518214985a.3
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774621868; x=1775226668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBwY5uAGOou+cwTX8/MYnWNnvP6janGxXKClPFAGceg=;
        b=NELioDlxd7NiJ8xAPNrIVk8J98srnv5tVmOKZrdIaQxnVz6OWbQNy5HbA2iPDV5lkw
         uEuHxG/v1qm6ZPLRAI7nBMFRCAFZS+e224ZtIayo0m8nBe3sCu6h91fmrE95BbWRtwNI
         U3DTjdDw34hFAa2tCCPfbeTQY00wjd2SqFZYHqvSHP76mmzy1h2oqcfiJgHc3YwUPEcp
         bXtqRV3kOrBSqgvn8QkzmqoMeQ/JkQEZDiJO1LX5YwgXjJM14n4zs74JC5KrErMNQY4C
         1LbYCjdN+1ixLA9iCeNOkc5J8eUL4sXAhPsLR0/jGc6ATXrKbdpCfFUlkCEw8/wlBNBi
         4GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621868; x=1775226668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rBwY5uAGOou+cwTX8/MYnWNnvP6janGxXKClPFAGceg=;
        b=NEeREgwebk5Q5k0YLpEiVU+XAQA8r9EA8qsZcd8bh8fciyZJms93Dn/YWBvr2e2SdD
         khsRINNKENPw7o9irVNHvrXglmARCFdDcBTL10wvEa5HpVv8GQRE65PWSYR+w4JH4lQ9
         fmNmuJCF9C4lETB+fI94y5/+RPxismPEruY5IL5WT4z2te13PflaXNVBIyTQKkeMo/Vk
         E7lLI31ekmuqr8n7fqCgnIRy8aa6dXl8HTgTuGHvDwYym6dpvgMd+/O4EdBg6Wtl8Uzh
         yYgitLEH/2twP5jr0ZHpAo8vzprw1Y7RL1OXLw+tADupKg/9gf3zRgtDNbjr9R9tC1/n
         tvNQ==
X-Gm-Message-State: AOJu0YyerJg97tbC6a0pZhg5TaAh2Gw57bYKsVL3q1FC8Ig2ymDsDfVU
	WHpvAkq53+BEFznYDYOBx0zdLnwQQhww8zyWmr/iqdYbMIKp6RSrdPZ5ZonBvuyF3nSk/URj0LU
	11iySO/TYz9+AT4pws/SzoQw2yKPsPMUTXGvzQZzcSOaA2EV19lUkbJYAVfVNNcjRwh+eRzgkdM
	ue2klGxBjZy5cCjAl5urq2GVvgQUpe7HdPEngTmkvfC+PTEWaIew==
X-Gm-Gg: ATEYQzxSl0XFpSk5ezZwED9c9EGNAnQUPMco5mCqLqrqjf2pUelRJjDikCqZ+RftSgc
	RF2BazM/kga2hp61YrYqxA865s5Yn8aifd3dS+Pu6pCoB4J39FWHjcbM6llgBtxXTNOdu2mpSws
	YOnoUxHOVXxrtcWZDRBvYqjINv51mG5gnlNfXVgzKfjED/h1nc3AYgagBBnf/2J9lRCGKqHanlZ
	lpLII8Lk3TiWA9Ow+A/v1ZB2hGo55DBI4gQCw56Vl0BiderYSIZk2yxtygnVo1U7d+E14gTpCVT
	40Zvbsw8LjojC4SfkKItT9ooeYpUN6J7TOj4ohWmQuIah0hPUTgtbNSO6CePs0KCKU6MKne0LS9
	AnDW4ceamy7ka5mY/1Tdwlj5rzRxCRu4PoPadGxoIysUeNTEwyaVgKlc=
X-Received: by 2002:a05:620a:2991:b0:8cf:cfdf:733e with SMTP id af79cd13be357-8d01c689577mr315648285a.32.1774621867485;
        Fri, 27 Mar 2026 07:31:07 -0700 (PDT)
X-Received: by 2002:a05:620a:2991:b0:8cf:cfdf:733e with SMTP id af79cd13be357-8d01c689577mr315632385a.32.1774621865074;
        Fri, 27 Mar 2026 07:31:05 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm515168585a.36.2026.03.27.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:31:04 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 07/10] ceph: add reset state machine, drain phase, and status reporting
Date: Fri, 27 Mar 2026 14:30:43 +0000
Message-Id: <20260327143045.1393612-8-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327143045.1393612-1-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track manual reset progress with explicit phases so blocked callers and
debugfs status can distinguish quiescing, draining, and teardown. Add a
bounded best-effort drain window before session teardown and report the
outcome so operators can see whether dirty state drained or had to be
dropped.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/debugfs.c    |  14 ++++--
 fs/ceph/mds_client.c | 116 ++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/mds_client.h |  16 ++++--
 3 files changed, 127 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 9e2c32fb1f38..88969dc5dde5 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -374,8 +374,10 @@ static int reset_status_show(struct seq_file *s, void *p)
 	u64 trigger = 0, success = 0, failure = 0;
 	unsigned long last_start = 0, last_finish = 0;
 	int last_errno = 0;
-	bool in_progress = false;
+	enum ceph_client_reset_phase phase = CEPH_CLIENT_RESET_IDLE;
 	bool inject_error = false;
+	bool drain_timed_out = false;
+	int sessions_reset = 0;
 	int pending_reconnects = 0;
 	int blocked_requests = 0;
 	char reason[CEPH_CLIENT_RESET_REASON_LEN];
@@ -392,15 +394,17 @@ static int reset_status_show(struct seq_file *s, void *p)
 	last_start = st->last_start;
 	last_finish = st->last_finish;
 	last_errno = st->last_errno;
-	in_progress = st->in_progress;
+	phase = st->phase;
 	inject_error = st->inject_error;
+	drain_timed_out = st->drain_timed_out;
+	sessions_reset = st->sessions_reset;
 	strscpy(reason, st->last_reason, sizeof(reason));
 	spin_unlock(&st->lock);
 
 	pending_reconnects = atomic_read(&st->pending_reconnects);
 	blocked_requests = atomic_read(&st->blocked_requests);
 
-	seq_printf(s, "in_progress: %s\n", in_progress ? "yes" : "no");
+	seq_printf(s, "phase: %s\n", ceph_reset_phase_name(phase));
 	seq_printf(s, "trigger_count: %llu\n", trigger);
 	seq_printf(s, "success_count: %llu\n", success);
 	seq_printf(s, "failure_count: %llu\n", failure);
@@ -419,6 +423,10 @@ static int reset_status_show(struct seq_file *s, void *p)
 		   reason[0] ? reason : "(none)");
 	seq_printf(s, "inject_error_pending: %s\n",
 		   inject_error ? "yes" : "no");
+	seq_printf(s, "drain_timed_out: %s\n",
+		   drain_timed_out ? "yes" : "no");
+	seq_printf(s, "sessions_reset: %d\n", sessions_reset);
+	/* pending_reconnects: always 0 for manual reset (MDS-reconnect only) */
 	seq_printf(s, "pending_reconnects: %d\n", pending_reconnects);
 	seq_printf(s, "blocked_requests: %d\n", blocked_requests);
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 766744468dd6..287cee71227b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3757,7 +3757,7 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 	 * If a reset is in progress, wait for it to complete.
 	 *
 	 * This is best-effort: a request can pass this check just
-	 * before in_progress is set and proceed concurrently with
+	 * before the phase leaves IDLE and proceed concurrently with
 	 * reset.  That is acceptable because (a) such requests will
 	 * either complete normally or fail and be retried by the
 	 * caller, and (b) adding lock serialization here would
@@ -5215,9 +5215,20 @@ static void ceph_mdsc_reconnect_session_done(struct ceph_mds_client *mdsc,
 		complete(&st->reconnect_done);
 }
 
+const char *ceph_reset_phase_name(enum ceph_client_reset_phase phase)
+{
+	switch (phase) {
+	case CEPH_CLIENT_RESET_IDLE:	  return "idle";
+	case CEPH_CLIENT_RESET_QUIESCING: return "quiescing";
+	case CEPH_CLIENT_RESET_DRAINING:  return "draining";
+	case CEPH_CLIENT_RESET_TEARDOWN:  return "teardown";
+	default:			  return "unknown";
+	}
+}
+
 /*
- * Wait for a reset to complete if one is in progress.
- * Returns 0 if reset completed successfully or wasn't in progress.
+ * Wait for an active reset to complete.
+ * Returns 0 if reset completed successfully or no reset was active.
  * Returns -ETIMEDOUT if we timed out waiting.
  * Returns -ERESTARTSYS if interrupted by signal.
  */
@@ -5229,7 +5240,7 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
 	int blocked_count;
 	int ret;
 
-	if (!READ_ONCE(st->in_progress))
+	if (READ_ONCE(st->phase) == CEPH_CLIENT_RESET_IDLE)
 		return 0;
 
 	blocked_count = atomic_inc_return(&st->blocked_requests);
@@ -5238,7 +5249,8 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
 	trace_ceph_client_reset_blocked(mdsc, blocked_count);
 
 	ret = wait_event_interruptible_timeout(st->blocked_wq,
-					       !READ_ONCE(st->in_progress),
+					       READ_ONCE(st->phase) ==
+						CEPH_CLIENT_RESET_IDLE,
 					       timeout);
 
 	atomic_dec(&st->blocked_requests);
@@ -5274,7 +5286,7 @@ static void ceph_mdsc_reset_complete(struct ceph_mds_client *mdsc, int ret)
 	spin_lock(&st->lock);
 	st->last_finish = jiffies;
 	st->last_errno = ret;
-	st->in_progress = false;
+	st->phase = CEPH_CLIENT_RESET_IDLE;
 	if (ret)
 		st->failure_count++;
 	else
@@ -5295,7 +5307,7 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_session **sessions = NULL;
 	char reason[CEPH_CLIENT_RESET_REASON_LEN];
-	int max_sessions, i, n = 0;
+	int max_sessions, i, n = 0, torn_down = 0;
 	bool inject_error;
 	int ret = 0;
 
@@ -5373,6 +5385,70 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 		goto out_complete;
 	}
 
+	spin_lock(&st->lock);
+	st->phase = CEPH_CLIENT_RESET_DRAINING;
+	spin_unlock(&st->lock);
+
+	/*
+	 * Best-effort drain: flush dirty state while sessions are still
+	 * alive.  New requests are blocked while phase != IDLE.
+	 * The sessions are functional, so non-stuck state drains normally.
+	 * Stuck state (the cause of the stalemate the operator is trying
+	 * to break) will not drain - that is expected, and we proceed to
+	 * forced teardown after the timeout.
+	 *
+	 * Three things are drained:
+	 *  1. MDS journal - send_flush_mdlog asks each MDS to journal
+	 *     pending unsafe operations (creates, renames, setattrs).
+	 *     Once journaled, they survive the session teardown.
+	 *  2. Dirty caps - ceph_flush_dirty_caps triggers cap flush on
+	 *     all sessions.  Non-stuck caps flush in milliseconds.
+	 *  3. Cap releases - push pending cap release messages.
+	 *
+	 * All three happen concurrently during the bounded wait window.
+	 */
+	for (i = 0; i < n; i++)
+		send_flush_mdlog(sessions[i]);
+
+	ceph_flush_dirty_caps(mdsc);
+	ceph_flush_cap_releases(mdsc);
+
+	spin_lock(&mdsc->cap_dirty_lock);
+	if (!list_empty(&mdsc->cap_flush_list)) {
+		u64 want_flush = mdsc->last_cap_flush_tid;
+		long drain_ret;
+
+		spin_unlock(&mdsc->cap_dirty_lock);
+		pr_info_client(cl,
+			       "draining (want_flush=%llu, %d sessions)\n",
+			       want_flush, n);
+		drain_ret = wait_event_timeout(mdsc->cap_flushing_wq,
+					       check_caps_flush(mdsc,
+								want_flush),
+					       CEPH_CLIENT_RESET_DRAIN_SEC * HZ);
+		if (drain_ret == 0) {
+			pr_info_client(cl,
+				       "drain timed out, proceeding with forced teardown\n");
+			spin_lock(&st->lock);
+			st->drain_timed_out = true;
+			spin_unlock(&st->lock);
+		} else {
+			pr_info_client(cl, "drain completed successfully\n");
+			spin_lock(&st->lock);
+			st->drain_timed_out = false;
+			spin_unlock(&st->lock);
+		}
+	} else {
+		spin_unlock(&mdsc->cap_dirty_lock);
+		spin_lock(&st->lock);
+		st->drain_timed_out = false;
+		spin_unlock(&st->lock);
+	}
+
+	spin_lock(&st->lock);
+	st->phase = CEPH_CLIENT_RESET_TEARDOWN;
+	spin_unlock(&st->lock);
+
 	/*
 	 * Tear down each session: close the connection, remove all
 	 * caps, clean up requests, then kick pending requests so they
@@ -5383,6 +5459,11 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 	 * teardown.  We do NOT attempt send_mds_reconnect() because
 	 * the MDS only accepts reconnects during its own RECONNECT
 	 * phase (after MDS restart), not from an active client.
+	 *
+	 * Any state that did not drain (caps that didn't flush, unsafe
+	 * requests that the MDS didn't journal) is force-dropped here.
+	 * This is intentional: that state is stuck and is the reason
+	 * the operator triggered the reset.
 	 */
 	for (i = 0; i < n; i++) {
 		int mds = sessions[i]->s_mds;
@@ -5415,11 +5496,16 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 		kick_requests(mdsc, mds);
 		mutex_unlock(&mdsc->mutex);
 
+		torn_down++;
 		pr_info_client(cl, "mds%d session reset complete\n", mds);
 	}
 
 	kfree(sessions);
 
+	spin_lock(&st->lock);
+	st->sessions_reset = torn_down;
+	spin_unlock(&st->lock);
+
 out_complete:
 	ceph_mdsc_reset_complete(mdsc, ret);
 }
@@ -5441,22 +5527,24 @@ int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
 	}
 
 	spin_lock(&st->lock);
-	if (st->in_progress) {
+	if (st->phase != CEPH_CLIENT_RESET_IDLE) {
 		spin_unlock(&st->lock);
 		return -EBUSY;
 	}
 
-	st->in_progress = true;
+	st->phase = CEPH_CLIENT_RESET_QUIESCING;
 	st->active_reset_gen++;
 	st->last_start = jiffies;
 	st->last_errno = 0;
+	st->drain_timed_out = false;
+	st->sessions_reset = 0;
 	st->trigger_count++;
 	strscpy(st->last_reason, msg, sizeof(st->last_reason));
 	spin_unlock(&st->lock);
 
 	if (WARN_ON_ONCE(!queue_work(system_unbound_wq, &mdsc->reset_work))) {
 		spin_lock(&st->lock);
-		st->in_progress = false;
+		st->phase = CEPH_CLIENT_RESET_IDLE;
 		st->last_errno = -EALREADY;
 		st->failure_count++;
 		spin_unlock(&st->lock);
@@ -6017,8 +6105,10 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	mdsc->reset_state.last_start = 0;
 	mdsc->reset_state.last_finish = 0;
 	mdsc->reset_state.last_errno = 0;
-	mdsc->reset_state.in_progress = false;
+	mdsc->reset_state.phase = CEPH_CLIENT_RESET_IDLE;
 	mdsc->reset_state.inject_error = false;
+	mdsc->reset_state.drain_timed_out = false;
+	mdsc->reset_state.sessions_reset = 0;
 	mdsc->reset_state.active_reset_gen = 0;
 	mdsc->reset_state.last_reason[0] = '\0';
 	atomic_set(&mdsc->reset_state.pending_reconnects, 0);
@@ -6558,8 +6648,8 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 	 * if cancel_work_sync() prevents the work from running.
 	 */
 	spin_lock(&mdsc->reset_state.lock);
-	if (mdsc->reset_state.in_progress) {
-		mdsc->reset_state.in_progress = false;
+	if (mdsc->reset_state.phase != CEPH_CLIENT_RESET_IDLE) {
+		mdsc->reset_state.phase = CEPH_CLIENT_RESET_IDLE;
 		mdsc->reset_state.last_errno = -ESHUTDOWN;
 		mdsc->reset_state.failure_count++;
 	}
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index c8269df1a9e5..87302755461c 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -75,9 +75,16 @@ struct ceph_cap;
 
 #define MDS_AUTH_UID_ANY -1
 #define CEPH_CLIENT_RESET_REASON_LEN	64
-#define CEPH_CLIENT_RESET_TIMEOUT_SEC	60
+#define CEPH_CLIENT_RESET_DRAIN_SEC	5
 #define CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC 120
 
+enum ceph_client_reset_phase {
+	CEPH_CLIENT_RESET_IDLE = 0,
+	CEPH_CLIENT_RESET_QUIESCING,
+	CEPH_CLIENT_RESET_DRAINING,
+	CEPH_CLIENT_RESET_TEARDOWN,
+};
+
 struct ceph_client_reset_state {
 	spinlock_t lock;
 	u64 trigger_count;
@@ -86,11 +93,13 @@ struct ceph_client_reset_state {
 	unsigned long last_start;
 	unsigned long last_finish;
 	int last_errno;
-	bool in_progress;
+	enum ceph_client_reset_phase phase;
 	bool inject_error;
+	bool drain_timed_out;
+	int sessions_reset;
 	char last_reason[CEPH_CLIENT_RESET_REASON_LEN];
 
-	/* Completion tracking for session reconnects */
+	/* Async reconnect completion (used by mds_peer_reset path) */
 	u64 active_reset_gen;
 	atomic_t pending_reconnects;
 	struct completion reconnect_done;
@@ -588,6 +597,7 @@ extern struct ceph_mds_session *
 __ceph_lookup_mds_session(struct ceph_mds_client *, int mds);
 
 extern const char *ceph_session_state_name(int s);
+extern const char *ceph_reset_phase_name(enum ceph_client_reset_phase phase);
 
 extern struct ceph_mds_session *
 ceph_get_mds_session(struct ceph_mds_session *s);
-- 
2.34.1

