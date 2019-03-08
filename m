From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 0/2] fix quota subdir mounts
Date: Fri,  8 Mar 2019 16:27:55 +0000
Message-ID: <20190308162757.9260-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

Hi,

As recently reported in the ceph-users mailing-list[1], the kernel client
behaves differently from the fuse client regarding mounting subdirs where
quotas are in effect.  I've also created a bug to track this issue[2].

The following patches are a possible way of fixing this issue.  The
performance impact should be close to zero if the mount is done in the
CephFS root inode.  When we're mounting subdirs, we may have extra
queries to the MDSs, depending on how many extra realms we'll need to
loop through.

Changes since RFC:

The 1st patch hasn't been changed since the initial RFC.  The 2nd patch
has been refactored to include the following changes:

- Zheng Yan's suggestions, i.e, move inode references from the realms to
  ceph_mds_client instance

- It now also handles other cases where an MDS lookup may need to be
  performed:
  * statfs when there are quotas
  * renames, to forbid cross-quota renames

[1] http://lists.ceph.com/pipermail/ceph-users-ceph.com/2019-February/033357.html
[2] https://tracker.ceph.com/issues/38482

Cheers,
--
Luís

Luis Henriques (2):
  ceph: factor out ceph_lookup_inode()
  ceph: quota: fix quota subdir mounts

 fs/ceph/export.c     | 14 ++++++-
 fs/ceph/mds_client.c | 14 +++++++
 fs/ceph/mds_client.h |  2 +
 fs/ceph/quota.c      | 91 +++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/super.h      |  3 ++
 5 files changed, 113 insertions(+), 11 deletions(-)
