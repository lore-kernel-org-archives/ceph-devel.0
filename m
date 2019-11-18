From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH v3] ceph: add new obj copy OSD Op
Date: Mon, 18 Nov 2019 12:09:33 +0000
Message-ID: <20191118120935.7013-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

Hi,

Before going ahead with a pull-request for ceph I would like to make sure
we're all on the same page regarding the final fix for this problem.
Thus, following this email, I'm sending 2 patches: one for ceph OSDs and
the another for the kernel client.

* osd: add new 'copy-from-notrunc' operation
  This patch shall be applied to ceph master after reverting commit
  ba152435fd85 ("osd: add flag to prevent truncate_seq copy in copy-from
  operation").  It adds a new operation that will be exactly the same as
  the original 'copy-from' operation, but with the extra 2 parameters
  (truncate_{seq,size})

* ceph: switch copy_file_range to 'copy-from-notrunc' operation
  This will make the kernel client use the new OSD op in
  copy_file_range.  One extra thing that could probably be added is
  changing the mount options to NOCOPYFROM if the first call to
  ceph_osdc_copy_from() fails.

Does this look good, or did I missed something from the previous
discussion?

(One advantage of this approach: the OSD patch can be easily backported!)

Cheers,
-- 
Luis

Luis Henriques (1):
  osd: add new 'copy-from-notrunc' operation

 src/include/rados.h     |  1 +
 src/osd/OSD.cc          |  3 ++-
 src/osd/PrimaryLogPG.cc | 24 +++++++++++++++++++-----
 3 files changed, 22 insertions(+), 6 deletions(-)

  ceph: switch copy_file_range to 'copy-from-notrunc' operation

 fs/ceph/file.c                  |  3 ++-
 include/linux/ceph/osd_client.h |  1 +
 include/linux/ceph/rados.h      |  1 +
 net/ceph/osd_client.c           | 18 ++++++++++++------
 4 files changed, 16 insertions(+), 7 deletions(-)
