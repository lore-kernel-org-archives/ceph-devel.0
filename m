From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 0/4] ceph: endianness fixes and sparse warning fixes
Date: Thu, 12 Jan 2017 11:12:41 -0500
Message-ID: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbdALQMu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 12 Jan 2017 11:12:50 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

Just a small set of patches to fix some stuff that sparse was
complaining about. Some of these look like real bugs however for
anyone trying to use ceph on a big endian arch.

Jeff Layton (4):
  ceph: fix endianness of getattr mask in ceph_d_revalidate
  ceph: fix endianness bug in frag_tree_split_cmp
  ceph: fix bogus endianness change in ceph_ioctl_set_layout
  ceph: fix bad endianness handling in parse_reply_info_extra

 fs/ceph/dir.c        | 5 +++--
 fs/ceph/inode.c      | 3 ++-
 fs/ceph/ioctl.c      | 4 ++--
 fs/ceph/mds_client.c | 9 +++++----
 4 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.7.4

