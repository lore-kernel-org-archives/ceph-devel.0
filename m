From: Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH 00/11] ceph: convert to new fscache API
Date: Wed, 22 Jul 2020 06:55:00 -0400
Message-ID: <20200722105511.11187-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgGVKzN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:55:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, dwysocha@redhat.com, smfrench@gmail.com

Here's my first pass at a conversion to the new fscache API. It starts
with a few cleanup/reorganization patches to prepare the code. I then
rip out most of the old ceph fscache helpers and replace them with new
ones for the new API.

The last patches then plug buffered read and write support back into the
new infrastructure, with most of the read-side routines using the new
fscache_read_helper routines.

This passes xfstests' quick group run with the cache disabled. With it
enabled, it passed most of it, but I hit some OOM kills on generic/531.
Still tracking that bit down, but I suspect the problem is in
fscache/cachefiles code and not in these patches.

Note that this depends on a some patches that were not in David's last
posting of the fscache update, so all of this is not ready for merge. We
could probably take a few of the initial patches earlier though.

Jeff Layton (11):
  ceph: break out writeback of incompatible snap context to separate
    function
  ceph: don't call ceph_update_writeable_page from page_mkwrite
  ceph: fold ceph_sync_readpages into ceph_readpage
  ceph: fold ceph_sync_writepages into writepage_nounlock
  ceph: fold ceph_update_writeable_page into ceph_write_begin
  ceph: conversion to new fscache API
  ceph: convert readpage to fscache read helper
  ceph: plug write_begin into read helper
  ceph: convert readpages to fscache_read_helper
  ceph: add fscache writeback support
  ceph: re-enable fscache support

 fs/ceph/Kconfig |   3 +-
 fs/ceph/addr.c  | 939 +++++++++++++++++++++++++++---------------------
 fs/ceph/cache.c | 290 ++++-----------
 fs/ceph/cache.h | 106 ++----
 fs/ceph/caps.c  |  11 +-
 fs/ceph/file.c  |  13 +-
 fs/ceph/inode.c |  14 +-
 fs/ceph/super.h |   1 -
 8 files changed, 644 insertions(+), 733 deletions(-)

-- 
2.26.2
