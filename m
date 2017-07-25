From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] ceph: make kcephfs use errseq_t for writeback error reporting
Date: Tue, 25 Jul 2017 10:50:40 -0400
Message-ID: <20170725145042.26219-1-jlayton@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

A couple of small patches to make cephfs use errseq_t for reporting
writeback errors. This ensures that when a writeback error occurs
that it is reported to all file descriptions that were open at the
time. The first patch is what fixes the error reporting.

The second patch (which should probably be considered an RFC) adds a new
fault injection switch for cephfs that makes it throw writeback errors
even when the writes succeed. I have an xfstest that uses this to help
test error handling behavior in cephfs.

Jeff Layton (2):
  ceph: use errseq_t for writeback error reporting
  ceph: pagecache writeback fault injection switch

 fs/ceph/addr.c    | 7 +++++++
 fs/ceph/caps.c    | 2 +-
 fs/ceph/debugfs.c | 8 +++++++-
 fs/ceph/super.h   | 2 ++
 4 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.13.3
