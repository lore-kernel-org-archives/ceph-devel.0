Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA1401A08;
	Tue, 25 Aug 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659840; cv=none; b=novckl6XWXXPBbAcXT+yeFS6yNAlGnGVIsWrqRsbAUvPCvv+yiQXiZ/X9L5ECvYjH5O7c+p79UmdLHwZjmgEVgvpMoiJ9+bDrXONs1F5NKsuPH7UBalbx8Wy9+e2XqUTe7Q8utXA1P/jiA4ITHAdFOc5+CjiuGD8kChlIKS/eP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659840; c=relaxed/simple;
	bh=Eb1YwI3OfYkiSl8Z3/q+YavrTX8EnjCviQgwlr2Ksrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQyd5dWI8+3SAHhvx2GO2CdEdvo4z/7/KzBRw6y+/zenF8t7Df8AnoEvE51k7Z+Fv1jntQv3JQRzqEXXE4OmeJSNLf7h1n5vwUwZH602Ap130zie/T2CU+aWcKGpSZJFWSG48DXMRlGlbLvEmq08xGoTpnkS7zdIrlKDX0HM7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZBq/7n1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZBq/7n1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8E93C2BCFD;
	Tue, 25 Aug 2026 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787659839;
	bh=Eb1YwI3OfYkiSl8Z3/q+YavrTX8EnjCviQgwlr2Ksrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HZBq/7n19Hy7UhiV0qxsUlwbA+PiqHuYVuk0LArWtCKxhdvw1Djz7W9EibAv8vfTi
	 UU1qjDSLKrvbpdYThMXx2j4hLk3Ik8ZqSHN8p25/UD9H79jloisiUFLnnFEvargm0l
	 WqXk1x8hieVHcySYSQJJHAjW5eD92CKLTRyPvBs961nPi9jNSRRUrwZe9DUGSQsrmy
	 GY1uiFCdYwMDFSgfi+WbBy/K8HBcKgiqlumooh4XrIln8XZTAgYaTDvExpSAUzkhdQ
	 z5PmRQdMj+XEHFh4tkbW64Bg88Pmjm9zWICytjSX5pX5DS5ncQktm8x+dMkPC251Yo
	 7KXPibFmKa0Cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0A2C61DBD;
	Tue, 25 Aug 2026 12:10:39 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 25 Aug 2026 05:10:36 -0700
Subject: [PATCH v5 1/2] ceph: wake up i_cap_wq waiters on inode shutdown
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-lazyio-v5-1-65118679d6fa@clyso.com>
References: <20260825-lazyio-v5-0-65118679d6fa@clyso.com>
In-Reply-To: <20260825-lazyio-v5-0-65118679d6fa@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787659836; l=1160;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=5L33KzxZPdVe8iS4lK2FsZ8bqIX6JVsV5w57Ob26vEk=;
 b=6gnqzjqPzYrhq3KVzKRQI/pnSfTdwLVRNlOjLqmd8j/W9un0cSsD8mPSAfqZ81ajfJY5v7xkR
 itQ2BpdZktvDGPyLVevk0vM0Xmw4XBKGtKz1tS3IE4fNQTmMrVYzwM2
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

ceph_inode_shutdown() purges every cap on the inode but never wakes
i_cap_wq, unlike remove_session_caps_cb() which does so after the same
kind of purge.  Anyone blocked in ceph_get_caps() is waiting on that
queue for caps that are now gone for good, so the wait only ends when
the task is killed.

Wake the queue after purging so the waiters get a chance to notice the
shutdown and bail out.

Link: https://tracker.ceph.com/issues/77594
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 22c7da1ea61c..888df696397a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -3250,6 +3250,13 @@ void ceph_inode_shutdown(struct inode *inode)
 	}
 	spin_unlock(&ci->i_ceph_lock);
 
+	/*
+	 * The caps are gone now, so wake up anyone waiting for them -- they
+	 * are never coming back and the waiters need to notice the shutdown
+	 * instead.  remove_session_caps_cb() does the same after purging.
+	 */
+	wake_up_all(&ci->i_cap_wq);
+
 	if (invalidate)
 		ceph_queue_invalidate(inode);
 	while (iputs--)

-- 
2.53.0


