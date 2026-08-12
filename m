Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DFF352F86;
	Wed, 12 Aug 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520231; cv=none; b=nx+Ym7hjUU3Os4RKo0AK5Jhw5xbBDNxwJs8x55qmDffzpntX84pkJ5iQcgHdrQh99GPlA2d5bLRLQEZPdUWWagBmVnlktfF4kgPDEYLDiWe8R2GIuNQPK6c5nEcQNKQXccxJnVqN/ndd63864T8XtIOrfE3Psj+XRhZoHnF+Z+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520231; c=relaxed/simple;
	bh=lPd1dyt44kJS9TYiygd/17Cai4nHFrY1bP/DIL7DSBw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lrI2KHOoSaMtYBZFUwKbXzdp6AVnznisUq1K4su1qKjRphb5jG1yZc6D/dBSnM9kmIYFYm5ZcuamRXxCooLqv2Yz0TRAOWBeLws5jYhJsUeVVuOCWqGBKLDBMrLy0BGAO7Dsk6i2xZ+e2GQsa2tKG2rRweRoPymHTzYdMhNIygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLGfIpg3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLGfIpg3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A132DC2BCB9;
	Wed, 12 Aug 2026 07:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786520230;
	bh=lPd1dyt44kJS9TYiygd/17Cai4nHFrY1bP/DIL7DSBw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RLGfIpg34hTsqIoNpJkfr69GV8y5i3LaLgVjwg0cTHOXljkGTRUy6c0s2pJthoTDX
	 LISX5INA+539f+eEH1IDWPT4NlTtGVzOmeIKq34CSI/vqq5B+U5BBEaou7R1pDUmKs
	 dZvlZnD74cVuVSY0vlv0GznGdhQBFuiNBw3yMnIisYTUbOIlMOlyNUujImNDISGBk4
	 CLPYKlyLT7c2da47EiRcxwd7+4WiGK4+5htXCE7GV2Fy1UckWZnbF1fFG9h2HjbipR
	 aTa4a08W2P+Aqm0pxnY+Y5k+0waTjurXqF+g0TAqydhH2nJqaEjxZBJL2RlwxApY2Z
	 Cnx4BO6Yd3O3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802B1C5AD5A;
	Wed, 12 Aug 2026 07:37:10 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH v2 0/2] ceph: GFP_NOFS fix for cap flush writeback
 recursion
Date: Wed, 12 Aug 2026 00:36:24 -0700
Message-Id: <20260812-b4-gfp_nofs-v2-0-9574af8a417d@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBAFf4Xs2Zq2lBI98R+GGFq2UKMt6SKRE
 P5dwKvHSebNW4AweSS4ZgsknDz5GDaQpwxs34QOmW83Bsml5qXMmVGsc8M9REcMG90KIRtZlBy
 2xZDQ+c9Ru9U/prd5oB33xG70nsaY5uNuErv3vzwJxpnl2iieFwrtpbLPmeLZxhfU67p+AXSMA
 6+4AAAA
X-Change-ID: 20260723-b4-gfp_nofs-ea6d112a2570
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786520227; l=1503;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=lPd1dyt44kJS9TYiygd/17Cai4nHFrY1bP/DIL7DSBw=;
 b=LfxAsEhteWCI0ZT6I2rtSWc2kqYuzyfQW7MgpZAoOLvEDuBPsINPJOQx4yN/iuWaTNIOHsoVw
 xZETUmIzb1tBUKSmY+HdJ6x9dSp3UB755vq8GGn/ByiSC6LwntAvNKt
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

The second patch is a cleanup: __ceph_pool_perm_get() had five
allocations using GFP_NOFS and one using GFP_KERNEL, despite the
function only being called from user I/O paths where GFP_NOFS is
unnecessary.  Use GFP_KERNEL consistently.

---
Changes in v2:
- Convert the last two GFP_NOFS allocations (rd_req and perm) to GFP_KERNEL, covering all six call sites.
- Correct commit message count: s/four/six/.
- Link to v1: https://patch.msgid.link/20260723-b4-gfp_nofs-v1-0-c06b40354ec9@clyso.com

---
Xiubo Li (2):
      ceph: use GFP_NOFS for cap flush allocation in writeback path
      ceph: use GFP_KERNEL consistently in __ceph_pool_perm_get()

 fs/ceph/addr.c | 10 +++++-----
 fs/ceph/caps.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 0b79edbeed72d6c75987b5b402edeafceb4d080d
change-id: 20260723-b4-gfp_nofs-ea6d112a2570

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


