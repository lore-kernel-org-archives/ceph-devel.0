Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A83ACEEA;
	Thu, 23 Jul 2026 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785670; cv=none; b=HWmgCpVnxG8HfQ4CAwj16XOFi6oSiPAe4RhCEO7Yf2Jk4ODYl+c29k+sHKM5B08oPvty3Iws+7LqLLM4whSNcXAXmQkPzSDSflCBj25y6zImZv9tXMGGGqL892EzulrjaiPEFGt2U9aVAPsSC3P/8Jhg0AnRQV3AXodVO39Z0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785670; c=relaxed/simple;
	bh=skjiBnbamJVZ+JXGpDfVX2zwPyN41yjBBcbtxaclJv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNqLgbL38E3D75t3AiBCQ4N6LbZi8FTWHErEVskyY90KZK44Mi+6rTMshVIq/LN1YtIW4+pLk0sCNIUqrLpmxPd7cOfOIek3TdCnssRva3oss1AMau3t4at2ZwWiiKAXpGGPjSLUuyuOCIwIwDHS6RCNBGIqGHtYBVmaZZQhh/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nel0VJ7v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nel0VJ7v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1A61C2BCC6;
	Thu, 23 Jul 2026 05:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784785669;
	bh=skjiBnbamJVZ+JXGpDfVX2zwPyN41yjBBcbtxaclJv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Nel0VJ7v9qcGNzs3BPKoGeavECk9fmxIX7Za3LGMwsJl3ErvZIF4x9W/ofEQJwv7g
	 gDo0uAgsOnPxNuklKqMtl/hwnEZ634DgipvIZDd1Oab8Z13XAmm2RSi2ABTgbf5FaV
	 ptdknvl5KkRndgMARi4CBo68PdxSNOh+GY3b4Bde1ZExz/t4A5wAnruEGZkccFKS9H
	 fJZQKuQrw6BKjde3NY7XNRF7NcDFcOrI+AuxqjOT+7fafwZT0aAfsWhD8JDGomacir
	 jwMRJuEaoHUL1vqqlQLUrukedcafxFVwZJCSV4K6K9YK+kR9yD7y+6mINntu7RWoyQ
	 3dTBo1Np3A3Mg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80716C44524;
	Thu, 23 Jul 2026 05:47:49 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Thu, 23 Jul 2026 13:47:42 +0800
Subject: [PATCH 1/2] ceph: use GFP_NOFS for cap flush allocation in
 writeback path
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-b4-gfp_nofs-v1-1-c06b40354ec9@clyso.com>
References: <20260723-b4-gfp_nofs-v1-0-c06b40354ec9@clyso.com>
In-Reply-To: <20260723-b4-gfp_nofs-v1-0-c06b40354ec9@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784785666; l=1682;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=ZrpOLLgIzASawCWfTKDXlCq3HzO5pZbOM91CKtXE5rg=;
 b=b2KftckOo4HLm6R9Gb4GDH6A7nK84KzexuI0nQCZZtZIMROqHAk1lKjYNUPCmRMwanHSnbxf5
 owGK/AVfqFVBI0yhSZoXQ/+hjauAbx0kJPxC3D070RMFTb7M+MTYNu0
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

ceph_alloc_cap_flush() is called from ceph_writepages_start() inside
the writeback layer, where other allocations in the same path
(ceph_osdc_alloc_request, ceph_osdc_alloc_messages) already use
GFP_NOFS.  A GFP_KERNEL allocation here can trigger direct reclaim
that recursively enters the filesystem writeback path:

  ceph_writepages_start()                       // inode A writeback
    ceph_alloc_cap_flush()
      kmem_cache_alloc(..., GFP_KERNEL)
        [direct reclaim]
          try_to_free_pages()
            shrink_slab()
              super_cache_scan()
                prune_icache_sb()
                  inode_lru_isolate()
                    iput() -> evict(inode_B)
                      [inode_B has dirty pages]
                      filemap_flush()
                        ceph_writepages_start()  // re-enters writeback
                          ceph_alloc_cap_flush()
                            -> RECURSION / STACK OVERFLOW

All 11 callers of ceph_alloc_cap_flush() are in write or writeback
contexts: writepages (x2), write_iter, fallocate, copy_file_range,
setxattr, setattr, and page_mkwrite.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index f8d898ad091e..cbaebeac06f7 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1875,7 +1875,7 @@ struct ceph_cap_flush *ceph_alloc_cap_flush(void)
 {
 	struct ceph_cap_flush *cf;
 
-	cf = kmem_cache_alloc(ceph_cap_flush_cachep, GFP_KERNEL);
+	cf = kmem_cache_alloc(ceph_cap_flush_cachep, GFP_NOFS);
 	if (!cf)
 		return NULL;
 

-- 
2.53.0


