Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA73C387359;
	Thu, 23 Jul 2026 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785670; cv=none; b=SkdQwsiHMrDxcK8R3V+mmcMUvHYnLFBgpqRn0ChUXrVmWBwqO8jVZ0HfHKlKkpgkaiK1O3eeQJRSy3r5o4Img1W6OztebrfPP1muOmcF9NwK1xigA8e3e69cirzI4MPWRnCJ7ilOMr2N8eO65SZNSkkdQJh3OXNe650gsg9+N7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785670; c=relaxed/simple;
	bh=h3jAjWv4f2VBSaEsrzynmnPKzRILrDbo1m+jK1ogilU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g6pC6FFPBpmrvrqmUx8Gh9KdO69kV7EajbOwgBVUZzmHCwz/G/eddhTK8/k8JURYWAt7fLkD26wiMbLzZRD4XXPlO7QjnaE1aA3Cw34y6bS+RtaNL0J0iHCR1u0RTFqGGqzcieos2ceQq32xOWT5JppcUMmKLPxMQVFWhBg7grk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T00P74WZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T00P74WZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97C73C2BCF7;
	Thu, 23 Jul 2026 05:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784785669;
	bh=h3jAjWv4f2VBSaEsrzynmnPKzRILrDbo1m+jK1ogilU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=T00P74WZH9CHBgCVYlc8VPNrmkOvigtGDT2v8hs6C/VURgwXYv8l3JC1GlBA/HOke
	 51GHNsQlgKF9J+cKvbqK0HtAV9m2q1IJe4a97Gmc+rr0mEXi59qG2UBihVJSP6q4z2
	 4gO4Bl/Pw2Sab2iUcstsA/AcgF0EOOMS2pIaoQQST3TK8HLEWuY8Og1wRH4uAiMsQU
	 m8B0ktkyKHL7z4bjlEMWeQv9Y3bZbZPv3DkJo6aIKjPnAqfmM6BFT6ePq9AqXYr/oh
	 LGzXw/a0FHgz8REd49zWoCVualoIhEScoKFe0bGlvWIgzHLdMo2UyMdZ3obTa28HgU
	 3XH8nIhp3HwiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD44C4453E;
	Thu, 23 Jul 2026 05:47:49 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH 0/2] ceph: GFP_NOFS fix for cap flush writeback recursion
Date: Thu, 23 Jul 2026 13:47:41 +0800
Message-Id: <20260723-b4-gfp_nofs-v1-0-c06b40354ec9@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNj3SQT3fS0gvi8/LRi3dREsxRDQ6NEI1NzAyWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgDljxfdbwAAAA==
X-Change-ID: 20260723-b4-gfp_nofs-ea6d112a2570
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784785666; l=1233;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=h3jAjWv4f2VBSaEsrzynmnPKzRILrDbo1m+jK1ogilU=;
 b=sWjGhZ0x9rbGaHxjfOGNqZQuehGz8fj+ExQSVkUdBgNQ6WoousUrHkMOVDLKH/wQZ9UrVyOTC
 1Q+3bmG5frwC14Er5A8TvH8Pe1QtwfAvqPzupQT9D0fSTeRSXbt+Vb5
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

These two patches fix GFP flag issues in the filesystem I/O paths
discovered while reviewing Max Kellermann's "ceph: avoid fs reclaim
while using current->journal_info" fix.

The first patch is a real fix: ceph_alloc_cap_flush() is called from
ceph_writepages_start() inside the writeback layer, but uses GFP_KERNEL.
Direct reclaim triggered by this allocation can re-enter the writeback
path via the shrinker, causing recursive writeback and potential stack
overflow.  Fix it to use GFP_NOFS, consistent with other allocations in
the same writepages path.

The second patch is a cleanup: __ceph_pool_perm_get() had three
allocations using GFP_NOFS and one using GFP_KERNEL, despite the
function only being called from user I/O paths where GFP_NOFS is
unnecessary.  Use GFP_KERNEL consistently.

---
Xiubo Li (2):
      ceph: use GFP_NOFS for cap flush allocation in writeback path
      ceph: use GFP_KERNEL consistently in __ceph_pool_perm_get()

 fs/ceph/addr.c | 6 +++---
 fs/ceph/caps.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 0b79edbeed72d6c75987b5b402edeafceb4d080d
change-id: 20260723-b4-gfp_nofs-ea6d112a2570

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


