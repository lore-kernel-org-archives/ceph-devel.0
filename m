Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B834EF04;
	Wed, 12 Aug 2026 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518988; cv=none; b=gmFqNanF73nh74vJABDqDFoQlKUc/gZIcTF9J2QK9l0N+s8XqsWyU2qDJcAcuc5JBGtQ6BjLSMZIQGvuXVfFoXb4X2HuZ9R1fmFnEg/6aevdaljfwC5pBFA2nU9D9qwWB0A0tD9aFrpTPHEsmq5STwgNemXG218BTUEDWn094wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518988; c=relaxed/simple;
	bh=CspCcBEVO9JrSimInPnabEBwSELeyYCzAtVUHVGS0FM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aYQ3uNwVbDhN76CtEdJ/cTOVUN6iS6l1EJaAHnGI00QJEKeizMXEA8urxyuOUa/ufY245biKNsudKmmLRrTiLFy2lFLvbF6fWHcapD8ttklLE5qQKwGFb2ou8h0qXw3hl/7Xhru3q6DcHjtACJoE/KYyZHZl1RjzfCNpDiaBsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rvburbse; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rvburbse"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74437C2BCFD;
	Wed, 12 Aug 2026 07:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786518988;
	bh=CspCcBEVO9JrSimInPnabEBwSELeyYCzAtVUHVGS0FM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RvburbseLYIexeLRlBjCiMfLe+9QPwueMexmZv9QaiJcdALAOLiBX5JIbXKwhFqEi
	 CnjVyC94/jZh7i8wesxmJ2ZNc2eE4t0bfUXmTUYUTC4FchuGdAsU0RSOwPcFtyX+Xq
	 Y+CE6Ml6EPmZifvUfjPMWq+5J9T26XcTbZekj3bTHu5QbRFou7mbbSqNpECe9Lxs8o
	 JdeQnFEXQA5jYu0nb6LD4aTJQZiJ/6iJrE30cDKD5RFnzcATG6cxYVVtEHOOpDUR0Q
	 BYChcgpeuRZCqxEoUyRZWad2hGNYBZVHY3sBSs/v68fltbHwd2yCUoEXaHqr2oq8V6
	 1Y0AFocj5kn/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62382C5B567;
	Wed, 12 Aug 2026 07:16:28 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Wed, 12 Aug 2026 00:16:21 -0700
Subject: [PATCH v4 5/5] ceph: narrow mdsc->mutex scope in
 replay_unsafe_requests
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-ceph-mdsc-mutex-optimization-v4-5-fca3b7462f94@clyso.com>
References: <20260812-ceph-mdsc-mutex-optimization-v4-0-fca3b7462f94@clyso.com>
In-Reply-To: <20260812-ceph-mdsc-mutex-optimization-v4-0-fca3b7462f94@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786518984; l=2770;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=GQb0JtpyzsQK+tqxnCFesVmAc6ZtFDgK8RSPFODAYhg=;
 b=E0O92M87vdf0lxVLIwKjjvIjKKq2RJpJwfHoSGx3CXHaGt5GXMkzp9hdi4+y71oGUxOq4iKxp
 bPXqslSpCe3DZ+QDA1ZydXSv91ZtRvDPbPHr/Uk6YrPOegRlGx0P0eh
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

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/mds_client.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index fbe3eaa56653..f7dc5741acf6 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4731,13 +4731,24 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
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
+		list_del_init(&req->r_unsafe_item);
+		list_add_tail(&req->r_aux_item, &unsafe_list);
+	}
 
 	/*
 	 * also re-send old requests when MDS enters reconnect stage. So that MDS
@@ -4754,12 +4765,27 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
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


