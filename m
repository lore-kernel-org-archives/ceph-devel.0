From: Sage Weil <sage@inktank.com>
Subject: [PATCH 0/4] Ceph fixes for 3.12.y
Date: Mon, 30 Dec 2013 16:13:47 -0800
Message-ID: <1388448831-10324-1-git-send-email-sage@inktank.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>
List-Id: ceph-devel.vger.kernel.org

Hi,

These patches are for 3.12.y stable.  All have been retested and
reference the original commit.  They can also be pulled from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-stable-3.12.5

if that is preferred.

Thanks!
sage

Li Wang (1):
  ceph: allocate non-zero page to fscache in readpage()

Milosz Tanski (1):
  ceph: hung on ceph fscache invalidate in some cases

Yan, Zheng (2):
  ceph: cleanup aborted requests when re-sending requests.
  ceph: wake up 'safe' waiters when unregistering request

 fs/ceph/addr.c       | 2 +-
 fs/ceph/cache.c      | 3 +++
 fs/ceph/mds_client.c | 8 ++++++--
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
1.8.5.1
