From: Jeff Layton <jlayton@samba.org>
Subject: [samba RFC PATCH 0/6] vfs:ceph: add support for new ceph_statx() interface to ceph vfs module
Date: Wed, 31 Aug 2016 09:01:08 -0400
Message-ID: <1472648474-3131-1-git-send-email-jlayton@samba.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:31397 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934150AbcHaNBz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 09:01:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: samba-technical@lists.samba.org
Cc: ira@wakeful.net, ceph-devel@vger.kernel.org

Posting as an RFC set as this should not be merged until the libcephfs
interfaces are in place.

This patchset should give the samba vfs ceph module support for a
real "birthtime" on files. It relies on a set of new interfaces
being added to ceph in this pull request:

    https://github.com/ceph/ceph/pull/10922

While that's being reviewed, I'd like to also put this set of patches
out here to get some eyes on them. Does the new ceph_statx() interface
seem ok? (Note that my ulterior motive here is to use this as a PoC that
we can point at for a similar kernel system call).

Note that while the set should be bisectable, birthtime handling may be
"iffy" in some of the interim points of the set, due to different calls
fetching and setting it in different places. The end result should be
consistent though.

I've also not given much thought to preserving birthtimes on "legacy"
ceph filesystems that don't have this support but that may have had it
set in the xattr. Opinions are welcome there. Should we try to do that
somehow?

Jeff Layton (6):
  vfs:ceph: add configure test for ceph_statx
  vfs:ceph: add init_stat_ex_from_ceph_statx
  vfs:ceph: convert cephwrap_stat to use ceph_statx
  vfs:ceph: change cephwrap_fstatx to use ceph_fstatx
  vfs:ceph: convert cephwrap_lstat to use ceph_statx
  vfs:ceph: allow vfs_ceph to set the btime using setattrx

 source3/modules/vfs_ceph.c | 216 ++++++++++++++++++++++++++++++++++++++-------
 source3/wscript            |   2 +
 2 files changed, 185 insertions(+), 33 deletions(-)

-- 
2.7.4

