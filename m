Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA93AF678
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272966; cv=none; b=V0+CjGn8tWom6GKagm2r6cgdmbK3FxT8Sv4tiNk4H44DVIgjX/sq7WABKJaBgSXaKt1vdDJuuFOGNfniXupSM8qUWR/NztndlA3HVU5diOsC5T4huZ4jPT0dZGhm7nWwHKweixJdK54kAmWQhBn2uXxu8zoh6hD4wzg+5Vt39HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272966; c=relaxed/simple;
	bh=xRN7giwH8NEcKW9yTVpwkdPtpHGQFSSZf19t6Lm+GmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cL6uvdeNdeOhZF+DifEeR7AzVz5iuZ7RMoqWamEDfIFeSaOJj+Oe0uZ919Gyz6yMFn+CKTfId6aSouMZMGlwXXHpikKih6WsSalJ084ZFUKjodrDiaGa2l1NKHSA9vL/XXclh22BmOBwvbFXs6newAIlf3CNlxn9uKjiakq2Eq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxjrvS5A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YY4x6GhM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxjrvS5A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YY4x6GhM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776272963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AT7s8MIORBy5Iq5wFLBR87C37LfOCNHX9KOc+RZPc4Y=;
	b=FxjrvS5AKql6kT/s/QY+un2cjMON1YfeX9vw9tbeJxZLXsoMdPZbDXxow+safBIzOSaGVc
	DFrGd/9B1VBdpdFFcFQkxdswT6jmOGVx2ReDiUJLRtH5xP0kpbgMWN7W9/p03WLWVPjlLy
	lXgc5VjU3P3WeMRrPiYUxtH2rXrglvc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438--O6ay01QPkiDQ1dZbNQ0oQ-1; Wed, 15 Apr 2026 13:09:22 -0400
X-MC-Unique: -O6ay01QPkiDQ1dZbNQ0oQ-1
X-Mimecast-MFC-AGG-ID: -O6ay01QPkiDQ1dZbNQ0oQ_1776272962
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f37353f52so4370690b3a.2
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776272961; x=1776877761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT7s8MIORBy5Iq5wFLBR87C37LfOCNHX9KOc+RZPc4Y=;
        b=YY4x6GhM6FioMmvtp+vwmwUdq2eIRTJU9QNOU0P/kkFXz/tLAglBb/tXi+VI5VFIxA
         HhQuYI4oEROAAV66UNXlSxwXLvn8R7/AFe7urdMNuXaof4feJCoGyyX81LG2baSbhw85
         WsNLWXybtgczSPKv+VaZk20HU7wOGCpEd+SjtrqC/2/QmeA2Zwndo52J0IK9mhV1ZRrI
         xMA6PIRLnqEvoeNz+pfmOLVl54GIaH0lbMAEkLVMnNsynQFwGmKvUHR/xxDWWSIZpJ/y
         4SWqHhpRAVKSv80HeRdBScZ1qUG63CEYS8rwMIlTu9Azpy+o9H4DYuwggqAbILqfZDPW
         oQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776272961; x=1776877761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AT7s8MIORBy5Iq5wFLBR87C37LfOCNHX9KOc+RZPc4Y=;
        b=UIx+Ni56fafcvjAoIX6KJi43NSPr2U4r7YGtoaTV72E4VZq8EnaP+oRBBaHaFDBr1S
         H+XTmxX6H/jLncwy/rxpHGMnAsra98XwUApACBtLNDk4c9YaHwQWQ40ED0jGqhstmqyb
         AJgXdBGyTx/hl+d4c9omIGa8jMVindzEUgfBGX/+Jq7bu8nGlTowednV1AVPtYmQ3AMl
         0MWbVLaJn3kOdSyUzW3kjMjf4jZB9aViTeHLqwu7MxZwsb4TCImHUCD+3bm1UPNq+4oZ
         9quzBWpoSustgrvmL4woHeTdM+/fRvwiP1wCa7b5aTqqdosbtIUNYGRwJxhdbalyViBF
         SNJg==
X-Gm-Message-State: AOJu0Yz9z1gArW6LFim7XYUrdcH7EkDH7HgZocYgKLTMdBnWJcpwSwD5
	TZzYY2OvSK0qjNBqaBXBbmm18rCjyJxzy1xGufLluOLIXvBIFj89WMreiGqnGkiDrGoWx0RGsTL
	8zPUCRhFC2WcoXJ5NlwcVzncuX21DlAnnw2bhaHNYuDqOdJFY/XzcT6w+5ZSnVnxYZLHkixsXif
	mzK3Lb+1sgpJWK/LsfKivipXaicUzSTdxRUw+JgzibetuYdNqKEA==
X-Gm-Gg: AeBDietIJyDHiCweQhd9htv9ko0cTkcv3rgyfOsP8oj+hvUVVwMDLWv+j/K3UOJGpLW
	rAJKxQxX57yfrkNtZKckBU4bdZr8YYJWZ2XoLSpuHlHwuWbZoE8AQspg7mgGTOuSUPJGb/FSwdW
	mPXRCJ1N9ae599wa0wtl975cxxPGPWr2WWQPKDvEsAvuyiyisy2U3GT5KZ3OtnSCmpFkEadx8Mr
	Zy5w4Jb13w4Jv+OhIfoPKO2nqStjLVWRitbiE5lA7N2O4NVDqDp8J9nDJA3aQCv/s9SjjvRu6yu
	W5mgfx5m5BV5bOuEraSazfhkh1i+IuJy65Rv9h+SAZH3E0GehArW6qKMefBMZbYyGRgiWdf9RSQ
	fCQTRV+KueFyKRppzaQekbgu8ezYUSUQmpsIcCpD9XPsE8F8kz/gbwjNZQZwO6zvRCw==
X-Received: by 2002:a05:6a00:12dd:b0:827:3946:a23c with SMTP id d2e1a72fcca58-82f0c1daae1mr22363656b3a.10.1776272961172;
        Wed, 15 Apr 2026 10:09:21 -0700 (PDT)
X-Received: by 2002:a05:622a:5c0d:b0:50d:7304:1770 with SMTP id d75a77b69052e-50dd5a83830mr316724691cf.8.1776272467092;
        Wed, 15 Apr 2026 10:01:07 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm16817841cf.16.2026.04.15.10.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:01:06 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 3/7] ceph: harden send_mds_reconnect and handle active-MDS peer reset
Date: Wed, 15 Apr 2026 17:00:39 +0000
Message-Id: <20260415170043.3882912-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415170043.3882912-1-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change send_mds_reconnect() to return an error code so callers can detect
and report reconnect failures instead of silently ignoring them. Add early
bailout checks for sessions that are already closed, rejected, or
unregistered, which avoids sending reconnect messages for sessions that
can no longer be recovered.

The early -ESTALE and -ENOENT bailouts use a separate fail_return label
that skips the pr_err_client diagnostic, since these codes indicate
expected concurrent-teardown races rather than genuine reconnect build
failures.

Save the prior session state before transitioning to RECONNECTING,
and restore it in the failure path.  Without this, a transient
build or encoding failure (-ENOMEM, -ENOSPC) strands the session
in RECONNECTING indefinitely because check_new_map() only retries
sessions in RESTARTING state.

Rewrite mds_peer_reset() to handle the case where the MDS is past its
RECONNECT phase (i.e. active). An active MDS rejects CLIENT_RECONNECT
messages because it only accepts them during its own RECONNECT window
after restart. Previously, the client would send a doomed reconnect
that the MDS would reject or ignore. Now, the client tears the session
down locally and lets new requests re-open a fresh session, which is
the correct recovery for this scenario. The RECONNECTING state is
handled on the same teardown path, since the MDS will reject reconnect
attempts from an active client regardless of the session's local state.

The session teardown path in mds_peer_reset() follows the established
drop-and-reacquire locking pattern from check_new_map(): take
mdsc->mutex for session unregistration, release it, then take s->s_mutex
separately for cleanup. This avoids introducing a new simultaneous lock
nesting pattern.

Log reconnect failures from check_new_map() and mds_peer_reset() at
pr_warn level rather than pr_err, since return codes like -ESTALE
(closed/rejected session) and -ENOENT (unregistered session) are
expected during concurrent teardown. Log dropped messages for
unregistered sessions via doutc() (dynamic debug) rather than
pr_info, as post-reset message arrival is routine and does not
warrant unconditional logging.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 163 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 151 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 871f0eef468d..b14ede808436 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4416,9 +4416,14 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_REJECT:
-		WARN_ON(session->s_state != CEPH_MDS_SESSION_OPENING);
-		pr_info_client(cl, "mds%d rejected session\n",
-			       session->s_mds);
+		WARN_ON(session->s_state != CEPH_MDS_SESSION_OPENING &&
+			session->s_state != CEPH_MDS_SESSION_RECONNECTING);
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
+			pr_info_client(cl, "mds%d reconnect rejected\n",
+				       session->s_mds);
+		else
+			pr_info_client(cl, "mds%d rejected session\n",
+				       session->s_mds);
 		session->s_state = CEPH_MDS_SESSION_REJECTED;
 		cleanup_session_requests(mdsc, session);
 		remove_session_caps(session);
@@ -4678,6 +4683,14 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 	cap->mseq = 0;       /* and migrate_seq */
 	cap->cap_gen = atomic_read(&cap->session->s_cap_gen);
 
+	/*
+	 * Note: CEPH_I_ERROR_FILELOCK is not set during reconnect.
+	 * Instead, locks are submitted for best-effort MDS reclaim
+	 * via the flock_len field below.  If reclaim fails (e.g.,
+	 * another client grabbed a conflicting lock), future lock
+	 * operations will fail and set the error flag at that point.
+	 */
+
 	/* These are lost when the session goes away */
 	if (S_ISDIR(inode->i_mode)) {
 		if (cap->issued & CEPH_CAP_DIR_CREATE) {
@@ -4892,13 +4905,14 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
  *
  * This is a relatively heavyweight operation, but it's rare.
  */
-static void send_mds_reconnect(struct ceph_mds_client *mdsc,
-			       struct ceph_mds_session *session)
+static int send_mds_reconnect(struct ceph_mds_client *mdsc,
+			      struct ceph_mds_session *session)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *reply;
 	int mds = session->s_mds;
 	int err = -ENOMEM;
+	int old_state;
 	struct ceph_reconnect_state recon_state = {
 		.session = session,
 	};
@@ -4917,6 +4931,31 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	xa_destroy(&session->s_delegated_inos);
 
 	mutex_lock(&session->s_mutex);
+	if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
+	    session->s_state == CEPH_MDS_SESSION_REJECTED) {
+		pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
+			       mds,
+			       ceph_session_state_name(session->s_state));
+		mutex_unlock(&session->s_mutex);
+		ceph_msg_put(reply);
+		err = -ESTALE;
+		goto fail_return;
+	}
+
+	mutex_lock(&mdsc->mutex);
+	if (mds >= mdsc->max_sessions || mdsc->sessions[mds] != session) {
+		mutex_unlock(&mdsc->mutex);
+		pr_info_client(cl,
+			       "mds%d skipping reconnect, session unregistered\n",
+			       mds);
+		mutex_unlock(&session->s_mutex);
+		ceph_msg_put(reply);
+		err = -ENOENT;
+		goto fail_return;
+	}
+	mutex_unlock(&mdsc->mutex);
+
+	old_state = session->s_state;
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
@@ -5046,18 +5085,34 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 
 	up_read(&mdsc->snap_rwsem);
 	ceph_pagelist_release(recon_state.pagelist);
-	return;
+	return 0;
 
 fail:
 	ceph_msg_put(reply);
 	up_read(&mdsc->snap_rwsem);
+	/*
+	 * Restore prior session state so map-driven reconnect logic
+	 * (check_new_map) can retry.  Without this, a transient build
+	 * failure strands the session in RECONNECTING indefinitely.
+	 */
+	session->s_state = old_state;
 	mutex_unlock(&session->s_mutex);
 fail_nomsg:
 	ceph_pagelist_release(recon_state.pagelist);
 fail_nopagelist:
 	pr_err_client(cl, "error %d preparing reconnect for mds%d\n",
 		      err, mds);
-	return;
+	return err;
+
+fail_return:
+	/*
+	 * Early-exit path for expected concurrent-teardown races
+	 * (-ESTALE for closed/rejected sessions, -ENOENT for
+	 * unregistered sessions).  Skip the pr_err_client diagnostic
+	 * since these are not genuine reconnect build failures.
+	 */
+	ceph_pagelist_release(recon_state.pagelist);
+	return err;
 }
 
 
@@ -5138,9 +5193,15 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		 */
 		if (s->s_state == CEPH_MDS_SESSION_RESTARTING &&
 		    newstate >= CEPH_MDS_STATE_RECONNECT) {
+			int rc;
+
 			mutex_unlock(&mdsc->mutex);
 			clear_bit(i, targets);
-			send_mds_reconnect(mdsc, s);
+			rc = send_mds_reconnect(mdsc, s);
+			if (rc)
+				pr_warn_client(cl,
+					       "mds%d reconnect failed: %d\n",
+					       i, rc);
 			mutex_lock(&mdsc->mutex);
 		}
 
@@ -5204,7 +5265,11 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		}
 		doutc(cl, "send reconnect to export target mds.%d\n", i);
 		mutex_unlock(&mdsc->mutex);
-		send_mds_reconnect(mdsc, s);
+		err = send_mds_reconnect(mdsc, s);
+		if (err)
+			pr_warn_client(cl,
+				       "mds%d export target reconnect failed: %d\n",
+				       i, err);
 		ceph_put_mds_session(s);
 		mutex_lock(&mdsc->mutex);
 	}
@@ -6284,12 +6349,84 @@ static void mds_peer_reset(struct ceph_connection *con)
 {
 	struct ceph_mds_session *s = con->private;
 	struct ceph_mds_client *mdsc = s->s_mdsc;
+	int session_state;
 
 	pr_warn_client(mdsc->fsc->client, "mds%d closed our session\n",
 		       s->s_mds);
-	if (READ_ONCE(mdsc->fsc->mount_state) != CEPH_MOUNT_FENCE_IO &&
-	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) >= CEPH_MDS_STATE_RECONNECT)
-		send_mds_reconnect(mdsc, s);
+
+	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_FENCE_IO ||
+	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) < CEPH_MDS_STATE_RECONNECT)
+		return;
+
+	if (ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) == CEPH_MDS_STATE_RECONNECT) {
+		int rc = send_mds_reconnect(mdsc, s);
+
+		if (rc)
+			pr_warn_client(mdsc->fsc->client,
+				       "mds%d reconnect failed: %d\n",
+				       s->s_mds, rc);
+		return;
+	}
+
+	/*
+	 * MDS is active (past RECONNECT).  It will not accept a
+	 * CLIENT_RECONNECT from us, so tear the session down locally
+	 * and let new requests re-open a fresh session.
+	 *
+	 * Snapshot session state with READ_ONCE, then revalidate under
+	 * mdsc->mutex before acting.  The subsequent mdsc->mutex
+	 * section rechecks s_state to catch concurrent transitions, so
+	 * the lockless snapshot here is safe.  s->s_mutex is taken
+	 * separately for cleanup after unregistration, which avoids
+	 * introducing a new s->s_mutex + mdsc->mutex nesting.
+	 */
+	session_state = READ_ONCE(s->s_state);
+
+	switch (session_state) {
+	case CEPH_MDS_SESSION_RESTARTING:
+	case CEPH_MDS_SESSION_RECONNECTING:
+	case CEPH_MDS_SESSION_CLOSING:
+	case CEPH_MDS_SESSION_OPEN:
+	case CEPH_MDS_SESSION_HUNG:
+	case CEPH_MDS_SESSION_OPENING:
+		mutex_lock(&mdsc->mutex);
+		if (s->s_mds >= mdsc->max_sessions ||
+		    mdsc->sessions[s->s_mds] != s ||
+		    s->s_state != session_state) {
+			pr_info_client(mdsc->fsc->client,
+				       "mds%d state changed to %s during peer reset\n",
+				       s->s_mds,
+				       ceph_session_state_name(s->s_state));
+			mutex_unlock(&mdsc->mutex);
+			return;
+		}
+
+		ceph_get_mds_session(s);
+		s->s_state = CEPH_MDS_SESSION_CLOSED;
+		__unregister_session(mdsc, s);
+		__wake_requests(mdsc, &s->s_waiting);
+		mutex_unlock(&mdsc->mutex);
+
+		mutex_lock(&s->s_mutex);
+		cleanup_session_requests(mdsc, s);
+		remove_session_caps(s);
+		mutex_unlock(&s->s_mutex);
+
+		wake_up_all(&mdsc->session_close_wq);
+
+		mutex_lock(&mdsc->mutex);
+		kick_requests(mdsc, s->s_mds);
+		mutex_unlock(&mdsc->mutex);
+
+		ceph_put_mds_session(s);
+		break;
+	default:
+		pr_warn_client(mdsc->fsc->client,
+			       "mds%d peer reset in unexpected state %s\n",
+			       s->s_mds,
+			       ceph_session_state_name(session_state));
+		break;
+	}
 }
 
 static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
@@ -6301,6 +6438,8 @@ static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 
 	mutex_lock(&mdsc->mutex);
 	if (__verify_registered_session(mdsc, s) < 0) {
+		doutc(cl, "dropping tid %llu from unregistered session %d\n",
+		      le64_to_cpu(msg->hdr.tid), s->s_mds);
 		mutex_unlock(&mdsc->mutex);
 		goto out;
 	}
-- 
2.34.1

