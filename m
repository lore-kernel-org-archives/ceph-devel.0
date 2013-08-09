From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH 0/2] Cleanup invalidate page
Date: Fri, 9 Aug 2013 12:59:21 -0400
Message-ID: <cover.1375686804.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, sage@inktank.com, zheng.z.yan@intel.com
List-Id: ceph-devel.vger.kernel.org

Currently ceph_invalidatepage has is overly eger with it's checks which are
moot. The second change cleans up the case where offset is non zero.

Please pull the from:
  https://bitbucket.org/adfin/linux-fs.git wip-invalidatepage

This simple patchset came from the changes I made while working on fscache
support for cephfs. Per Sage's request I split this up into smaller bites for
testing and review.

Milosz Tanski (2):
  ceph: Remove bogus check in invalidatepage
  ceph: cleanup the logic in ceph_invalidatepage

 fs/ceph/addr.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

-- 
1.8.1.2

