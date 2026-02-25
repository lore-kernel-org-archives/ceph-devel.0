Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4F3AE6E2
	for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024362; cv=none; b=gxRS1xDUBwSmvXGJuzYRQCQ0pvRLICla46EHkaalPD/Zs64/qt1+j1EAtNv3g6981+jixVPtVgTokMFdHLr2RgJ6vYSnYh5lHy7H/fcw7Gh6N1hZLEm9ZSNVLaz5ukqB45kLYYy/Hfv7dkDQxY61dnuFqCxD2FJ5SZCnUeMoqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024362; c=relaxed/simple;
	bh=bGwRVvd3ajNn4t+dSLjh1eK2i+/FzUMc5/O4uhriyQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uw82uOsgknPa/ctbLqGUR93bWH6HwF92cIL4bk3/O6ajEfe0pl4c+DILvCxn//ctSUp41uJ2Dh+1k3QVU9tEVYYLVwWGpidLCWRmTncuM5t8Xgf7S2ZCGrgILEkPHwTQssHkwK0S5Q9EFneM8TeEdJkwVzdOW0u1xgqOJN/khBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LlPNEieb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nlpnbb2B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlPNEieb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nlpnbb2B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772024360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kOIIK0zwnK1vvhLt6PsS43bfbxLU6KWtPkGNCJ0ZHw=;
	b=LlPNEiebrvI+7UqZI244Vk+TYew8d3YYC8WTNUp+OFdCBK90GonoQU7w7OaASeOOObQjiH
	41W3rNMXvfFG68rmHtYOiiRvdFAsuESFUtzDS3HgdCd2zbnyLpE1UeOc+Y+E9jc3+zQOiW
	VLyant2gVH69hB/qMMw5FW7UnNRTI2s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-GQIP2SQmPv2YNnU8a-oxjQ-1; Wed, 25 Feb 2026 07:59:19 -0500
X-MC-Unique: GQIP2SQmPv2YNnU8a-oxjQ-1
X-Mimecast-MFC-AGG-ID: GQIP2SQmPv2YNnU8a-oxjQ_1772024359
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cbb8040f48so227368685a.0
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2026 04:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772024359; x=1772629159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kOIIK0zwnK1vvhLt6PsS43bfbxLU6KWtPkGNCJ0ZHw=;
        b=nlpnbb2B266JFeGs2HZmgqmBHMv45vCuu/+zGqQryZ52h3Dff42cXmOMJG355fneYt
         mLBts8T0LdEGzdaawVF6SEF/zfWMXY/tVsSiSETi8Evm1ct8zFrBtBbjl67ICfzni21I
         k4qdHljsiTf9JT+KwzWDfLvXFcUJoH69apLMCMVPpM5PnfNZdFYPaUTz3n9JMi5OiUjf
         H23bMyhV7uz52tCKrWKPeFYl1BTWFwATJWUWU2ACiMQ9WgwdaC2QvHo8bbRfQ4I8ErDh
         EKeLQ9ETt8xTWD+M2Lz0bUWw8bhkVNFdqGdFPItDfjX30uBFnjH4NZyzsbuyhz7BShQQ
         rhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024359; x=1772629159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0kOIIK0zwnK1vvhLt6PsS43bfbxLU6KWtPkGNCJ0ZHw=;
        b=s0syqEFlYW272jlD5wYPF7e1XZZuwOcyGnseBgCjJ8brdtwEyYddSYVvaOhoWs75kJ
         YIrNkE3biIU90VLTm0E2JqH7tJTJgUYVHe6FolI1Xhgh1WBBY7iG3vTUzDMFTmlzc6N5
         EHJBnhCohxtyVNLboE2zQB7mtY0ZdRcNTqgiAMA0Ic99+bUOvSdYGl+aJ1R1h+qRaOEb
         g2qOfmq4w1PrCu9iC5zh0sD9uiTPssaQiB6FXNvdKnQiqR1XYfHifm73NgnKSJZD5J1t
         u7rm9DuGXolBEJzYtNvvLrmCWb33Zt31snbOYT3V+unPzWyDxYy/fhKz1VYA7/COuOXv
         KGgA==
X-Gm-Message-State: AOJu0YyaYR+jp9iIJXOPfya9pnNXnQVSLvnWsBWQpRO4xZgJE65oCoEe
	JvnLcGb8lcQ4iknDs6m7jC8Z5JyhpQzFHLXxvNd8002XQ3/EB+vn37v009pBc9/Hth1inigjeQ/
	6kjUnh2PJUg/t5D4rk9vKEaCRjAmvr4Gq92lvvZk7wRMvU/t1bWzwxly68zbqGu/GaBUBzfeLvz
	bI4HXBwiWkBJX5pMb4+E2H6FpQTV+PDsSkOmI+Poa44mQXIBPPm057
X-Gm-Gg: ATEYQzxGmMSdoSH5HGDlh7INo6d7J2YhLeKvcCC9okJcf94+GUGgaex0uWK5MkadLYR
	6GGCkr1DyKSNjCO83wKDigZeaZ+APgawNf5qNYPfvlphBfOk6EDbUNmEJNeEU7rWFBTZIMz3trv
	dhcyedeGY114uB9aY1RtUcAaFBX9wInWxhhnJKgBGJtIp8LRid3DFpxs+M2k6CW8gOWKdweJDL9
	vntrAu3lfcm7VTOpDn/i5iyVscVPA2jbsUDX5O6iGPRe5SK87JxOFvifHOMP6GEIINcqO9aFelA
	8EzPQrX5QI8Muyk5qDMLnMSrgJylA8qI6WCdHLFkS/IELBqBVuYaNdHN4ABLKpAx06uvJ1idnws
	EoUr4edLGmpgairz2aYKvmHM+FJq3Mk2ncRkkCD3xpBsn4zVth83ecWI=
X-Received: by 2002:a05:620a:45ab:b0:8c6:d2ca:1d0e with SMTP id af79cd13be357-8cb8c9e62a4mr1886939785a.11.1772024358793;
        Wed, 25 Feb 2026 04:59:18 -0800 (PST)
X-Received: by 2002:a05:620a:45ab:b0:8c6:d2ca:1d0e with SMTP id af79cd13be357-8cb8c9e62a4mr1886935885a.11.1772024358265;
        Wed, 25 Feb 2026 04:59:18 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046055sm1514219685a.8.2026.02.25.04.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:59:18 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH v1 4/4] ceph: rework mds_peer_reset() for robust session recovery
Date: Wed, 25 Feb 2026 12:59:07 +0000
Message-Id: <20260225125907.53851-5-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225125907.53851-1-amarkuze@redhat.com>
References: <20260225125907.53851-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite mds_peer_reset() to properly handle all session states when
the MDS resets our connection. Previously it unconditionally called
send_mds_reconnect() for any state >= RECONNECT, which could leave
sessions in inconsistent states.

The new implementation:
  - Returns early for FENCE_IO or MDS not yet in reconnect state
  - For MDS in RECONNECT state, directly reconnects (no locks)
  - For active sessions (OPEN/OPENING/CLOSING), performs full
    cleanup: unregister session, wake waiting requests, clean up
    caps, and kick pending requests
  - For RECONNECTING sessions, restarts the reconnect
  - Snapshots session state under s_mutex, then re-acquires locks
    in the correct order (s_mutex -> mdsc->mutex) matching the
    convention used by check_new_map() and cleanup_session_requests()

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 89 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d350bf502a15..d9baa0073bbd 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6737,12 +6737,95 @@ static void mds_peer_reset(struct ceph_connection *con)
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
+		int rc = send_mds_reconnect(mdsc, s, false);
+		if (rc)
+			pr_err_client(mdsc->fsc->client,
+				      "mds%d reconnect failed: %d\n",
+				      s->s_mds, rc);
+		return;
+	}
+
+	/*
+	 * Snapshot session state under s->s_mutex, then release before
+	 * re-acquiring in the correct order: s->s_mutex -> mdsc->mutex
+	 * (matching check_new_map() and cleanup_session_requests()).
+	 */
+	mutex_lock(&s->s_mutex);
+	session_state = s->s_state;
+	mutex_unlock(&s->s_mutex);
+
+	switch (session_state) {
+	case CEPH_MDS_SESSION_RECONNECTING: {
+		int rc;
+
+		pr_info_client(mdsc->fsc->client,
+			       "mds%d reset during reconnect, restarting\n",
+			       s->s_mds);
+		rc = send_mds_reconnect(mdsc, s, false);
+		if (rc) {
+			pr_err_client(mdsc->fsc->client,
+				      "mds%d reconnect restart failed: %d\n",
+				      s->s_mds, rc);
+			mutex_lock(&s->s_mutex);
+			ceph_mdsc_reconnect_session_done(mdsc, s);
+			mutex_unlock(&s->s_mutex);
+		}
+		return;
+	}
+	case CEPH_MDS_SESSION_CLOSING:
+	case CEPH_MDS_SESSION_OPEN:
+	case CEPH_MDS_SESSION_HUNG:
+	case CEPH_MDS_SESSION_OPENING:
+		mutex_lock(&s->s_mutex);
+		mutex_lock(&mdsc->mutex);
+		if (s->s_state != session_state) {
+			pr_info_client(mdsc->fsc->client,
+				       "mds%d state changed to %s during peer reset\n",
+				       s->s_mds,
+				       ceph_session_state_name(s->s_state));
+			mutex_unlock(&mdsc->mutex);
+			mutex_unlock(&s->s_mutex);
+			return;
+		}
+
+		ceph_get_mds_session(s);
+		__unregister_session(mdsc, s);
+
+		s->s_state = CEPH_MDS_SESSION_CLOSED;
+		__wake_requests(mdsc, &s->s_waiting);
+		mutex_unlock(&mdsc->mutex);
+		mutex_unlock(&s->s_mutex);
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
-- 
2.34.1

