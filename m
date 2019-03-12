From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v2 0/2] fix quota subdir mounts
Date: Tue, 12 Mar 2019 14:20:17 +0000
Message-ID: <20190312142019.30936-1-lhenriques@suse.com>
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

Changes since v1:

- Loop to free mdsc->quotarealms_inodes_list list was moved further down
  where it's not possible to race with insertions.  This way there's no need
  to hold the spinlock anymore.

- Clarified comments regarding the get_quota_realm function 'retry'
  parameter, both in the function itself and in function
  ceph_quota_is_same_realm, where that param is set to 'false'

- Distinguish between 'realm->inode is NULL' and igrab failures, both in
  get_quota_realm and check_quota_exceeded

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

 fs/ceph/export.c     |  14 +++++-
 fs/ceph/mds_client.c |  15 ++++++
 fs/ceph/mds_client.h |   2 +
 fs/ceph/quota.c      | 106 +++++++++++++++++++++++++++++++++++++++----
 fs/ceph/super.h      |   3 ++
 5 files changed, 129 insertions(+), 11 deletions(-)
