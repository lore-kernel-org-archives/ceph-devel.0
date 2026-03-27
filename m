Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B53F65EF
	for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621871; cv=none; b=jIuWWk+EdYaQFw1x8/qeCDmMaTssOSzydyEROsa6fjEqd/rIcX4LB0AdByB0kCKSiEKeK/qyIqiHvkAbpvVnETaAxfyIQu3XFOp15cvzZz0UmoRFARHNTIMAU0MJ0WYgAh0Ac402W+c88l3jlCjaa1yh6bglNSqBt4hlB6LJwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621871; c=relaxed/simple;
	bh=XPJZrzoUth9e1Uhf1SEbHsAGNz7j7+TSaqV/IyP+VGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VB9LTWj4M+02akozFpAFh5mGIrNGCgUtiroxU994yN2B8eLeoXOEfd37auW/BxBdB/IZqDUQ3Ly2/0XfUMozLVeWHMO+vUi3vVXvqbQnUVbUCDv56joTczI6pVJkHpm/CfbMO/A3KNQXyEt+VjuyUhwEKNIbfP/5HyU9toDefvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdEC8C4v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SR7t43YG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdEC8C4v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SR7t43YG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774621869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPJ7OKYoLUXkftA3otWt91AKLSMPduHwj4ssYB6cRjE=;
	b=WdEC8C4vejJURxliflIsDSqPAx5MDKltsRQRVb/2sEDoJWBal9sHUR/LFx05misj3PADWZ
	Y12SzdVJci1DCN7M6WYdDTUL1GsAiBvuN2b8FGv1xF43YrDnQNlIdIzSFOtfba3M/x6unG
	jDfHHGvdJqGcBUmVNwCXqFSSVXPeBXk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-gwFHezG0No2cX-cazOaKbw-1; Fri, 27 Mar 2026 10:31:05 -0400
X-MC-Unique: gwFHezG0No2cX-cazOaKbw-1
X-Mimecast-MFC-AGG-ID: gwFHezG0No2cX-cazOaKbw_1774621864
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb0595def4so593387285a.0
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774621864; x=1775226664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPJ7OKYoLUXkftA3otWt91AKLSMPduHwj4ssYB6cRjE=;
        b=SR7t43YGHZ4RZAvtyQoJavjQayIB8YFmJFrmZ9QmmYzP65lbf4oUBH85N2m7mWJaFj
         tZFjMHhnZZGiZ0kBwYkGWNy4nXLr/HvfxCWlvAvN+ah8hMTIGOFyAqVtHdMyRrTMgLU0
         J2JDOdrwzTd3iaiBE9l8PC08Cre2s8pGMoBTzD+2LP1xLdA3TetFUBXxvW0Pq4++nBco
         I42khNDDr+xm06BrXI5DGGAo77H953KBS0Jdu2MuyzNwvjj9zglvtPhJNel9uXYPAnrk
         ZegAKwetQaRdnAkG342xA3Hk4LPlv8RTVIagY4q4+WDN3T3N4Gz38ol+AB1wZ6+8Hnum
         SklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621864; x=1775226664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WPJ7OKYoLUXkftA3otWt91AKLSMPduHwj4ssYB6cRjE=;
        b=a/SdjNCIv7wX5GHyj2DGrHBkdACpDS7S/vu6pKncKF0MuTs33e75yBY+/1GfbVbZKL
         nS4nM4hbqxmjGSEevngPdlYcm8DF0lO5gQBMN9xuEDQcWAwzrIb9/ucA7PnOQ4NhVoQF
         07nxjvihgvX7+MPR7xILR984sCup15XfOoeYbN7syRYYZhG66SXL/iq+yAVfas8ug+RS
         bSy6nv8en1xmwT1ym+8ivCmLOTBmU6Rsa2zG6xwXfM5da8vp0dlrBxho/hxJuljZhZaK
         gpAZ/ZuuYMgkUtCebCyY9gdPY/PHYtIbqfyuXiB8tTx0qf3GsVXYyHfbJfwzIHo71L9w
         f1TA==
X-Gm-Message-State: AOJu0Ywrdyyi58BlvsP4fl0vnuVubY2zwc842SAJpp+dCf0A6q4mWyHs
	wKOaWfy4gPQGGg4VUs5eZ5mIaq+JxAPbWXs6KiHRzFswCOOh0tYc28q5IpgMjOFCIbMfNqYnBJj
	qumrYBqK0d1aa37NK4gkvpcMJonnx4thlX4DFZecHxtAOfB3nRbkj7sxXVEgcDIu7EMc3x7G93q
	7uwC+B62QBU5NkqSAUMR2UXHKTWN13rAkEs0SY3DIJuqMc2umrnA==
X-Gm-Gg: ATEYQzxrdDTOxj3tMMyVrtz7Ge+R2Mk8S5OMMx0V6vxvB/Ydpj2DlrBQmwWyb2MSN+9
	J8RQRX5la0BgeEDjh3W2Pe+nfzrqyYXjSohj4VRMkEopfhTm2foJZQGt6400OGpIrjaa3n+x00H
	A5+Em+ENeehORFIod2aoNUwInGL1aDYZqxOlOMUQ9uusTX0MbeThcgPIeb3GRStm5nWZPaCCLdv
	Fbos/ZNX9VdQsRpoFZXNYM+mEcCrPhF9e8LtUYuNul0usDRoIbQG3noc7in3IajolLIVoyeFnw1
	yuiBmNBv/AOf62Em7rLA99fD1ii55tXpYuuNpO5GQTCT0FN0xd/lKyNADD4QAgThbWeiqAXvUbk
	ZykBbqUeGoig7qEGy1xVtHtnVQIcSA+aIQpBKzv6hcfYyv3Qt83l7juU=
X-Received: by 2002:a05:620a:458b:b0:8cf:dbf0:502b with SMTP id af79cd13be357-8d01ce8233cmr264895085a.31.1774621864068;
        Fri, 27 Mar 2026 07:31:04 -0700 (PDT)
X-Received: by 2002:a05:620a:458b:b0:8cf:dbf0:502b with SMTP id af79cd13be357-8d01ce8233cmr264886485a.31.1774621863305;
        Fri, 27 Mar 2026 07:31:03 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm515168585a.36.2026.03.27.07.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:31:02 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 06/10] ceph: replace reconnect with direct session teardown in manual reset
Date: Fri, 27 Mar 2026 14:30:42 +0000
Message-Id: <20260327143045.1393612-7-amarkuze@redhat.com>
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

Reconnect only works during the MDS reconnect window, so it cannot be the
recovery primitive for an operator-triggered reset against a live MDS.
Switch the reset path to discard local session state directly so the
client can break capability stalemates and rebuild clean state without
waiting for MDS-side reconnect support.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 84 +++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5a2a9e473058..766744468dd6 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5297,7 +5297,6 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 	char reason[CEPH_CLIENT_RESET_REASON_LEN];
 	int max_sessions, i, n = 0;
 	bool inject_error;
-	u64 reset_gen;
 	int ret = 0;
 
 	spin_lock(&st->lock);
@@ -5305,7 +5304,6 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 	inject_error = st->inject_error;
 	if (inject_error)
 		st->inject_error = false;
-	reset_gen = st->active_reset_gen;
 	spin_unlock(&st->lock);
 
 	if (inject_error) {
@@ -5341,9 +5339,8 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 		 * mdsc->mutex -> s_mutex, which would invert the
 		 * s_mutex -> mdsc->mutex order used by
 		 * cleanup_session_requests().  s_state is an int
-		 * so loads are atomic; send_mds_reconnect() will
-		 * reject sessions that transitioned to CLOSED or
-		 * REJECTED under s_mutex before proceeding.
+		 * so loads are atomic; the teardown loop below
+		 * handles races with concurrent state transitions.
 		 */
 		switch (READ_ONCE(session->s_state)) {
 		case CEPH_MDS_SESSION_OPEN:
@@ -5354,12 +5351,12 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 			break;
 		case CEPH_MDS_SESSION_RECONNECTING:
 			pr_info_client(cl,
-				       "mds%d already reconnecting, skipping\n",
+				       "mds%d already reconnecting, skipping reset\n",
 				       session->s_mds);
 			break;
 		default:
 			pr_info_client(cl,
-				       "mds%d in state %s, skipping reconnect\n",
+				       "mds%d in state %s, skipping reset\n",
 				       session->s_mds,
 				       ceph_session_state_name(session->s_state));
 			break;
@@ -5376,54 +5373,53 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 		goto out_complete;
 	}
 
-	/* Initialize completion tracking */
-	reinit_completion(&st->reconnect_done);
-	atomic_set(&st->pending_reconnects, n);
-
+	/*
+	 * Tear down each session: close the connection, remove all
+	 * caps, clean up requests, then kick pending requests so they
+	 * re-open a fresh session on the next attempt.
+	 *
+	 * This is modeled on the check_new_map() forced-close path
+	 * for stopped MDS ranks - a proven pattern for hard session
+	 * teardown.  We do NOT attempt send_mds_reconnect() because
+	 * the MDS only accepts reconnects during its own RECONNECT
+	 * phase (after MDS restart), not from an active client.
+	 */
 	for (i = 0; i < n; i++) {
-		int err;
+		int mds = sessions[i]->s_mds;
+
+		pr_info_client(cl, "mds%d resetting session\n", mds);
+
+		mutex_lock(&mdsc->mutex);
+		if (mds >= mdsc->max_sessions ||
+		    mdsc->sessions[mds] != sessions[i]) {
+			pr_info_client(cl,
+				       "mds%d session already torn down, skipping\n",
+				       mds);
+			mutex_unlock(&mdsc->mutex);
+			ceph_put_mds_session(sessions[i]);
+			continue;
+		}
+		sessions[i]->s_state = CEPH_MDS_SESSION_CLOSED;
+		__unregister_session(mdsc, sessions[i]);
+		__wake_requests(mdsc, &sessions[i]->s_waiting);
+		mutex_unlock(&mdsc->mutex);
 
 		mutex_lock(&sessions[i]->s_mutex);
-		sessions[i]->s_reset_gen = reset_gen;
+		cleanup_session_requests(mdsc, sessions[i]);
+		remove_session_caps(sessions[i]);
 		mutex_unlock(&sessions[i]->s_mutex);
 
-		err = send_mds_reconnect(mdsc, sessions[i], true);
-		if (err) {
-			bool skipped = (err == -ESTALE || err == -ENOENT);
+		ceph_put_mds_session(sessions[i]);
 
-			mutex_lock(&sessions[i]->s_mutex);
-			sessions[i]->s_reset_gen = 0;
-			mutex_unlock(&sessions[i]->s_mutex);
+		mutex_lock(&mdsc->mutex);
+		kick_requests(mdsc, mds);
+		mutex_unlock(&mdsc->mutex);
 
-			if (skipped) {
-				pr_info_client(cl,
-					       "mds%d reconnect skipped during reset: %d\n",
-					       sessions[i]->s_mds, err);
-			} else {
-				pr_err_client(cl,
-					      "mds%d reconnect failed: %d\n",
-					      sessions[i]->s_mds, err);
-				if (!ret)
-					ret = err;
-			}
-			if (atomic_dec_and_test(&st->pending_reconnects))
-				complete(&st->reconnect_done);
-		}
-		ceph_put_mds_session(sessions[i]);
+		pr_info_client(cl, "mds%d session reset complete\n", mds);
 	}
 
 	kfree(sessions);
 
-	/* Wait for all sessions to complete reconnection */
-	if (!wait_for_completion_timeout(&st->reconnect_done,
-					 CEPH_CLIENT_RESET_TIMEOUT_SEC * HZ)) {
-		pr_warn_client(cl,
-			       "reset timed out waiting for %d sessions\n",
-			       atomic_read(&st->pending_reconnects));
-		if (!ret)
-			ret = -ETIMEDOUT;
-	}
-
 out_complete:
 	ceph_mdsc_reset_complete(mdsc, ret);
 }
-- 
2.34.1

