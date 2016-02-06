From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc3
Date: Fri, 5 Feb 2016 21:19:41 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602052117560.23105@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the follow Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

We have a few wire protocol compatibility fixes, ports of a few recent 
CRUSH mapping changes, and a couple error path fixes.

Thanks!
sage


----------------------------------------------------------------
Dan Carpenter (1):
      ceph: checking for IS_ERR instead of NULL

Ilya Dryomov (6):
      crush: ensure bucket id is valid before indexing buckets array
      crush: ensure take bucket value is valid
      crush: add chooseleaf_stable tunable
      crush: decode and initialize chooseleaf_stable
      libceph: advertise support for TUNABLES5
      libceph: MOSDOpReply v7 encoding

Yan, Zheng (1):
      ceph: fix snap context leak in error path

 fs/ceph/file.c                     |  6 +++---
 include/linux/ceph/ceph_features.h | 16 +++++++++++++++-
 include/linux/crush/crush.h        |  8 +++++++-
 net/ceph/crush/mapper.c            | 33 ++++++++++++++++++++++++++-------
 net/ceph/osd_client.c              | 10 ++++++++++
 net/ceph/osdmap.c                  | 19 ++++++++++++++-----
 6 files changed, 75 insertions(+), 17 deletions(-)
