From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH 0/2] fscache fixes for ceph
Date: Tue, 3 Sep 2013 19:10:24 -0400
Message-ID: <cover.1378249347.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, zheng.z.yan@intel.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On the whole the current iteration of FSCache on Ceph has been quite stable for
me. We've had it deployed on 4 clients running for a week in a row. I did run
into two small issues.

First one, I wasn't checking if the page was marked with private_2 before
asking FSCache to write to it. I've never seen this before and I only seen this
issue once.

The second issue is similar to what I was seeing before with pages marked
private_2 when we return them to the page cache. In this case the start_read()
in addr.c was returning the pages in the error path of the code. I have plugged
that issue. I only seen this one a handful of times across all clients.

As usual please apply the changes from repo located at:

  https://bitbucket.org/adfin/linux-fs.git branch: wip-ceph-fscache

Cheers,
- Milosz

Milosz Tanski (2):
  ceph: ceph_readpage_to_fscache didn't check if marked
  ceph: page still marked private_2

 fs/ceph/addr.c  |  1 +
 fs/ceph/cache.c |  3 +++
 fs/ceph/cache.h | 14 +++++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
1.8.1.2

