From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 0/3] Ceph fscache: Fix kernel panic due to a race
Date: Thu, 26 Dec 2013 06:29:25 -0800
Message-ID: <cover.1388066937.git.liwang@ubuntukylin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Milosz Tanski <milosz@adfin.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>
List-Id: ceph-devel.vger.kernel.org

From: Yunchuan Wen <yunchuanwen@ubuntukylin.com>

The following scripts could easily panic the kernel,

#!/bin/bash
mount -t ceph -o fsc MONADDR:/ cephfs
rm -rf cephfs/foo
dd if=/dev/zero of=cephfs/foo bs=8 count=512
echo 3 > /proc/sys/vm/drop_caches
dd if=cephfs/foo of=/dev/null bs=8 count=1024

This is due to when writing a page into fscache, the code will
assert that the write position does not exceed the 
object->store_limit_l, which is supposed to be equal to inode->i_size.
However, for current implementation, after file writing, the 
object->store_limit_l is not synchronized with new 
inode->i_size immediately, which introduces a race that if writing
a new page into fscache, will reach the ASSERT that write position
has exceeded the object->store_limit_l, and cause kernel panic. 
This patch fixes it.

Yunchuan Wen (3):
  Ceph fscache: Add an interface to synchronize object store limit
  Ceph fscache: Update object store limit after writing
  Ceph fscache: Wait for completion of object initialization

 fs/ceph/cache.c |    1 +
 fs/ceph/cache.h |   10 ++++++++++
 fs/ceph/file.c  |    3 +++
 3 files changed, 14 insertions(+)

-- 
1.7.9.5
