Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978235FF6E;
	Mon, 13 Jul 2026 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936021; cv=none; b=bYPnQNdJQUNDkp77TPMkQNZiLZH3IPxLWxbliWMDBgoxV7L8SWvabYFgWKIZ/NvSx3d0tFRkqWx2nPgKhvsd8tDBp9az6aZJ2jHDvyr8WUzbB/ky+1CmxJEzRxFutIPcnn5mLW0jPxdZjNu95OTU+3K7uIFjEM0c/82eamoCv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936021; c=relaxed/simple;
	bh=KZ+fkidvi42nkXB/n0WY+0pBKs4rc6ZQHLQ2OS9bDmc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O+Wtv6c/y2a7NMVfM5N3QM3n9lP5TZ9vEGe9BuJWvxnnDBoxfzdRazUC+6tU1reFeJZATF6G0CA003QKk4QA1X97/xqpozr5c9j3g4KRrkhepE5VJIepqVgUVLxjjr4O1RJUC3hgcyyUcYi3BIOQfBiMwbLHS9kX+n8+zXsBzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdoklGca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdoklGca"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC520C2BCB8;
	Mon, 13 Jul 2026 09:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783936021;
	bh=KZ+fkidvi42nkXB/n0WY+0pBKs4rc6ZQHLQ2OS9bDmc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WdoklGcancrOCnWHcg+NuRP+2VHqYur91/pBj2pQh+LX2a+yhpGlLayg74j7lDpIw
	 ESYOSDPPYyl0bHSKY0fPPAqt60HLTVQ+JwHZHPqZoCejIjJGLmvBQtW+bYg5QsbTOD
	 oQfgD/fsdPd4R2RGlqjYpMCMAehMGY+NI00JK85iHPTYsXIImOIdeHRjyKOq85ESQ5
	 il0AR2xmw4KrGeaqck0T6dNQse3KfOne/Fgrm5D6aLr/5jGAmFDDILvxs86AfWKgDC
	 HWMrTSYbhzRwlqSWliHUrqr43Tcf0I8e5gr1slcJjxBLrDWE/cUZcjiuXSqfK6gTA5
	 P0lLE+yLetiDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3D5C43458;
	Mon, 13 Jul 2026 09:47:00 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH 0/5] ceph: reduce mdsc->mutex contention in the cephfs
 kclient
Date: Mon, 13 Jul 2026 17:46:06 +0800
Message-Id: <20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMAyA4VchPdsE0DDjqxgPa6lSk8GyDkMkv
 LsTjt/h/1cwSSoGt2qFJB81ncaC5lQBD358CWpfDG3ddrVrzsgSBwy9MYY5y4JTzBr063MJ0Ym
 7eOqI+EpQFjHJU5d9f38ctpnewvn/hG37AazjqtKAAAAA
X-Change-ID: 20260713-ceph-mdsc-mutex-optimization-7e74ab6bbc8b
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783936018; l=1882;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=KZ+fkidvi42nkXB/n0WY+0pBKs4rc6ZQHLQ2OS9bDmc=;
 b=tOSLa1c3pDIWGTzSE0WJDO+iw4bGsyaTGnd29rW2QWrNFVBo0Au4onNhidaPX4Bkik39YWolC
 luajOeZQMMNAqI+ZJpUYtdXWZ1E550nP7FX5pS9vGJZz7repKWmOlev
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

This series reduces mdsc->mutex hold times from hundreds of
microseconds to tens of microseconds on the hot request-submit and
reply-handling paths.

The approach is incremental:
  1. Convert oldest_tid to atomic64_t so that __prepare_send_request()
     and __send_request() no longer need the mutex.
  2. Replace the request_tree rbtree with an xarray for O(1) lookups
     and internally-locked iteration.
  3. Add a dedicated wait_list_lock spinlock so wait-list operations
     no longer depend on the global mutex.
  4. Move mdsc->mutex acquisition inside __do_request(), then release
     it during the send phase (message construction and path walking),
     leaving only the brief setup/teardown under the lock.
  5. Narrow the mutex scope in replay_unsafe_requests() similarly.

Tested with concurrent readdir + stat on a 5000-file directory
(32 threads).  bpftrace measurements show:

                 before         after
  __do_request   354-2327 us    10-68 us    (34x)
  handle_reply   51-416 us     10-32 us    (13x)
  submit_request 89-211 us     10-41 us    (5x)

No functional changes intended.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
Xiubo Li (5):
      ceph: convert oldest_tid to atomic64_t
      ceph: replace the request_tree rbtree with an xarray keyed by r_tid.
      ceph: add wait_list_lock for wait-list serialization
      ceph: move mdsc->mutex into __do_request()
      ceph: narrow mdsc->mutex scope in replay_unsafe_requests

 fs/ceph/debugfs.c    |   6 +-
 fs/ceph/mds_client.c | 207 +++++++++++++++++++++++++++------------------------
 fs/ceph/mds_client.h |   8 +-
 3 files changed, 117 insertions(+), 104 deletions(-)
---
base-commit: 7e1f9e2cd2d0e780c394a4402c40e125109fec72
change-id: 20260713-ceph-mdsc-mutex-optimization-7e74ab6bbc8b

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


