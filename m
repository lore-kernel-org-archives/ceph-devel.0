Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F3310779;
	Tue, 11 Aug 2026 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786425477; cv=none; b=suPgrUAF6JPMdM2Te7Mc/PX2J3WxrY4yHCBtnezlN1IjXDsbwYeeUvtEmGxnRNF4p1YoCO4O9OCL9iS3DoX6xwb0mW0tw0dZmT8GAA3d+SPgnInGdJINnnuJFmq8sIs1rUGPHPo5Mn+/86zzWq7lLuu30veBS8khKwzEVxds4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786425477; c=relaxed/simple;
	bh=n1jT7e5mreJc0GffZUYf3wd9i4swpWsdI04Qzoj8pBc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hoDXLRpWP0QpIWwoGiSbA/MQJPaMES5e9CB0jRu5J3UKsIGo6H6yHeITQlXrMOvr+rOzYdQ0GPT0VJO0Ak+CNitKoWBVPBu+xHRo0rnnLOlqEJhWv9FTKSaoMwp8Kf2rypTGEzOBuBv2uBgwMjWwfTiRzTn0PEUBCw80PKMFaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxxQhc5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxxQhc5W"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFD0CC2BCC7;
	Tue, 11 Aug 2026 05:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786425477;
	bh=n1jT7e5mreJc0GffZUYf3wd9i4swpWsdI04Qzoj8pBc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nxxQhc5WIVRzHXEQcEKWkOrpCaC+ZTbo56zla5HzIkfrtFW/OHx1dqKC90CDGKY5h
	 Dr2w+FHWTl8l5IWl4nH9hsUweD60cV9b2CpLv0onBqmp39g3s/eiC2TF4etlfnybx2
	 3dEyVgMmuxu2KqOYNrIcnFB9lWJnq2Qr4G04yQssWdl1r6iDzRzB+pjqsOThBs0YoA
	 5oGy6Ruvp3dND+qyd6c3qePiHIgZNhKqFd754u2H6fhS9rolHFQRMnkFQEwsV/gyCs
	 KAMVxFDMRaTSYuAIpQcPSIsZEjkQ7p/GgnJNGVyapu7hx1MOyygVpI28gsXU97JowX
	 BpUPgGJjEbYKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C07C5AD7B;
	Tue, 11 Aug 2026 05:17:56 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH v3 0/5] ceph: reduce mdsc->mutex contention in the cephfs
 kclient
Date: Tue, 11 Aug 2026 13:17:44 +0800
Message-Id: <20260811-ceph-mdsc-mutex-optimization-v3-0-d031114419f4@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NTQ6CMBQE4KuQrq2h5afoynsYF+3jKTVCCS0NS
 Li7LW50pctJZr5ZiMVBoyXHZCEDem216ULIdgmBRnY3pLoOmfCUl6lgGQXsG9rWFmg7Opyo6Z1
 u9VO6MKQCRS5VqRRUigSiH/Cqp40/X97ZjuqO4KIZG422zgzz9u9Z7P155RlN6UFiIYFlBWT5C
 R6zNXswLYlXnn9ixQ+MRyzFiinBS8G/sHVdX75A+3knAQAA
X-Change-ID: 20260713-ceph-mdsc-mutex-optimization-7e74ab6bbc8b
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786425473; l=4810;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=n1jT7e5mreJc0GffZUYf3wd9i4swpWsdI04Qzoj8pBc=;
 b=WOJftx7Svm7qweaynd0K+Il0cL/PncoDpxvt6/KCqlfA8/cHqvy1lg7VREgSiNHYQwSgriSpR
 //ClcgYKcXrADPjLVa56f4Z5K/ONFONn2XZidC4mgiqSq9tPO9Nsx82
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

Benchmark results from test_i_caps (aggregate cache test):

  | Test                | Before   | After    | Improvement |
  |---------------------|----------|----------|-------------|
  | stat storm ST       | 692k/s   | 1,420k/s | +105% (2.1x)|
  | stat storm MT       | 722k/s   | 1,373k/s | +90%  (1.9x)|
  | open/close          | 403k/s   | 524k/s   | +30%        |
  | stat hot (cache)    | 353k/s   | 540k/s   | +53%        |
  | readdir             | 877/s    | 832/s    | ~0%         |
  | Total time          | 195s     | 121s     | -38%  (1.6x)|

The 2x stat throughput gain comes from __do_request() no longer
holding mdsc->mutex during the __send_request() phase, so dentry
path walking and message encoding in create_request_message()
run outside the lock.

No functional changes intended.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
Changes in v3:
- Restrict CEPH_FS to 64BIT to prevent xarray index truncation of
  u64 transaction IDs on 32-bit platforms, instead of the previous
  #if BITS_PER_LONG guard.  There are no 32-bit users.
  The survey: https://lore.kernel.org/ceph-devel/CAOJNxR+XiUxR1GNUgd8T18x2KH8kstWtpxwL-mwwE0i_qospJA@mail.gmail.com/T/#t
- Fix two plain reads of oldest_tid in the writer paths to use
  READ_ONCE() for consistency with the lockless read side.
- Replace the original replay_unsafe_requests() change with a
  proper collect-then-replay pattern: unsafe list entries and
  matching old xarray entries are gathered under the mutex with a
  reference taken, then replayed outside it.  Taking a reference
  ensures a concurrent reply handler cannot free an entry out
  from under the local-list iterator.
- Rewrite all commit messages as descriptive prose, focusing on
  the problem and the approach rather than enumerating modified
  functions.
- Link to v2: https://patch.msgid.link/20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com

Changes in v2:
- Add xa_store() error handling and bail out on failure in the submit path
- Guard xarray conversion with BITS_PER_LONG==64, fall back to rbtree on 32-bit
- Fix missing mutex_unlock on early-return path in __do_request()
- Move mutex_unlock before __wake_requests() and kick_requests() calls to
  avoid recursive lock acquisition
- Pin requests with ceph_mdsc_get_request() across lockless __send_request()
  in replay_unsafe_requests() to prevent use-after-free
- Keep mdsc->mutex held on 32-bit for rb_first()/rb_next() iteration in
  replay_unsafe_requests()
- Drop stale "called under mdsc->mutex" comment on __wake_requests()
- Add benchmark results from test_i_caps (2.1x stat throughput improvement)
- Link to v1: https://patch.msgid.link/20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com

To: Ilya Dryomov <idryomov@gmail.com>
To: Alex Markuze <amarkuze@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Xiubo Li (5):
      ceph: use READ_ONCE/WRITE_ONCE for oldest_tid
      ceph: replace the request_tree rbtree with an xarray keyed by r_tid
      ceph: add wait_list_lock for wait-list serialization
      ceph: move mdsc->mutex into __do_request()
      ceph: narrow mdsc->mutex scope in replay_unsafe_requests

 fs/ceph/Kconfig      |   1 +
 fs/ceph/debugfs.c    |   6 +-
 fs/ceph/mds_client.c | 253 +++++++++++++++++++++++++++++----------------------
 fs/ceph/mds_client.h |   6 +-
 4 files changed, 154 insertions(+), 112 deletions(-)
---
base-commit: 30c0913a2b44a66dc17283a88489b3f3e12f4327
change-id: 20260713-ceph-mdsc-mutex-optimization-7e74ab6bbc8b

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


