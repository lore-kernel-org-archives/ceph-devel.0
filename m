From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 0/2] ceph fscache: uncaching single no data page when error
Date: Thu, 19 Dec 2013 06:03:47 -0800
Message-ID: <cover.1387461299.git.liwang@ubuntukylin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Milosz Tanski <milosz@adfin.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Li Wang <liwang@ubuntukylin.com>
List-Id: ceph-devel.vger.kernel.org

Currently, if one new page allocated into fscache in readpage(), however, 
with no data read into due to error encountered during reading from OSDs, 
the slot in fscache is not uncached. This patch fixes this.

Li Wang (2):
  ceph: Introduce a routine for uncaching single no data page from
    fscache
  ceph: Uncaching no data page from fscache in readpage()

 fs/ceph/addr.c  |    1 +
 fs/ceph/cache.h |   13 +++++++++++++
 2 files changed, 14 insertions(+)

-- 
1.7.9.5
