Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47A33C513;
	Tue, 11 Aug 2026 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786425477; cv=none; b=h/uLwHfwldjjonFYgWCmWSe30F0Rtcmexh5undFlzhxOv6X2NwJ+8lQ/YHqNe8d8HlMRZ92D3nu/rmjzbnYix9b4vkwhKyIx/m5sEg5vSDU+W0Tfl6O0H9T8MYOCJqHfM4rbxhgyCNCXXsPKfm7hicYKJhWw7q6RiFdQ3vimHbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786425477; c=relaxed/simple;
	bh=xZIGNd2ACYvNHPTnMaupN5d/PGOCAJY3rA5hJeos6rQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJm2JHcD0szNkpg+54vHKXCoUo66fPhg+CZM+gKchx0GYxAoKCn/vgHD4DFZH15urj5wk7DYualAUUHa8Ug9wsGowepQOMQdSGLSx2g/cX5wAJMKnTrRaXJrVeFsEB3cUD4Zf5UGKUmD0khXss3eEsqlqUTVcehT+6svL8M5eAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogunXcs1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogunXcs1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A580C2BCFD;
	Tue, 11 Aug 2026 05:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786425477;
	bh=xZIGNd2ACYvNHPTnMaupN5d/PGOCAJY3rA5hJeos6rQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ogunXcs1RuCtlbZbvauHb4effVdL72a3eNn6X+LzT1wSod0sxsuKwu4OZHAslHNWs
	 rrZ+QZtPLmvmwEDOqwmYaCnFaz5cQKJbkAAItEQGpWoFspcrcODxqzzEeZMSF6Ngpr
	 2z6eoojbOSc2LuT73FaGXtKub03QX1yWaEhvtefGtFoeMfvfme1hWnRh8HMaoCg544
	 5GvUZuDPf4vCFI2VAlWsbiFMlOpftOdHnpDlQHGEeeOHbgrb1IufTVJaLp5kYfJkjN
	 EstEh3BbG1UeWEq3MEz17pnG6ObmRhkaoqsWWlFt7uChnLAyYujJJ/rGqRnQzur1pU
	 KnI0W3dUHgfwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DA1C5AD7B;
	Tue, 11 Aug 2026 05:17:57 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 11 Aug 2026 13:17:49 +0800
Subject: [PATCH v3 5/5] ceph: narrow mdsc->mutex scope in
 replay_unsafe_requests
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-ceph-mdsc-mutex-optimization-v3-5-d031114419f4@clyso.com>
References: <20260811-ceph-mdsc-mutex-optimization-v3-0-d031114419f4@clyso.com>
In-Reply-To: <20260811-ceph-mdsc-mutex-optimization-v3-0-d031114419f4@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786425473; l=2687;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=W6+X1JGkKuujMu/zlmW/Tgr6nBaTcr4f6OKmGGGk9no=;
 b=uwbDXWhPuBN6FGdXC6ib3qyjVDLPPXQOVzii07mS+ePQIwUInUDSzejN2a8yc98v3ukFdxe+W
 R49ezb7Oxq/CVV3OebxSAXU0DqJPGf5GukIXsdmK9zdsuWE121YqVvd
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
 fs/ceph/mds_client.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 76dfd2c86392..d8eb9154ae26 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4702,12 +4702,23 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
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
-		__send_request(session, req, true);
+
+	list_for_each_entry_safe(req, nreq, &session->s_unsafe,
+				 r_unsafe_item) {
+		ceph_mdsc_get_request(req);
+		list_move(&req->r_unsafe_item, &unsafe_list);
+	}
 
 	/*
 	 * also re-send old requests when MDS enters reconnect stage. So that MDS
@@ -4724,11 +4735,26 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 		if (req->r_session->s_mds != session->s_mds)
 			continue;
 
-		ceph_mdsc_release_dir_caps_async(req);
+		ceph_mdsc_get_request(req);
+		list_add_tail(&req->r_unsafe_item, &old_list);
+	}
 
+	mutex_unlock(&mdsc->mutex);
+
+	/* replay unsafe requests */
+	list_for_each_entry_safe(req, nreq, &unsafe_list, r_unsafe_item) {
 		__send_request(session, req, true);
+		list_del_init(&req->r_unsafe_item);
+		ceph_mdsc_put_request(req);
+	}
+
+	/* replay old requests */
+	list_for_each_entry_safe(req, nreq, &old_list, r_unsafe_item) {
+		ceph_mdsc_release_dir_caps_async(req);
+		__send_request(session, req, true);
+		list_del_init(&req->r_unsafe_item);
+		ceph_mdsc_put_request(req);
 	}
-	mutex_unlock(&mdsc->mutex);
 }
 
 static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)

-- 
2.53.0


