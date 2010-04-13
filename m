From: Yehuda Sadeh <yehuda@hq.newdream.net>
Subject: [PATCH 0/6] Ceph RADOS block device
Date: Tue, 13 Apr 2010 16:35:35 -0700
Message-ID: <1271201741-9832-1-git-send-email-yehuda@hq.newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42093 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab0DNAZj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Apr 2010 20:25:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>

I just sent the following patchset to the linux kernel mailing list but forgot to CC our own ceph-devel, so here it is:

The following series implements a linux rados block device. It allows striping of data across rados, the ceph distributed block layer, and is binary compatible with Christian Brunner's kvm-rbd implementation. Similarly to the Sheepdog project, it stripes the block device across 4MB (or other configurable size) objects stored by the distributed object store, and enjoys all the rados features (high availability, scalability, etc.). Future versions will be able to use the rados snapshots mechanism.

A use case for this device would be to have some kind of a local file system created on it, and use it with conjuction of kvm to do migration and other related stuff. Another option would be to use it as data devices for other distributed file systems (e.g., ocfs2, gfs2).

The actual device driver is implemented in the last patch of the series, and is based on osdblk. Currently, it resides under the fs/ceph tree and does not exist as a separate module of its own, such that the ceph.ko module contains both the ceph file system and the rbd block device. Another option would be to have it as a separate module that resides under drivers/block, however, it would still depend on the ceph.ko module.

Any comments, questions, suggestions are more than welcome,

Yehuda

---
 fs/ceph/Makefile     |    3 +-
 fs/ceph/caps.c       |    2 +-
 fs/ceph/debugfs.c    |   11 +-
 fs/ceph/file.c       |   56 +++-
 fs/ceph/mds_client.c |   11 +-
 fs/ceph/messenger.c  |  185 +++++++--
 fs/ceph/messenger.h  |    5 +-
 fs/ceph/mon_client.c |   18 +-
 fs/ceph/msgpool.c    |    4 +-
 fs/ceph/osd_client.c |  193 ++++++---
 fs/ceph/osd_client.h |   27 ++
 fs/ceph/rbd.c        | 1224 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/rbd.h        |    8 +
 fs/ceph/super.c      |  165 ++++++--
 fs/ceph/super.h      |   31 ++-
 15 files changed, 1786 insertions(+), 157 deletions(-)
