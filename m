Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE603FB7C8
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467148; cv=none; b=i7hjSz8lJqCIBPfiCOnWTrv4v+KQD9qnbRPxMsrF+AxlgZwAWVCEUMagRNu7FsGFSiBhwvrxATZOrLaO6B7bzGaPCi0I2T9vag71Ysvai2IckcLAksN6f5yyTbh8V2Dq/2XD4AZSt3HY70QZIBtViWCRu7HAtsCLiiI+5DR0NYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467148; c=relaxed/simple;
	bh=tnPqC8BgXfwg4wC768hD+ltUOyxbS9+OmAJECaBh87g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dtWIJ27FMb6UaaAImELNP1jw+eTq7isq4eEu37taai7qM97KjZiG3dP7GWzID6yeacHhIVXJJPXv1WmUnt7ZWasoJ4tqp4EAr4uR0eNBmggSjQH/h4qpOFuXaIdubkfY8KUGib9Mqfs0dr5xga4X61qsZEiVZy2g2rQXo+gDnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+GdHX3S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qzD3sXpY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+GdHX3S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qzD3sXpY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777467144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asL+rz7v2ijvPcwX3iOzgMmiTXf19M9ZSCghMhBcDBY=;
	b=Q+GdHX3SOAInII97d0BU5HS0joBgvrc+63mZTwsubckDZfh3XukR50Kw5cBKW/5hfqK/8p
	6oRV6JBqai1rIZhTg1R805nOKJXKShSAVaok5FntvAKQkLtb8LBioB9HLMH+o0wzLBnd2F
	qmSzMCYaIoR74w8kVazisfzrdL8qDtk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-pG56_cWSN2aJBNf4eemqFQ-1; Wed, 29 Apr 2026 08:52:22 -0400
X-MC-Unique: pG56_cWSN2aJBNf4eemqFQ-1
X-Mimecast-MFC-AGG-ID: pG56_cWSN2aJBNf4eemqFQ_1777467141
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-678ad5bfc8cso5321176a12.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 05:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777467141; x=1778071941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asL+rz7v2ijvPcwX3iOzgMmiTXf19M9ZSCghMhBcDBY=;
        b=qzD3sXpYJkTk0r+9Aibj99YooNllQzd0qMze9quKcul7ItPYsqs/Pjd24J4jcyNNd6
         ls3gTMj0hc6bzTGEhq3ninlQB9ZCxMAMuYPEd7v9Nft9SATKzjVJ4sL5cd877Gspz1CH
         TYqLe+IhldrLshoycnEwZMj6wKBHwrdU3aFOkItXJ2o1O8axGQW5C588Lm1hEjNeAAnW
         8KL5BVHTAipA+m8sKAtCfDRp2ZvkXxI67zAZSkqUsvddZFyjuzbApAXsCMpYze2wNN1T
         8sBRMpPjf9qeu4tfQSTdpBmOIW75/tCjfhpHc5BjPgztc8AceBA3FL/vI9l/QVN6EaiS
         xW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467141; x=1778071941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=asL+rz7v2ijvPcwX3iOzgMmiTXf19M9ZSCghMhBcDBY=;
        b=WJQ6URhD58ObJ1XwyT9lG/Gu7AYaV41bdON7RP8wG24zQDwV49QKoftkqJi+eXdL50
         ArpWFsCEmudT5IlRx7CYOIJnIEeTAl5XFce8cImAdc6JXzF946weX4C6+vYtkKjiTxaX
         TXycYG+1I1vbi5hplVsnqhgqNibBPLQ8vIOhpYG22tqWtfTxgPvUg6xZxXvGkE8yvGwc
         UMiN573vekAFWrndQrbS5G/n5WolZYmKNGY26nx6TR1+YaTJeJx7qrOO/B+qvCgMe+u0
         zLRozc3FHqn/ZxY8jMieOqSecFGKOgcoOZ0vG8VTQ4Jn7RrJ1ZizuKmZopvS5XO2o4pE
         B7Vw==
X-Gm-Message-State: AOJu0Ywm1zSnviUC1gqiIpolq3KxeDp/V37apD1LN0r1tZdOb0jTd0Sp
	Txp9OVDFGpBHfM5C5lcG4VkXrrGnLQJGJfTU5mySo0GwWB+S4U+wuDPnHd/W2xqsRGbaPccGZRI
	O4yI//L2e+mBCpniFUwo9h2R9AbufhS58Kkp0CT+sXfQo+WMxIG9q/LHo6l1b4OtLt1iWkHFi1+
	p3R0d9QF3Sb5sfodiYsKFIk1BsaKLkjapiyApRXR5IBR6w87y4hA==
X-Gm-Gg: AeBDieuzbp2f4sX7ls6mEx58S3opK4FH0SKO2ta4jLuElKqyBFfF4an7nhPZ6uVrMU8
	IWeNpITvjztxptodxK8sWAvPNVsekagCr4KT+v+I44Dwaljq7ZhaVWtvloZO8eZSNf9qu/ulHOn
	5yBluTOdfucJ5gvu6OBFaoT2q9i2NUNwTbdXPrv8iY85McyvO4quu36q+y9dMa4b3tm4z6rJWGF
	vdM8ij95+bJaAL1BDYMOoZ+sSafxBmJusAXLPc2Jemc6UBQo/p28D8CNV1+i7nElJ3yqWMmgFst
	D9DCSMhf9kwzN3cb6h6QMh/QYsFkLhZGA7GKIIytTBy5SrgCyH5Zi3bE4tE/Vm8Dw/L577XI68H
	6k2pVWd9s1QyrZm0qppJoH+fDWw9J4cv4kF1EMsca1p00ABG6yx1fNmQk36YISIg7Vg==
X-Received: by 2002:a05:6402:5057:b0:676:98a0:1c8d with SMTP id 4fb4d7f45d1cf-679bb04a803mr2891184a12.1.1777467140557;
        Wed, 29 Apr 2026 05:52:20 -0700 (PDT)
X-Received: by 2002:a05:6402:5057:b0:676:98a0:1c8d with SMTP id 4fb4d7f45d1cf-679bb04a803mr2891167a12.1.1777467139847;
        Wed, 29 Apr 2026 05:52:19 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22166a6esm680526a12.25.2026.04.29.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:52:19 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v3 03/11] ceph: harden send_mds_reconnect and handle active-MDS peer reset
Date: Wed, 29 Apr 2026 12:51:58 +0000
Message-Id: <20260429125206.1512203-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429125206.1512203-1-amarkuze@redhat.com>
References: <20260429125206.1512203-1-amarkuze@redhat.com>
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

Move the "reconnect start" log after the early-bailout checks so it
only appears for sessions that actually proceed with reconnect.

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

Add explicit cases for CLOSED and REJECTED session states in
mds_peer_reset() since these are terminal states where a connection
drop is expected behavior.

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
 fs/ceph/mds_client.c | 169 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 155 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 871f0eef468d..b62abae72c4c 100644
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
@@ -4892,20 +4905,19 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
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
 	LIST_HEAD(dispose);
 
-	pr_info_client(cl, "mds%d reconnect start\n", mds);
-
 	recon_state.pagelist = ceph_pagelist_alloc(GFP_NOFS);
 	if (!recon_state.pagelist)
 		goto fail_nopagelist;
@@ -4917,6 +4929,32 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
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
+	pr_info_client(cl, "mds%d reconnect start\n", mds);
+	old_state = session->s_state;
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
@@ -5046,18 +5084,34 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 
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
 
 
@@ -5138,9 +5192,15 @@ static void check_new_map(struct ceph_mds_client *mdsc,
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
 
@@ -5204,7 +5264,11 @@ static void check_new_map(struct ceph_mds_client *mdsc,
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
@@ -6284,12 +6348,87 @@ static void mds_peer_reset(struct ceph_connection *con)
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
+	case CEPH_MDS_SESSION_CLOSED:
+	case CEPH_MDS_SESSION_REJECTED:
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
@@ -6301,6 +6440,8 @@ static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 
 	mutex_lock(&mdsc->mutex);
 	if (__verify_registered_session(mdsc, s) < 0) {
+		doutc(cl, "dropping tid %llu from unregistered session %d\n",
+		      le64_to_cpu(msg->hdr.tid), s->s_mds);
 		mutex_unlock(&mdsc->mutex);
 		goto out;
 	}
-- 
2.34.1

