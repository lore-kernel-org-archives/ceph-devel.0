Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B125337A826
	for <ceph-devel@vger.kernel.org>; Fri, 28 Aug 2026 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939122; cv=none; b=XnEuBjxeWYQA9Eox4CCBdt2mVFup999UXeD6yNKejaKUaz6hmGVvwdb2zovFNlQ+DSXzypxaZ65lqj1anqbDUANgY7NC5tXAw2Ng5zjn4oPqF2G8qDHaTGjYI8RfNtFf0ZwX2CbTTZVRyizGctb31CRMplxKd39onOnhWdMT6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939122; c=relaxed/simple;
	bh=h+BpGgpvdKB55f0B5VB6T0U7Da2OYH7jV3SSwp/hjCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbsgfqo3Uhhu+4WBqwJFI7/Z9btKTlIFzL7HGLgWbNVBRv6xDZIjWm0EB6qo3i6J1tk4ueLTOPhkOKjgnOxEJIbwhneIC1lFrSJcO5v9YbJHm5C5Nkv4irSvamJIAzRN67IqYLHq5muOw7flwsY/cAmYcmyxsGOaZH4RyusBFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Hk6MPKNR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Hk6MPKNR"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482fc2b44a7so757442f8f.2
        for <ceph-devel@vger.kernel.org>; Fri, 28 Aug 2026 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787939115; x=1788543915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJMkwM6Vbb2kq+duXqwTI1+B7IDTJdsELVF1bs1+FLc=;
        b=Hk6MPKNRZ5i/98yla2ivxIIpQF8MJyjXWpOLrz3nvMxD9LJ+mbckaIvAAFy+1bq5me
         AdtspL2mUYr+CX+sg969wiNnN8IbZvc+Ln0Du/UDaLWYy9ovFFjXysyEnSSYGBOJ0cdw
         eVH3Lxm0ia89FJt2SDXtaV1/gtcZL0cA+hUDOODjwwGen9vwzwMIWV6KPP8viqotFxgl
         kN3TVOTC2ZTjEJ5PXXiaNtnmj7qc2ao1Mtc0MC5FfK2bW1dxHsOcpPQfH+QilyA4KDvK
         XtOZS2EUT+hTTeR2etRayOwhHTR8gmGBuEOnp7M8xqSMy62YaeX8QmtTeFWD/GSoJmtT
         uSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939115; x=1788543915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rJMkwM6Vbb2kq+duXqwTI1+B7IDTJdsELVF1bs1+FLc=;
        b=CRcDjzyxx0Gcx3MdfxIqj/zZXF7FNfB3gq4f+FPk0vx+5Pd9Rz5cChS/9NjCLbzWUK
         t+stVp9VDXT7pGtZsXXIfhegaKaNj3b2Gdbz1s/78d8fAmx1+rMCN/Q3TUQV80O0m5Ex
         W2Rjk0mHnQc3fY9+Je4m6X9tUhXf0OR/oDKg/sYmSw9jNSzgK51m1hOrZhRMIkPh+mWc
         sNJE8/hXly+y1IZ58Vp2BTbtp/m/J+IZ4ntF1KAtcz02SGrd61I3FmU7ORGodnasvB/h
         kl/jw5nEBTqy+09LVf15WxGv+5KedFydRbdCOTeqT1qcScXO2p5Y8KNYIER+oeQiNdAR
         7gow==
X-Forwarded-Encrypted: i=1; AHgh+Rp/kDp4pKUw2c1Crzn748o6o5O9lbN55H1FhkCM1ONLs+rpRD66biH+j8y+ObeX/Wi6rrwZEey14E2H@vger.kernel.org
X-Gm-Message-State: AFuF++k0RSzcIPCGyYv1FOmrioYdoTgrunE69Wb3otxv+M33cSD0GXmH
	V5XYOnw/jGW93NyV2tg/9LX3h+tnacLt5CvKH9nDDU7xgGgVCm6faUQ5gI8UK5SWIEo=
X-Gm-Gg: AR+sD13NgbonqjoOYU8ZK3/iPCx2TSFGX8nm3eShw2Zod7PSvc/aV2RlJq970x/RTvB
	SRUVtsgW0074235qZPK7q2J9xnSq+4AvXMpcp2J0Sa3W3iZBYbvWWiAkNBBJOudAY5tkECxRLla
	/pyqjLB4Ajz0YZax/LNFdWYS09jKhDO7TuKeOi0+7cCcObKzgBJbRFywAjkFxNiFM+vsfGUj4V1
	47dokmUzfT9+Vj+JQvVLAaDlv0jszKOCfpCtTlxvE+xwI3fv7OVsElBYtVxun5X/va/57vA+MJm
	8IgHNxRRXrQw1MGw+woKcVx9ek/0WiobwLwNFnJIEQ6xxL/OyEcZBy8nYx3ZRjlyIhbeRlsTn17
	0m/OR0CO85UpORrfowGJMp60jZpijGLJG7CJ1h3fN3Z1kpeOpPVQsr63zylpWN9YPtuheTaFPnl
	Tu7d2oquOjBzcPjhfj68COjt3Q+/4MSGAYLJUh+Y5hDXepdF5rGkRjEgwlnJ1qTR+LhX203btAb
	HAtoGtCz4CingVGx1Nq2LLDf5iiHrGMEK2vNMI0xNfukJaw9LAzS2uCDgdCfR4n
X-Received: by 2002:a05:6000:18a1:b0:482:bf78:300a with SMTP id ffacd0b85a97d-482f79c78abmr15473232f8f.17.1787939114762;
        Fri, 28 Aug 2026 10:45:14 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2794dsm5480678f8f.25.2026.08.28.10.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 10:45:14 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 3/3] ceph: don't unregister an MDS session before removing its caps
Date: Fri, 28 Aug 2026 19:45:04 +0200
Message-ID: <20260828174504.1247038-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828174504.1247038-1-max.kellermann@ionos.com>
References: <20260828174504.1247038-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_session() removed the session from mdsc->sessions[] at the very
top of `CEPH_SESSION_CLOSE` handling, before taking `s_mutex`.
Between session unregistration and remove_session_caps(), the MDS rank
has no registered session while the old session still owns all caps it
was granted.

Any concurrent filesystem operation may walk into that and the next
__do_request() call registers a new session for this rank.  Once it is
open and the MDS issues caps, ceph_fill_inode() calls
ceph_add_cap(), which looks caps up by rank, not
by session identity, finding old caps linked to the old session.

The list_move_tail() call then moves the cap object to the new
session, which is already a bad thing to do.  Since it doesn't
decrement `old_session->s_nr_caps`, this will quickly run into a BUG()
instead of crashing:

  kernel BUG at fs/ceph/mds_client.c:1959!
  Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
  [...]
  Workqueue: ceph-msgr ceph_con_workfn
  pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : remove_session_caps+0x2bc/0x2d8
  lr : remove_session_caps+0x74/0x2d8
  [...]
  Call trace:
   remove_session_caps+0x2bc/0x2d8 (P)
   mds_dispatch+0xf48/0x1b60
   ceph_con_process_message+0x74/0xa0
   ceph_con_v1_try_read+0x3a0/0x1510
   ceph_con_workfn+0x260/0x460
   process_one_work+0x168/0x3b8
   worker_thread+0x1bc/0x3a0
   kthread+0x118/0x1e0
   ret_from_fork+0x10/0x20

That's BUG_ON(session->s_nr_caps > 0).

I was able to reproduce this reliably by delaying the close and
starting I/O during the delay.

This patch keeps the session registered with
`CEPH_MDS_SESSION_CLOSED`.  New requests will be put on the
`s_waiting` list where they will be resumed on the new session.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2: skip CLOSED sessions in check_new_map()
v2->v3: split session pinning and stale-map guards into two preparatory
    patches; rework CLOSED-session and export-target teardown handling

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c       |   3 +
 fs/ceph/mds_client.c | 138 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 127 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d7283fb54cec..b21d0a9ac324 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4195,6 +4195,9 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		}
 		new_cap = ceph_get_cap(mdsc, NULL);
 	} else {
+		if (tsession == ERR_PTR(-EAGAIN))
+			return;
+
 		WARN_ON(1);
 		tsession = NULL;
 		target = -1;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 03809328e4aa..ec8ee95cad6e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1733,6 +1733,30 @@ static int __open_session(struct ceph_mds_client *mdsc,
 	return 0;
 }
 
+/* Is this rank still occupied by a session being torn down? */
+static bool __mds_rank_closing(struct ceph_mds_client *mdsc, int mds)
+{
+	return mds < mdsc->max_sessions && mdsc->sessions[mds] &&
+		mdsc->sessions[mds]->s_state == CEPH_MDS_SESSION_CLOSED;
+}
+
+/*
+ * Wait until the rank is no longer occupied by a CLOSED session.
+ *
+ * The caller must hold mdsc->mutex.  The mutex is dropped while sleeping and
+ * held again on return.  Another session may occupy the rank by then.  The
+ * wait also ends when shutdown starts, so the caller must check
+ * mdsc->stopping before proceeding.
+ */
+static void wait_for_mds_rank_not_closing(struct ceph_mds_client *mdsc,
+					  int mds)
+{
+	wait_event_cmd(mdsc->session_close_wq,
+		       !__mds_rank_closing(mdsc, mds) || mdsc->stopping,
+		       mutex_unlock(&mdsc->mutex),
+		       mutex_lock(&mdsc->mutex));
+}
+
 /*
  * open sessions for any export targets for the given mds
  *
@@ -1750,6 +1774,16 @@ __open_export_target_session(struct ceph_mds_client *mdsc, int target)
 		if (IS_ERR(session))
 			return session;
 	}
+	if (session->s_state == CEPH_MDS_SESSION_CLOSED) {
+		/*
+		 * handle_session() is currently closing this session;
+		 * it stays registered until its caps are gone.  Do
+		 * not return it to our caller because we don't want
+		 * it to attach new caps to it.
+		 */
+		ceph_put_mds_session(session);
+		return ERR_PTR(-EAGAIN);
+	}
 	if (session->s_state == CEPH_MDS_SESSION_NEW ||
 	    session->s_state == CEPH_MDS_SESSION_CLOSING) {
 		ret = __open_session(mdsc, session);
@@ -1769,7 +1803,19 @@ ceph_mdsc_open_export_target_session(struct ceph_mds_client *mdsc, int target)
 	doutc(cl, "to mds%d\n", target);
 
 	mutex_lock(&mdsc->mutex);
-	session = __open_export_target_session(mdsc, target);
+	for (;;) {
+		session = __open_export_target_session(mdsc, target);
+		if (session != ERR_PTR(-EAGAIN) || mdsc->stopping)
+			break;
+
+		/*
+		 * Keep the exported cap on its old session until the
+		 * target rank is vacant.  Dropping it here can discard a
+		 * dirty auth cap; handle_session() wakes us after removing
+		 * the old target session's caps and unregistering it.
+		 */
+		wait_for_mds_rank_not_closing(mdsc, target);
+	}
 	mutex_unlock(&mdsc->mutex);
 
 	return session;
@@ -4492,8 +4538,20 @@ static void handle_session(struct ceph_mds_session *session,
 			ceph_metric_bind_session(mdsc, session);
 	}
 	if (op == CEPH_SESSION_CLOSE) {
+		/*
+		 * Pin the session for the rest of this function.  The
+		 * __unregister_session() call is deferred until after
+		 * remove_session_caps() below, or else other
+		 * processes may find caps still assigned to this
+		 * session while working with a new session object.
+		 */
 		ceph_get_mds_session(session);
-		__unregister_session(mdsc, session);
+
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
+			pr_info_client(cl, "mds%d reconnect denied\n",
+				       session->s_mds);
+
+		session->s_state = CEPH_MDS_SESSION_CLOSED;
 	}
 	/* FIXME: this ttl calculation is generous */
 	session->s_ttl = jiffies + HZ*mdsc->mdsmap->m_session_autoclose;
@@ -4551,12 +4609,24 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_CLOSE:
-		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
-			pr_info_client(cl, "mds%d reconnect denied\n",
-				       session->s_mds);
-		session->s_state = CEPH_MDS_SESSION_CLOSED;
 		cleanup_session_requests(mdsc, session);
 		remove_session_caps(session);
+
+		/*
+		 * Now that all caps are removed, it is safe release
+		 * the MDS rank and allow other processes to create a
+		 * new session object.
+		 *
+		 * A concurrent ceph_mdsc_close_sessions() or
+		 * check_new_map() may have unregistered the session
+		 * already, so check __verify_registered_session()
+		 * first.
+		 */
+		mutex_lock(&mdsc->mutex);
+		if (!__verify_registered_session(mdsc, session))
+			__unregister_session(mdsc, session);
+		mutex_unlock(&mdsc->mutex);
+
 		wake = 2; /* for good measure */
 		wake_up_all(&mdsc->session_close_wq);
 		break;
@@ -5802,6 +5872,10 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		s = __ceph_lookup_mds_session(mdsc, i);
 		if (!s)
 			continue;
+		if (s->s_state == CEPH_MDS_SESSION_CLOSED) {
+			ceph_put_mds_session(s);
+			continue;
+		}
 		oldstate = ceph_mdsmap_get_state(oldmap, i);
 		newstate = ceph_mdsmap_get_state(newmap, i);
 
@@ -5814,18 +5888,24 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 
 		if (i >= newmap->possible_max_rank) {
 			/* force close session for stopped mds */
-			__unregister_session(mdsc, s);
-			__wake_requests(mdsc, &s->s_waiting);
+			s->s_state = CEPH_MDS_SESSION_CLOSED;
 			mutex_unlock(&mdsc->mutex);
 
 			mutex_lock(&s->s_mutex);
 			cleanup_session_requests(mdsc, s);
 			remove_session_caps(s);
+
+			mutex_lock(&mdsc->mutex);
+			if (!__verify_registered_session(mdsc, s))
+				__unregister_session(mdsc, s);
+			mutex_unlock(&mdsc->mutex);
 			mutex_unlock(&s->s_mutex);
 
-			ceph_put_mds_session(s);
+			wake_up_all(&mdsc->session_close_wq);
 
 			mutex_lock(&mdsc->mutex);
+			__wake_requests(mdsc, &s->s_waiting);
+			ceph_put_mds_session(s);
 			if (mdsc->mdsmap->m_epoch != map_epoch)
 				return;
 			kick_requests(mdsc, i);
@@ -5844,6 +5924,16 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 				ceph_put_mds_session(s);
 				return;
 			}
+			if (s->s_state == CEPH_MDS_SESSION_CLOSED) {
+				/*
+				 * handle_session() set state=CLOSED
+				 * in the mutex gap above and is tearing it
+				 * down
+				 */
+				mutex_unlock(&s->s_mutex);
+				ceph_put_mds_session(s);
+				continue;
+			}
 			ceph_con_close(&s->s_con);
 			mutex_unlock(&s->s_mutex);
 			s->s_state = CEPH_MDS_SESSION_RESTARTING;
@@ -5902,6 +5992,9 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 	 * Only open and reconnect sessions that don't exist yet.
 	 */
 	for (i = 0; i < newmap->possible_max_rank; i++) {
+		if (mdsc->stopping)
+			return;
+
 		/*
 		 * In case the import MDS is crashed just after
 		 * the EImportStart journal is flushed, so when
@@ -5927,6 +6020,19 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		 * reconnection request in up:reconnect state.
 		 */
 		s = __ceph_lookup_mds_session(mdsc, i);
+		if (s && s->s_state == CEPH_MDS_SESSION_CLOSED) {
+			/*
+			 * Wait for handle_session() to remove the caps and
+			 * unregister this session, so the reconnect below
+			 * uses a fresh session on the now vacant rank
+			 */
+			ceph_put_mds_session(s);
+			wait_for_mds_rank_not_closing(mdsc, i);
+			if (mdsc->stopping ||
+			    mdsc->mdsmap->m_epoch != map_epoch)
+				return;
+			s = NULL;
+		}
 		if (likely(!s)) {
 			s = __open_export_target_session(mdsc, i);
 			if (IS_ERR(s)) {
@@ -7087,9 +7193,7 @@ static void mds_peer_reset(struct ceph_connection *con)
 	 * Snapshot session state with READ_ONCE, then revalidate under
 	 * mdsc->mutex before acting.  The subsequent mdsc->mutex
 	 * section rechecks s_state to catch concurrent transitions, so
-	 * the lockless snapshot here is safe.  s->s_mutex is taken
-	 * separately for cleanup after unregistration, which avoids
-	 * introducing a new s->s_mutex + mdsc->mutex nesting.
+	 * the lockless snapshot here is safe.
 	 */
 	session_state = READ_ONCE(s->s_state);
 
@@ -7114,18 +7218,24 @@ static void mds_peer_reset(struct ceph_connection *con)
 
 		ceph_get_mds_session(s);
 		s->s_state = CEPH_MDS_SESSION_CLOSED;
-		__unregister_session(mdsc, s);
-		__wake_requests(mdsc, &s->s_waiting);
 		mutex_unlock(&mdsc->mutex);
 
 		mutex_lock(&s->s_mutex);
 		cleanup_session_requests(mdsc, s);
 		remove_session_caps(s);
+
+		/* Keep the rank occupied until all old-session caps are gone. */
+		mutex_lock(&mdsc->mutex);
+		if (!__verify_registered_session(mdsc, s))
+			__unregister_session(mdsc, s);
+		mutex_unlock(&mdsc->mutex);
+
 		mutex_unlock(&s->s_mutex);
 
 		wake_up_all(&mdsc->session_close_wq);
 
 		mutex_lock(&mdsc->mutex);
+		__wake_requests(mdsc, &s->s_waiting);
 		kick_requests(mdsc, s->s_mds);
 		mutex_unlock(&mdsc->mutex);
 
-- 
2.47.3

