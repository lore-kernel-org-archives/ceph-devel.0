Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128E3BF68F
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156878; cv=none; b=gLyDF/M8SYilv5JeG0yNwapVtSlBzyTPX00u6rzgOX3TYFUUd7RvdOE2SVqfJ6gIto0B5+f+BK33XCiiWfkNdpeknax9bKuP7xEx6AfdHqhYlEQ5H99cPQ9qwsl7mk63GAigO72gfDGEoVoJk0y191j5Poj7P9pCA5UPi1biUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156878; c=relaxed/simple;
	bh=IYn9i/5O3beFSM+OMajTTszwcrOZ3SjymuLCkQLppFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SELsKK1Z1eBd5QnIGX1M6G0jPAA0ukRq/yWllcrZtKOfScsHanvku4pOaIYwYrsfDE+ekAQPnXXrfQGTq6oLLInSrAppuolNRITJ41jQtXOt0i3P+RVlp9C3tXvUapTJ2T+VLIBDbjliLlnLr8uFbLuxMh8mRr7/0gAl1kanAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPI3HSlq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=djCRnSuJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPI3HSlq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="djCRnSuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778156874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8czzATqxP/no5wQIIvba6jo3pp6Yda95SZ70pZTYiSw=;
	b=VPI3HSlqdRS7gz3ZFDBUyp3v4p5n1RkSfA9c3xTZf9l4pdSeMx9/+GQzsKwhVN8r4XEdav
	pwOnide31Tkq2+3QDP++VokAYnhwFAnS/rj5GWrryEBvoh34UA68fcN51jhp8lq4XLSko+
	/9XmHDWmPQYxhm7Ly73f4o/buYwfTj4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-O41PM4PCNdmcJlQz4LPfxw-1; Thu, 07 May 2026 08:27:51 -0400
X-MC-Unique: O41PM4PCNdmcJlQz4LPfxw-1
X-Mimecast-MFC-AGG-ID: O41PM4PCNdmcJlQz4LPfxw_1778156870
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6729caff479so938767a12.2
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778156870; x=1778761670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8czzATqxP/no5wQIIvba6jo3pp6Yda95SZ70pZTYiSw=;
        b=djCRnSuJ+JKJkcUTdhAV6n59xJqKSRYYh1SOAubltgUwdT0TmcUEGtNj2cVmoFfaf+
         iqd1A69yaTWzQ9Pk0Czi8tuetfasqfLK3MwpGGgth59TxqxPpt74gT4kElXMqbV0ZMJ2
         hbZPNsZHxc5rWSB+1ChRN4nSECc4WtnwI874oO5Amr9VOxevUBbpY3lZIKW0XpGAYmFp
         4uT2va5i9W6PM+C8PGcNsNyr7nkPvqqZ28tna8Mps7NK0X06pZqe5j7oRBWPgKOsQkDI
         H5iCom/nGfrciIkvBEDwq6Y/M7gmEKPS/y2waK7CFlzCr/FQshS+Y8EVm0/2vzp1yRo1
         bJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156870; x=1778761670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8czzATqxP/no5wQIIvba6jo3pp6Yda95SZ70pZTYiSw=;
        b=dVllEGoFcSN6cdEPKJqfRji2RVwMch6iIqS7Wu33nGmr4m5UysUO2S8KgRuvjI7fHb
         ws+vqR9xEOprD5j8Tef8fyav0CfrXjKgUUp1oDgdffhASuX9NGUI7KaWysNr3q7q64tX
         lYuuuXqQ85y+rnVVFO2ceoYBPektAHqhjGji63eew97Z5HlmllIl8K1diN4A3uzlQBIN
         pvBnBc0N43GGOABsXNwXFg2RggumiliA/dfKLPpIzw11fIMzzYDzCTkUCHYODHD0Uly4
         j0aoKHrTKVY5KfhmVHTJctR3epMUvbK/io2wNwuL/WsHvkNFdZdpd4taqCb0nRP8jhea
         iWTQ==
X-Gm-Message-State: AOJu0YxcfKaVFMBdv7cTaRSo+Y7E6WSvzVIzc4ZT4gMsU/6kP0L6rr/Q
	l5MdgyUqJRbhJYqHfUhJGYJ3PwvQQemo+2qBvQFqwLJLkLaT6T4QKsgLhyrqp2/zfum2jQdrz0g
	quM3y+VgYmW7ih5H3aCjT7QrZrRngQOJPulgPKU2mJzx304aYinwUfiTb5vAlXC2eKtv9vAWros
	OD3uqCSlEAs9UOdvO/HHB7WrO2N4YvzD83AKMnFLP0kQt2pBoHww==
X-Gm-Gg: AeBDietY/Ns8t+ydcQen6ZY38iYNy5HZlL8M1768npWLScpr0GukJmNzumTmj+5kwzz
	5VE4Ak8gqrqtuZqRgcOMtFklfXz8MSP59q1zXTOhSjzV4NLe5ASvKLdnxljREDcqo+B1VUtdZkH
	jiGkadoC6aYzUyeJfqs1+Q8P2TPm0vztGTnTSFeF55wJebyDavVlslwgPfJuQmdCze1xTwzdNJv
	733O9ozLJ3lRAYOSX1o2WJ7WON364GJiih0VT+/aFtaJsuEudUC/N3xSjK8JAv4SFJuVz3ppGT9
	7ne2iln1/jehvo6B7FptlOG7Y4KBiHCkWvUveSMumHAqHUAF/UJHPEi4ZERBT1enmIqZeaBGgxL
	AaT+a2AE73kwJAZBoSChvjiTt5E3+Q0SaRXX9IJPoWru+8rUJ7EqhtJJxPrtdSv4yfw==
X-Received: by 2002:a17:907:3e9a:b0:ba8:e7b5:39ad with SMTP id a640c23a62f3a-bc567967b28mr446109266b.0.1778156869789;
        Thu, 07 May 2026 05:27:49 -0700 (PDT)
X-Received: by 2002:a17:907:3e9a:b0:ba8:e7b5:39ad with SMTP id a640c23a62f3a-bc567967b28mr446107166b.0.1778156869047;
        Thu, 07 May 2026 05:27:49 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc81cd34ce8sm76552566b.9.2026.05.07.05.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:27:48 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v4 03/11] ceph: harden send_mds_reconnect and handle active-MDS peer reset
Date: Thu,  7 May 2026 12:27:29 +0000
Message-Id: <20260507122737.2804094-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507122737.2804094-1-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
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
 fs/ceph/mds_client.c | 178 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 163 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d9543399b129..249419c17d3c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4470,9 +4470,14 @@ static void handle_session(struct ceph_mds_session *session,
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
@@ -4732,6 +4737,14 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
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
@@ -4946,20 +4959,19 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
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
@@ -4968,9 +4980,37 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	if (!reply)
 		goto fail_nomsg;
 
+	mutex_lock(&session->s_mutex);
+
+	/* Serialized by s_mutex against concurrent ceph_get_deleg_ino(). */
 	xa_destroy(&session->s_delegated_inos);
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
 
-	mutex_lock(&session->s_mutex);
+	/* s_mutex -> mdsc->mutex matches cleanup_session_requests() order. */
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
 
@@ -5100,7 +5140,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 
 	up_read(&mdsc->snap_rwsem);
 	ceph_pagelist_release(recon_state.pagelist);
-	return;
+	return 0;
 
 fail_clear_cap_reconnect:
 	spin_lock(&session->s_cap_lock);
@@ -5109,13 +5149,29 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
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
 
 
@@ -5196,9 +5252,15 @@ static void check_new_map(struct ceph_mds_client *mdsc,
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
 
@@ -5262,7 +5324,11 @@ static void check_new_map(struct ceph_mds_client *mdsc,
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
@@ -6350,12 +6416,92 @@ static void mds_peer_reset(struct ceph_connection *con)
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
+	/*
+	 * Only reconnect if MDS is in its RECONNECT phase.  An MDS past
+	 * RECONNECT (REJOIN, CLIENTREPLAY, ACTIVE) will reject reconnect
+	 * attempts, so those states fall through to session teardown below.
+	 */
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
@@ -6367,6 +6513,8 @@ static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 
 	mutex_lock(&mdsc->mutex);
 	if (__verify_registered_session(mdsc, s) < 0) {
+		doutc(cl, "dropping tid %llu from unregistered session %d\n",
+		      le64_to_cpu(msg->hdr.tid), s->s_mds);
 		mutex_unlock(&mdsc->mutex);
 		goto out;
 	}
-- 
2.34.1

