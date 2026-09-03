Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF83F929C;
	Thu,  3 Sep 2026 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418745; cv=none; b=tssff7g3fAQOyNlwy1kjwvk+pwq4U7/H5BipMyu7ZK71ZC2KXHTSpbL4TyiFtPoyaniyvudHUwvywamF8U2FT45/yTQnpPcjrthwJGPW1cRqq8LHB1b9/W4VHIZTm96IVi8EuGtXqKLAAFDeHKgWhGM4LOKCJElMsgYY9GjjvLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418745; c=relaxed/simple;
	bh=fFHoj6gAKkFWjGmwc9Pnj0rlvfKC1Wk7kIjSuw78k3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nl+vqKJop9SaLGVpyS6NjBykVlMrYFAJP0wfPigYYYIGyBhOdhQu/dt2s/sa3jAgW+BJfzBOn2XusRV24KFg+Q8bml9RUFQn6lmzmv8fK4d05ZBFkbfDVhA7cty7cvWHeTYttzPwDabWVeuIPbMyTHCXlGTjKNRJpI4BdxJ7+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+OD3rc4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+OD3rc4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C480CC2BCB8;
	Thu,  3 Sep 2026 06:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788418744;
	bh=fFHoj6gAKkFWjGmwc9Pnj0rlvfKC1Wk7kIjSuw78k3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o+OD3rc4YPWYSgEGcHBvSUlQ1q9KpCF6VnzV7ZbMCe633Y2rVqntkw42HQ/Rx/HBZ
	 BqJS9yUMmbhtYKajnPIMsAgHLD0DjGu1pTWsp326SKKoK1qs9JUk/HRC0jX1U8pJSF
	 +GFlG/DXSnr52fYPmUBuOHIzFVcVZg+h1eVWjzlhzfhiNCN+vuel9wd69xYXT6sWYY
	 0KCps7pkzt7FjXh5dwfzsjzbG3ov58pM+3XOwWI7rpHpB5Ld2Qv5KDcow4bascHz0N
	 PpJZDmJ+8yLrp/Q6/g2qd4KWBkMtLoWMHyujNnIZoIBkOz1XCqERdv2bcadtBErXpx
	 qs3B59mP6cedA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A26C624D4;
	Thu,  3 Sep 2026 06:59:04 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Wed, 02 Sep 2026 23:59:01 -0700
Subject: [PATCH v7 1/2] ceph: wake up i_cap_wq waiters on inode shutdown
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-lazyio-v7-1-18c2afa06352@clyso.com>
References: <20260902-lazyio-v7-0-18c2afa06352@clyso.com>
In-Reply-To: <20260902-lazyio-v7-0-18c2afa06352@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788418742; l=1160;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=/w+13aDT7byuE64KSZZv8Qvteagzw9g49d8Bw9ILBEg=;
 b=Wd2gkxu4c96IAMJZwP9U5PTF/BKNol+7CKZej5rUGleR6M7qAg/xDl9TxxEtTCQXWsrOTdbjc
 YaEEDI20Q3rDLfcN8aYhMXtcg5NzEEd9m/fnHZWRPvNA/nuWUdqsQaO
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
index 209e8972287d..619a429f0d45 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -3323,6 +3323,13 @@ void ceph_inode_shutdown(struct inode *inode)
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


