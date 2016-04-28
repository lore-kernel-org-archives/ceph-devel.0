From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc6
Date: Thu, 28 Apr 2016 10:08:57 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604281006521.25990@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There is a lifecycle fix in the auth code, a fix for a narrow race 
condition on map, and a helpful message in the log when there is a feature 
mismatch (which happens frequently now that the default server-side 
options have changed).

Thanks!
sage



----------------------------------------------------------------
Ilya Dryomov (3):
      libceph: make authorizer destruction independent of ceph_auth_client
      rbd: fix rbd map vs notify races
      rbd: report unsupported features to syslog

 drivers/block/rbd.c             | 52 +++++++++++++++---------------
 fs/ceph/mds_client.c            |  6 ++--
 include/linux/ceph/auth.h       | 10 +++---
 include/linux/ceph/osd_client.h |  1 -
 net/ceph/auth.c                 |  8 ++---
 net/ceph/auth_none.c            | 71 ++++++++++++++++++++++-------------------
 net/ceph/auth_none.h            |  3 +-
 net/ceph/auth_x.c               | 21 ++++++------
 net/ceph/auth_x.h               |  1 +
 net/ceph/osd_client.c           |  6 ++--
 10 files changed, 87 insertions(+), 92 deletions(-)
