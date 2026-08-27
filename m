Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D541F5F3;
	Thu, 27 Aug 2026 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825800; cv=none; b=PuXfEeYHwtOa7D5+nGn/FTEfO3dGRnm0WoPOZlBymTcSQSV7zlBQ/D2iGsIXePgwCzNkU9KY0tfMKv4pVZmgZDb8oYbupNfUHBIV8VY0pV3Whlb/G38auMVFXQCMkj8sebFQK4jXvotOx4bGTtF8znLows4ui9vF/nNA8+jk1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825800; c=relaxed/simple;
	bh=YNjJLTxfNMZ4O4V4pvNh7HO8NADO9hmH1voDuRHPkvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fB+PsstLDvVTL5ZqYq1uwyqzGOMxusu577bIGztvE/ONlaiFyBThHJv2n6fJc7RLmjtP3FGG2rh6YvCdaPTrLaIqsvaWb6sOM5K9UedfsPghRYPnemKb2s8eCUklThzfihjQ51rlFI3rwSmEBwc7iFyLycqCSsf9yua8qOa+oWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azivbd+2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azivbd+2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21E58C2BCF6;
	Thu, 27 Aug 2026 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787825799;
	bh=YNjJLTxfNMZ4O4V4pvNh7HO8NADO9hmH1voDuRHPkvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Azivbd+2TqBMBm42A4H4RjqmTNBjF9e7f596hCOGd8d3+wpFrKCuL7qkDasGt+bQQ
	 EhOV4wjiOP+qbWpiS1lwJBWXEhMOY0gYJuCONf/WfxaXuV0rlDvZrENZGXOP5XyVrV
	 +N6/dGtXDxoptsknkGye6acBssayrgKoeigMSxzMo92pQ2X48WisGaOvU6uJEj3wtI
	 HCfmGLwp56rGvmnpgaL7UTAY36mJIKd1exVLagS2c/3aEOmg6RRluDO3eJJjvccp+s
	 5446+S+TM41eRBkiwxZmRf6ekCZ++RQnWwyCngDWz1t3QkufZtr4gxQXtXjtqBqCpA
	 SR9Q0/3A7Rg8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061B5C61DB9;
	Thu, 27 Aug 2026 10:16:39 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Thu, 27 Aug 2026 03:16:03 -0700
Subject: [PATCH v6 1/2] ceph: wake up i_cap_wq waiters on inode shutdown
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-lazyio-v6-1-2755b379b8de@clyso.com>
References: <20260827-lazyio-v6-0-2755b379b8de@clyso.com>
In-Reply-To: <20260827-lazyio-v6-0-2755b379b8de@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787825763; l=1160;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=wOzreLw8o1CmL+OtUmksL+iiCd6T7ivHrgbY3g5NRtM=;
 b=RrrSt9Q/ciUxfmOZJ9+OMrK7qDcWQ2dMILOZtiH3YIz3VA+PbgbRlnmTvf+f3Ad2oLsAtQyLf
 ESKO/7quyY8DHbVz8eGmX0l5FZ/xJEJipBHPjqW6gsFaR6JSyeDUX3g
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
index d52e2b389e0b..153a5242080f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -3252,6 +3252,13 @@ void ceph_inode_shutdown(struct inode *inode)
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


