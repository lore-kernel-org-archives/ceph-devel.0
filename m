Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD83DD508;
	Mon, 13 Jul 2026 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936021; cv=none; b=OCjCi/i4/wZsqLESoKBOXP33a8TBg9PlbZJalbEdtlbU6HDSkYUc7rYNw8CohsqgjfrS8PSyvTaI9vup/uPiaayrQjtwFuFq2EklGB/RQiGaO672djCjbmQfIfKVJLb5Fg+t0QwApJCnroKNCRLtqaHztqVPSVUaDN2Ai+v8O9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936021; c=relaxed/simple;
	bh=OrhbLzSQoljdA3xsrT3Ppv78ks1IkOXDcY62zeCoVdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2QwjSPCYorj/Fm7606fsO3v9WAkfwJOBf1PYNA52sWJNdFnmbMKwOODKT62i9sbLJGhaEbldN6+3krhX28K82EIQrigkNvNXqyYK6pRj4+benP59xEoXi4iWWwEb/oQafQkJOj0GVdkJM4rHQNhp4NZLm/SqyqHHpeX9TnGDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlpYF9mu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlpYF9mu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DB94C2BCFB;
	Mon, 13 Jul 2026 09:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783936021;
	bh=OrhbLzSQoljdA3xsrT3Ppv78ks1IkOXDcY62zeCoVdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GlpYF9muMftQRlqrFKC/SGx3YGWbODL//OY+iP+JDBok6EPVsAMPyv/bs6Yp4uFjk
	 kceJ1NnTwz+/We6ZY94aKQ+KoF6Y/YOjrXHr0GXaxqcwDpj2usULWwSs/9PSwM/YBJ
	 SrJp8tQ0ZpkQ4VAWlG5WbZzaQyWXE/oYH9KfpKKQuNlwDgX50WvDuvVVl8HLO+cbYP
	 KEsxRt0oMsuE0jYnjUcUAybiy8DSOT1mwex1nqLuPYSd5WEfdYCLmJ1P46Xo2YnMPc
	 okJhW95H75nOy1Ulf3ioZ3RFGhEL/vO+cGKFMpiogw3PBVONZHr2z+kZR+sfZviDo2
	 aW775w9aQP54A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF42C43458;
	Mon, 13 Jul 2026 09:47:01 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Mon, 13 Jul 2026 17:46:11 +0800
Subject: [PATCH 5/5] ceph: narrow mdsc->mutex scope in
 replay_unsafe_requests
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260713-ceph-mdsc-mutex-optimization-v1-5-9ae5ac135c34@clyso.com>
References: <20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
In-Reply-To: <20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783936018; l=1786;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=Sl0B6kcMz6zymOkZ4jEEs/Wx0+iGbBxBQZu85Is5ZhM=;
 b=eB7ysIYOWFeALC2JWW2za+3YIQIvxnyN7J24eSXDLed8j+2xYBOGtjjT0pUbRqjT14oqmBoZn
 IVZwxMEuHRUApPT1pqHUVclVKxwNbNJPg9rqcA+QT1Z/mILKfNh5CJq
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
 fs/ceph/mds_client.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ef54d19ace2a..6c5a8c651d3e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4673,12 +4673,25 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 {
 	struct ceph_mds_request *req, *nreq;
 	unsigned long idx;
+	LIST_HEAD(replay_list);
 
 	doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
 
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
+	/* replay unsafe requests — __send_request is lockless */
+	list_for_each_entry_safe(req, nreq, &replay_list, r_unsafe_item) {
 		__send_request(session, req, true);
+		list_del_init(&req->r_unsafe_item);
+		ceph_mdsc_put_request(req);
+	}
 
 	/*
 	 * also re-send old requests when MDS enters reconnect stage. So that MDS
@@ -4699,7 +4712,6 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 
 		__send_request(session, req, true);
 	}
-	mutex_unlock(&mdsc->mutex);
 }
 
 static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)

-- 
2.53.0


