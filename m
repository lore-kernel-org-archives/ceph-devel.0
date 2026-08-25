Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC240245F;
	Tue, 25 Aug 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659840; cv=none; b=e2hTQe4WAVI8xo7yPk4YlXWpjRHmQdguNjMXYu1Z0SwnhtLTC/jXr1FNuJ0vU1ncX9S5LMVN0w9DNUDxnulMT5HZJVhtr5DVZ9wUlWzkr3aB19QiZA+jBcRWfeXP6egLV0f5gA3N//arThuz0lRKy8yObWuordg4YarM4Oymud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659840; c=relaxed/simple;
	bh=6nRgB4Mrchp0McGdCqY4rzE7zCJd5Il6xnZ+SRgHe+8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HjAM/nHcQj5Mj6LQv7DswklS/TY/LeC2G8aBOGD+2WRfd0sBzX2P8qihYdt6qB1APf78Cnu6CVDTG78/xfPhe94p+5s2AcmoqKQhtIYHlJMSdz7+1DNyfsqC6eSFzQ9n2z73v/H3bf6gAKW42W/uVaeTmk4UBCdVyB31NW7Li8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEBc9AzF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEBc9AzF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FD39C2BCC7;
	Tue, 25 Aug 2026 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787659839;
	bh=6nRgB4Mrchp0McGdCqY4rzE7zCJd5Il6xnZ+SRgHe+8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IEBc9AzFvCahC7tZzUyt1DkR9TkXwqOyQUpRIRZhwecExDQTApBP4xq5N1g9wXZwg
	 9qRrAzF1Nc7D3n2eBHNlapFwz686D1xl1VxBwFqYwCKjuKDdlo8soYQtlXvARozDUh
	 VodF3Ia2bpm04syljd79EdGumrl0M34HGyXutjgg1/BdNC4nlO15yq33e1YsxqXIzD
	 WuBB+c+CovQFNUMN+yPr6aNHnNYaU2M3A6o6FvJ52akajMKOQBooArSv5G0KJhOYhJ
	 GeHKW0okUbDcjn7i5EPRBx+vYN4azUpgbgodgKQ1QkN02SOHqRhoYzLedyOvPNcAcX
	 qdpF++QxW5bsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBEBC61DBE;
	Tue, 25 Aug 2026 12:10:39 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH v5 0/2] ceph: add 'lazyio' mount option to kclient
Date: Tue, 25 Aug 2026 05:10:35 -0700
Message-Id: <20260825-lazyio-v5-0-65118679d6fa@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNTQ7CIBQE4KsY1mJ4UH7qynsYFwVeFaNiijbWp
 neX1qQaXU4y30xPEjYBE1kvetJgG1KIlxzkckHcobrskQafM+GMK6a4pKfq2YVIVWl0rYWTUtc
 kl68N1uExDW1375zu9ojuNuqxcQjpFptuemph7P2NtkCBeguCaaNN6f3GnboUVy6eyTja8g/TD
 GbGMyudUtqowjBpf5n4MAPlzERmHACYF9oVFn9Z8cU4m1mRmWJgEQEr7sw3G4bhBZ9WvUhTAQA
 A
X-Change-ID: 20260625-lazyio-6987f73c557f
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787659836; l=5780;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=6nRgB4Mrchp0McGdCqY4rzE7zCJd5Il6xnZ+SRgHe+8=;
 b=QvwAOK46T8vj5/yyRJvgWaiiGt3pQRDTQYHM/F/9kkJnAMK04LJyqpDHoXUXvvQsotR6EtOod
 +G6nZdaKmmABd98VKijRKgNAQ1wAErhg0tBrrpEYkr8TKLL8i9x5PQE
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

The following is a test report:

=== LazyIO Multi-Client Read Test ===
(B writes → MDS revokes CACHE from A; lazyio keeps LAZYIO → buffered reads)

  nolazyio: 200 MB in 0.63s -> 319.8 MB/s
  lazyio  : 200 MB in 0.24s -> 840.3 MB/s

=== IO500 tool ior test: ===
        nolazyio        lazyio
Write:  74.49 MB/s  ->  185.24 MB/s

Link: https://tracker.ceph.com/issues/77594
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
Changes in v5:
- Do the CACHE/BUFFER -> LAZYIO used-cap substitution inside __prep_cap()
  so that the FLUSH paths (try_flush_caps(), __kick_flushing_caps()) can
  no longer ack a LAZYIO revocation while the page cache is still
  populated.  ceph_fsync() hit this easily: file_write_and_wait_range()
  leaves clean cached pages behind and try_flush_caps() runs right after.
- Apply that substitution per cap rather than once per inode in
  ceph_check_caps().  On a multi-MDS setup a non-auth cap revoking CACHE
  without holding LAZYIO would otherwise see (revoking & cap_used) == 0
  and ack the revocation.
- Only keep the page cache across a CACHE revocation when every opener is
  lazy (__ceph_all_opens_lazy()), and gate the used-cap substitution the
  same way while LAZYIO is still issued.  It has to stay unconditional
  once LAZYIO is itself being revoked, or the first item above comes back.
- Invalidate the faulting range in ceph_filemap_fault() when a non-lazy fd
  did not get CACHE and the page cache is only kept alive by LAZYIO.  An
  open that happens after the cache was retained sends no cap message, so
  nothing re-evaluates the inode-level gate above.
- Map LAZYIO back to CEPH_FILE_MODE_LAZY in get_used_fmode(), so the
  FMODE_WAIT_BIAS bias applied by __ceph_get_caps() no longer makes a lazy
  fd that is waiting for caps look like a non-lazy opener.
- Wake i_cap_wq in ceph_inode_shutdown() and fail ceph_page_mkwrite() with
  -ESTALE on shutdown, instead of waiting for caps that are never coming
  back.
- Link to v4: https://patch.msgid.link/20260820-lazyio-v4-1-601bee1ea2c8@clyso.com

Changed in V4:
- Base the CACHE/BUFFER -> LAZYIO used-cap substitution on implemented,
  not issued, so ceph_check_caps() holds the revoke ACK until writeback
  and invalidation complete; also queue writeback when revoking LAZYIO
  with dirty buffers.
- In try_get_cap_refs(), let LAZYIO substitute for missing CACHE/BUFFER
  for callers that request LAZYIO, without dropping issued CACHE/BUFFER
  refs when LAZYIO is unavailable.
- In handle_cap_grant(), invalidate on CACHE-then-LAZYIO revoke
  sequences and flush dirty data before ACKing when LAZYIO was
  covering it.
- In ceph_page_mkwrite(), wait for BUFFER/LAZYIO to be (re)granted
  before dirtying the folio instead of proceeding with WR alone.
- Request LAZYIO from the netfs read path (ceph_init_request) and
  ceph_renew_caps().
- Link to v3: https://patch.msgid.link/20260819-lazyio-v3-1-21110d37c4be@clyso.com

Changes in v3:
- Rework try_get_cap_refs() so a missing LAZYIO never makes a want
  unsatisfiable and silently drops CACHE/BUFFER refs (degrading to sync I/O).
- Add ceph_adjust_caps_used_for_lazyio() and report LAZYIO in used caps to
  the MDS when it stands in for CACHE/BUFFER.
- In handle_cap_grant(), flush dirty data before acking an LAZYIO revoke,
  and invalidate when either CACHE or LAZYIO is revoked and neither remains.
- Define CEPH_O_LAZY as 00020000 (matching src/include/ceph_fs.h) and send
  it in the open request flags.
- Link to v2: https://patch.msgid.link/20260701-lazyio-v2-1-9c667864805b@clyso.com

Changes in v2:
- Move LAZYIO fmode addition from ceph_init_file_info() to ceph_open() before
  ceph_caps_for_mode(), so the MDS sees LAZYIO in the wanted caps at open time.
  Also cover ceph_atomic_open() for the writer path.
- Add ceph_adjust_caps_used_for_lazyio() to substitute LAZYIO for CACHE/BUFFER
  in used caps reported to MDS when those caps are not issued.
- Gate try_get_cap_refs() LAZYIO substitution on want & CEPH_CAP_FILE_LAZYIO
  so a non-lazy fd cannot have its consistency guarantees weakened by a lazy fd
  on the same inode.
- Separate revocation handling in handle_cap_grant(): BUFFER revocation always
  triggers writeback; LAZYIO revocation triggers writeback only when dirty data
  is held (i_wrbuffer_ref/i_wb_ref); clean cached pages fall through to the
  existing invalidation path.
- Add LAZYIO to ceph_init_request() so readahead works for lazy fds.
- Fix fmode propagation: use fmode instead of req->r_fmode in ceph_open() MDS
  path, and set req->r_fmode |= CEPH_FILE_MODE_LAZY for both ceph_open() and
  ceph_atomic_open().
- Remove dead #ifdef O_LAZY blocks in ceph_flags_to_mode() and ceph_renew_caps().
- Link to v1: https://patch.msgid.link/20260625-lazyio-v1-1-db13078789dd@clyso.com

To: Ilya Dryomov <idryomov@gmail.com>
To: Alex Markuze <amarkuze@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Xiubo Li (2):
      ceph: wake up i_cap_wq waiters on inode shutdown
      ceph: add 'lazyio' mount option to kclient

 fs/ceph/addr.c               | 117 ++++++++++++++++++++++++++++
 fs/ceph/caps.c               | 177 ++++++++++++++++++++++++++++++++++++++++---
 fs/ceph/file.c               |  33 ++++++--
 fs/ceph/inode.c              |   7 ++
 fs/ceph/super.c              |  15 ++++
 fs/ceph/super.h              |  17 +++++
 fs/ceph/util.c               |   4 -
 include/linux/ceph/ceph_fs.h |   1 +
 8 files changed, 351 insertions(+), 20 deletions(-)
---
base-commit: 9fc75b71fdd38465c76c6f6a884cdd4ae3c72d90
change-id: 20260625-lazyio-6987f73c557f

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


