Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F63352010;
	Wed, 12 Aug 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520231; cv=none; b=lyaTe85UW/EC1NN/o80Idl4V+LnT7S28CguhvkpGD+AlXonuuHsWv6z213/aVag/iWOL4T0jWrwu2JhlwE2pFEwtTpmZIlLkKjRndiCwNfh8EHGjYgx29XFOJKl6Lt8FtHaf0DO0SxoMNsaHv4o1VWICB+MhMuuaGTwgXFZkyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520231; c=relaxed/simple;
	bh=skjiBnbamJVZ+JXGpDfVX2zwPyN41yjBBcbtxaclJv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DlYd+1EPD7M57Nh8S+CCu42Uq8uWrwv21sqECylIDgkLlwKoBGLqkxB2z0uQoaJJkLPV6shKxRyVVZ/PvEqyaJct4cg7quJvwpm5HkEVwJF0S0lX/rvls1b4rEzr57IdQAFIQVmuZ7Wn13vQeaNZX+fEs5aNMxhXJf9w9PqBIZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCq6ib/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCq6ib/1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADFD4C2BCF7;
	Wed, 12 Aug 2026 07:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786520230;
	bh=skjiBnbamJVZ+JXGpDfVX2zwPyN41yjBBcbtxaclJv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GCq6ib/1nCxc98C32Y/4y7wi1rR6lS6ZoO3YG1WikL7GeyD58BujYkX8J2W0JmhzA
	 RpTVqX1kGqwr9M+B9Qa52+Hc5Eh81bACfnhzmObL9XbtQTjWYFyt3Cg1ZfwvkWge5h
	 uhE5KSNud/XKfH5J+Ey4v7kl9/2yhk5DrsqTGXAE0aMI1ecN661U43Z8CbMuXsl1Xr
	 lNeo9adDTg6plGBqXbi0B+2VDVrxnaai7JP7DFftFa0KXZVxRYlSIGdGH6/MFkLquY
	 sDQzm4doKn0mu747QvsJUh4h2p6hcE6spHL5Q8WlLXlJHE3C4wP0dr53tLrpo5qTJy
	 4ooOcI2WGpewg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90131C5B56A;
	Wed, 12 Aug 2026 07:37:10 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Wed, 12 Aug 2026 00:36:25 -0700
Subject: [PATCH v2 1/2] ceph: use GFP_NOFS for cap flush allocation in
 writeback path
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-b4-gfp_nofs-v2-1-9574af8a417d@clyso.com>
References: <20260812-b4-gfp_nofs-v2-0-9574af8a417d@clyso.com>
In-Reply-To: <20260812-b4-gfp_nofs-v2-0-9574af8a417d@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786520227; l=1682;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=ZrpOLLgIzASawCWfTKDXlCq3HzO5pZbOM91CKtXE5rg=;
 b=qQMe7Ztk2zNiZG7RoGSa5/D3k5SB+nAFvpLr9XdWLUIxKZjRIlrYLxu8vEM8ummbjX8arKwiF
 aS37qyBgIMQALI/LG0GQuGUrGAwA+mNFRQ3lC+itPf8UAFVj3V2LTKe
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


