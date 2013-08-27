From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH 0/2] Fscache cleanup and fix
Date: Tue, 27 Aug 2013 19:08:31 -0400
Message-ID: <cover.1377644443.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:43433 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab3H0XI1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 19:08:27 -0400
Received: by mail-qe0-f48.google.com with SMTP id 1so3009983qec.35
        for <ceph-devel@vger.kernel.org>; Tue, 27 Aug 2013 16:08:27 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, zheng.z.yan@intel.com

Sage,

These are the changes you requested. I eliminated the use of ifdefs in the C
code. It's all self contained in cache.[ch] and in the case of it being
disabled becomes a nop.

Also, I found a small bug where we would not free the invalidate queue on
unmount. It's split into it's own commit.

Finally, I saw that you had a hard time building it without the kernel flag
enabled. So I made sure to test a config with fscache for Ceph disabled right
before sping things.

The commits are from my branch (which is based on top of the main testing
branch) from my repo:

    https://adfin@bitbucket.org/adfin/linux-fs.git branch: wip-ceph-fscache

Best,
- Milosz

Milosz Tanski (2):
  ceph: Do not leak fscache workqueue
  ceph: fscache cleanup

 fs/ceph/cache.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 fs/ceph/cache.h | 68 +++++++++++++++++++------------------------
 fs/ceph/inode.c | 61 +-------------------------------------
 fs/ceph/super.c | 22 ++++----------
 fs/ceph/super.h |  1 -
 5 files changed, 115 insertions(+), 127 deletions(-)

-- 
1.8.1.2

