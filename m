From: Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH v2 00/11] ceph: convert to new FSCache API
Date: Fri, 31 Jul 2020 09:04:10 -0400
Message-ID: <20200731130421.127022-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbgGaNEX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:04:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: linux-cachefs@redhat.com, idryomov@gmail.com

This patchset converts ceph to use the new (not yet merged) FSCache API.
Trying to use fscache+ceph today usually results in oopses. With this
series, it seems to be quite stable.

Where possible, I've converted the code to use the new read helper,
which hides away a lot of the gory details of page handling, which I think
makes the resulting code clearer than it was.

It starts with a few cleanup/reorganization patches to prepare the code. I then
rip out most of the old ceph fscache helpers and replace them with new
ones for the new API.

The rest of the series then plugs buffered read/write caching support
back into the code, with the most of the read-side routines using the
fscache_read_helper.

This passes xfstests' quick group run with the cache disabled. With it
enabled, it passed most of it, but I hit some OOM kills on generic/531.
Still tracking that bit down, but we suspect the problem is in
fscache/cachefiles code and not in these patches.

This is based on top of David's latest fscache-iter branch:

    https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter

...my branch is here:

    https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/log/?h=ceph-fscache-iter

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

 fs/ceph/Kconfig |   4 +-
 fs/ceph/addr.c  | 939 +++++++++++++++++++++++++++---------------------
 fs/ceph/cache.c | 290 ++++-----------
 fs/ceph/cache.h | 106 ++----
 fs/ceph/caps.c  |  11 +-
 fs/ceph/file.c  |  13 +-
 fs/ceph/inode.c |  14 +-
 fs/ceph/super.h |   1 -
 8 files changed, 645 insertions(+), 733 deletions(-)

-- 
2.26.2
