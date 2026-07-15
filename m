Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7133B38AB;
	Wed, 15 Jul 2026 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784087943; cv=none; b=ZlY5JmRbSPmg+6wl6PfMdN/RL+2owM043yMTrpkJEHBTKcAqQZ6MWulhi8JJq1Kvq9jUshhjhgE88Pa8b0+ZN+LutIgIE4YlE+Td1TVyLzdAyKpv8zxTX6BIdowFDo5VWmfoIguYZBTwX6Z95SG6sVRfVpOhSmDn5+y6gUvDjoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784087943; c=relaxed/simple;
	bh=+SUkPvvWUO23/3Jx1OpKd8z7wdxbHpC6y/xTMeP6aI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jm1t8c8AXRpOoY22yqHZvkEotSpPitRRaCm9wCqkr8kIlTQvmcy3QKkPh/JqNnRLGonMuYRu3QhdyGTk3wi+kLCnOxT93knVAt9QqS79rRzNtKZDe9R9keU2I1+819Vz/D3FGUAsND/EfZnQLhIfQgUuceXCb+oxPmF6HmS8c+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeJd9Qrx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeJd9Qrx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C67EC2BCFB;
	Wed, 15 Jul 2026 03:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784087942;
	bh=+SUkPvvWUO23/3Jx1OpKd8z7wdxbHpC6y/xTMeP6aI0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VeJd9QrxoTCnleYCP1vdpqyFfDhom4fw4yVVQ7ZMJmw1ghlY0Sni3wb4PAr+Yklwf
	 fSqwbyFsPQKXxkZ9aLfHXFy5tx9zignG1l7zQax7syai8m16/BwJ+64lrMPLOY/8cK
	 vNbSi7H9FfS/rv41X7AUft2ySnCQprwzEae8geGPfVKl2kJWFM+O9YAoD4K5uj+h6W
	 /zEo7JdwLOKxxQGvV1dvCz6dCSRJQoDBuPMcwBnxdRqFSGMeLForVXESxaC8uDegV4
	 vJ3ZJAPi+fEgX9hjc2HpfTnxoLW+mB+f83/5EGu7+YwtXv+Pkf0Q6+IHR43CAjhTQv
	 lzNn/msT73A1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA47C4450B;
	Wed, 15 Jul 2026 03:59:02 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Wed, 15 Jul 2026 11:58:45 +0800
Subject: [PATCH v2 5/5] ceph: narrow mdsc->mutex scope in
 replay_unsafe_requests
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260715-ceph-mdsc-mutex-optimization-v2-5-90e81b726724@clyso.com>
References: <20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com>
In-Reply-To: <20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784087938; l=3210;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=V6Rwu7aHfIW8x0x76qZaMXOB1fkfzmlqcq+V2RGl5oI=;
 b=FIsjpUqPWfrOuyahZ7cKIGiLoVTn4OvhNnZBI/JH4w3nt8Jq6+7SmkDzSBcAf6eJF39Wp8ojZ
 K5qkHU0/IIKCp8tzchKuWbrw4R2JqsGy7C3gSHjeTRdkVqCSy+0YU8L
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

__send_request() is lockless so holding mdsc->mutex across the
replay loop only serializes the list iteration itself.  Collect
the unsafe list entries under the mutex, then replay them without
it.  The old-request tree walk uses xa_for_each() which is
internally locked.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/mds_client.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index be0dae919d69..c313574def74 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4744,30 +4744,66 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 #else
 	struct rb_node *p;
 #endif
+	LIST_HEAD(replay_list);
 
 	doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
 
+#if BITS_PER_LONG == 64
+	/* collect unsafe requests under the mutex */
 	mutex_lock(&mdsc->mutex);
-	list_for_each_entry_safe(req, nreq, &session->s_unsafe, r_unsafe_item)
+	list_for_each_entry_safe(req, nreq, &session->s_unsafe,
+				 r_unsafe_item) {
+		ceph_mdsc_get_request(req);
+		list_move(&req->r_unsafe_item, &replay_list);
+	}
+	mutex_unlock(&mdsc->mutex);
+
+	/* replay unsafe requests (local list, no mutex needed) */
+	list_for_each_entry_safe(req, nreq, &replay_list, r_unsafe_item) {
 		__send_request(session, req, true);
+		list_del_init(&req->r_unsafe_item);
+		ceph_mdsc_put_request(req);
+	}
 
 	/*
-	 * also re-send old requests when MDS enters reconnect stage. So that MDS
-	 * can process completed request in clientreplay stage.
+	 * also re-send old requests when MDS enters reconnect stage.
+	 * xa_for_each() is internally locked.
 	 */
-#if BITS_PER_LONG == 64
 	idx = 0;
 	xa_for_each(&mdsc->request_tree, idx, req) {
-#else
+		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags))
+			continue;
+		if (req->r_attempts == 0)
+			continue;
+		if (!req->r_session)
+			continue;
+		if (req->r_session->s_mds != session->s_mds)
+			continue;
+
+		ceph_mdsc_release_dir_caps_async(req);
+
+		ceph_mdsc_get_request(req);
+		__send_request(session, req, true);
+		ceph_mdsc_put_request(req);
+	}
+#else /* BITS_PER_LONG != 64 — keep mutex for rb-tree iteration */
+	mutex_lock(&mdsc->mutex);
+	list_for_each_entry_safe(req, nreq, &session->s_unsafe,
+				 r_unsafe_item)
+		__send_request(session, req, true);
+
+	/*
+	 * also re-send old requests when MDS enters reconnect stage.
+	 * Must hold mutex for rb_first()/rb_next().
+	 */
 	p = rb_first(&mdsc->request_tree);
 	while (p) {
 		req = rb_entry(p, struct ceph_mds_request, r_node);
 		p = rb_next(p);
-#endif
 		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags))
 			continue;
 		if (req->r_attempts == 0)
-			continue; /* only old requests */
+			continue;
 		if (!req->r_session)
 			continue;
 		if (req->r_session->s_mds != session->s_mds)
@@ -4778,6 +4814,7 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 		__send_request(session, req, true);
 	}
 	mutex_unlock(&mdsc->mutex);
+#endif
 }
 
 static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)

-- 
2.53.0


