Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196BF3A5E78;
	Thu, 23 Jul 2026 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785670; cv=none; b=sMtkrCEyWfXP94JTTqrvkZ8/eHG+QFX+iOFf37aRnmk7zjbLTDuBJKFnxIyUy2ABdpZcvdq7e8whCO1+AY5vvp3nrU+Gj/GVmHvnEJ85vcXhkiyzgoJsk7vz4SEJydWHffEmiJlNq3Ndw6siNswkNZr9ns3kFCl08d73Bv1FiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785670; c=relaxed/simple;
	bh=CXll1EiPEjNlLBcq56gY6WgtPQqGcuNi2FwH0MBb7b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMewF3/8UhPfPoWG2TDFj0qIWcVuZnvKTYnpoKqBFRbgvcdVHHI7vkauk3YJDxvmmtEFr0eHMUefcvrDhbV+LnslvsWevOdVY+Lr5k9YtmUPoPr2/EbDEH/UVU2wZQexQuCx6xmCFqDB7//w6eJnr24FMxp0N4zHEhRXH7/lYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLU5/jcG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLU5/jcG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B30C1C2BCC7;
	Thu, 23 Jul 2026 05:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784785669;
	bh=CXll1EiPEjNlLBcq56gY6WgtPQqGcuNi2FwH0MBb7b0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QLU5/jcGUdo8m8u+dnkuNadg3FpS1uPxEiExJ5sgkY6G4W1adBhWsktuCm1Z3atZq
	 t9e0Wv4TN5JpNBg4WNmmwyrEsCBCl2jtbhX/rDC7s0YVAe2Rcsx9Vg/6TevkRspTnB
	 9oZvcP+IbNLQetzo+yGdWJQ/qf2gB9TT/7FAum6OkhARqA+blwlbkJ1pZU5fz6iowE
	 LdjCZzPXWYX1cvVnNopXWfBexUW0mgVzwb5QNvCtGdzSiuRBnZGx0S4iDpPsSrMVua
	 yReuCnXwadj0Lsid9ZIvhtFfngIebKc77AqvClB7V8zi6RhEbFBSPQnz3ymYJz3+J8
	 cXKLk3Y0j0Jrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98480C531CB;
	Thu, 23 Jul 2026 05:47:49 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Thu, 23 Jul 2026 13:47:43 +0800
Subject: [PATCH 2/2] ceph: use GFP_KERNEL consistently in
 __ceph_pool_perm_get()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-b4-gfp_nofs-v1-2-c06b40354ec9@clyso.com>
References: <20260723-b4-gfp_nofs-v1-0-c06b40354ec9@clyso.com>
In-Reply-To: <20260723-b4-gfp_nofs-v1-0-c06b40354ec9@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784785666; l=1692;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=wLYsu77cBeEkfqrRltnBpmEAlrz6vICedFaEgwuS1YY=;
 b=CxLO/iRpEuiNm6INHXXt7v3pl9FjaKvZpoU0Mfa0PkCTICZe6YXYYTGA/L+FiSBwSQ1PlCRqJ
 ARjcS/8ik7RAmOh8a6IrMFtCYsVXn8BhEwjvvkKSzhREJ2Pn4RjZ9oP
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

__ceph_pool_perm_get() has four allocations for building OSD STAT
requests, three of which used GFP_NOFS and one (the page vector
allocation) used GFP_KERNEL, making them inconsistent.

The function is only called from ceph_try_get_caps() and
__ceph_get_caps(), both of which are in the user I/O path (read,
write, fallocate, mmap fault), not in the writeback path.  There is
no risk of recursive writeback, so GFP_NOFS is unnecessarily
restrictive.  Use GFP_KERNEL consistently for all four allocations.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/addr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e2da3ab9f808..d2ac3df47e97 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2479,12 +2479,12 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 		rd_req->r_base_oloc.pool_ns = ceph_get_string(pool_ns);
 	ceph_oid_printf(&rd_req->r_base_oid, "%llx.00000000", ci->i_vino.ino);
 
-	err = ceph_osdc_alloc_messages(rd_req, GFP_NOFS);
+	err = ceph_osdc_alloc_messages(rd_req, GFP_KERNEL);
 	if (err)
 		goto out_unlock;
 
 	wr_req = ceph_osdc_alloc_request(&fsc->client->osdc, NULL,
-					 1, false, GFP_NOFS);
+					 1, false, GFP_KERNEL);
 	if (!wr_req) {
 		err = -ENOMEM;
 		goto out_unlock;
@@ -2495,7 +2495,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 	ceph_oloc_copy(&wr_req->r_base_oloc, &rd_req->r_base_oloc);
 	ceph_oid_copy(&wr_req->r_base_oid, &rd_req->r_base_oid);
 
-	err = ceph_osdc_alloc_messages(wr_req, GFP_NOFS);
+	err = ceph_osdc_alloc_messages(wr_req, GFP_KERNEL);
 	if (err)
 		goto out_unlock;
 

-- 
2.53.0


