Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEABD45FFA8;
	Tue, 18 Aug 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050696; cv=none; b=bcTtyDew7GTlewMeIRsWBr/1Ga1hZUjo1RJUzqOnTK6L0gXjhIA3ZSrDLEoIVzZan4SsGMcdqNH4HicHOgPcGt+xmg7VfY7T+yo53M2QGC/2uTv2xZWHnNwnU3h6KQKebhiL3jT7pQ7DTqfAHSwskwQUkTNqFqb3oMmPYFFUiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050696; c=relaxed/simple;
	bh=uxrr4D4UTD+yPK/coKgYzAaRfF5/Af5Jj+fyB0NqcNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DjMZXBb+nQu+B1oWhqC8IN8rGLxwGMusvdn7udK7TLorsVQojW3i58bndn0A1pAwxffkGurDdjYlKRuYJeNZdrdYR68vEV4iFKyfWdSoR1/aF0ubJt3rDTs6ERlwpzVY1QQn5WpQ2j27Pomc1oiizlTTZvM2fL3aoA1Ngy8DJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUDdDpRm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUDdDpRm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AA60C2BCFD;
	Tue, 18 Aug 2026 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787050696;
	bh=uxrr4D4UTD+yPK/coKgYzAaRfF5/Af5Jj+fyB0NqcNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UUDdDpRm6UXiqMRXoaP78Sf+uJ3z0qkPLcqtybomuRd4+bbCSyuRzJCWEXTOqu7KK
	 REOCvEtWxM3KahIqOO/ymYGE+V0PwbO53yk7W6/ceH9UAr8mMrzLQ1zQUhDdLhdubM
	 /lmOOGCndFD8wLrnlu9Kn5C0x2KRuSRQdQWUULTfU4mPvkISDnxfwyrY+qOqu0XRSx
	 8MHH4NAKdidcHy3niQEgtLT17AOkjZ7JOaQbPAFE4AtWdMpUZNFYcyQ2f2FvyPwb5E
	 mf+mlrGLost/+g8dVkj2IDRrej9NcpHKDdw7PdAfGrFMxDIMKv6PJoNbDMHniVh23p
	 X2Xa2NdwCIlHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F55C5DF7D;
	Tue, 18 Aug 2026 10:58:16 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 18 Aug 2026 03:58:12 -0700
Subject: [PATCH v5 5/5] ceph: narrow mdsc->mutex scope in
 replay_unsafe_requests
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ceph-mdsc-mutex-optimization-v5-5-7d335a3a1d0b@clyso.com>
References: <20260818-ceph-mdsc-mutex-optimization-v5-0-7d335a3a1d0b@clyso.com>
In-Reply-To: <20260818-ceph-mdsc-mutex-optimization-v5-0-7d335a3a1d0b@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787050693; l=3299;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=009BuODFeGOWGowR2RIFqNz08B1zIvCBUcUg2e3fczI=;
 b=AkP0sUdKpopnSZb06tylp8FhPUG8APSbnzUbaOI6jBqdKO0+qUZUcXXEagY5QcVq2cu/T+Ps4
 ff5lUMYPfQ6AQ8wNRjfU3GPlUUsrS+Uau2v10a+OxuPTXOFvuAc/gFM
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

Currently replay_unsafe_requests() holds mdsc->mutex across the
entire function, including the __send_request() calls.  Since
__send_request() is lockless and the async cap-release helper
schedules deferred work, neither needs the mutex.

Collect the unsafe-list entries and the matching old xarray
entries into local lists under mdsc->mutex, taking a reference on
each, then replay them outside the mutex.  Taking a reference
ensures a concurrent reply handler can complete and unregister a
request without invalidating the local list or the iterator.

Unsafe requests remain on session->s_unsafe; r_aux_item serves
only as a walk-list link.  This keeps them tracked as unsafe
until the MDS replies, so a later reconnect can replay them again
and cleanup_session_requests() can still abort them on session
teardown.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/mds_client.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index c624f80aa5fd..5310bb27b353 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4732,13 +4732,30 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 {
 	struct ceph_mds_request *req, *nreq;
 	unsigned long idx;
+	LIST_HEAD(unsafe_list);
+	LIST_HEAD(old_list);
 
 	doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
 
+	/*
+	 * Collect unsafe and old requests under mdsc->mutex, then
+	 * replay them without it: __send_request() is lockless and
+	 * ceph_mdsc_release_dir_caps_async() schedules work.
+	 */
 	mutex_lock(&mdsc->mutex);
-	list_for_each_entry_safe(req, nreq, &session->s_unsafe, r_unsafe_item)
+	list_for_each_entry_safe(req, nreq, &session->s_unsafe,
+				 r_unsafe_item) {
+		ceph_mdsc_get_request(req);
 		req->r_attempts++;
-		__send_request(session, req, true);
+		/*
+		 * Keep the request on s_unsafe: r_aux_item is only a
+		 * walk list.  The request must stay tracked as unsafe
+		 * until the MDS replies, so that a later reconnect can
+		 * replay it again and cleanup_session_requests() can
+		 * still abort it on session teardown.
+		 */
+		list_add_tail(&req->r_aux_item, &unsafe_list);
+	}
 
 	/*
 	 * also re-send old requests when MDS enters reconnect stage. So that MDS
@@ -4755,12 +4772,27 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 		if (req->r_session->s_mds != session->s_mds)
 			continue;
 
-		ceph_mdsc_release_dir_caps_async(req);
-
+		ceph_mdsc_get_request(req);
 		req->r_attempts++;
-		__send_request(session, req, true);
+		list_add_tail(&req->r_aux_item, &old_list);
 	}
+
 	mutex_unlock(&mdsc->mutex);
+
+	/* replay unsafe requests */
+	list_for_each_entry_safe(req, nreq, &unsafe_list, r_aux_item) {
+		list_del_init(&req->r_aux_item);
+		__send_request(session, req, true);
+		ceph_mdsc_put_request(req);
+	}
+
+	/* replay old requests */
+	list_for_each_entry_safe(req, nreq, &old_list, r_aux_item) {
+		list_del_init(&req->r_aux_item);
+		ceph_mdsc_release_dir_caps_async(req);
+		__send_request(session, req, true);
+		ceph_mdsc_put_request(req);
+	}
 }
 
 static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)

-- 
2.53.0


