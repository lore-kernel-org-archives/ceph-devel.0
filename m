From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph updates and fixes for 3.13
Date: Sat, 23 Nov 2013 11:16:10 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311231052450.12812@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

I just returned from two weeks off the grid to discover I'd miscalculated 
and just missed the merge window.  If you're feeling inclined, there are a 
few non-fixes mixed into this this request (improved readv/writev, nicer 
behavior for unlinked files) that can be pulled from here:

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

If not, I have a fixes only branch here:

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus-bugs-only

These include a couple fixes to the new fscache code that went in during 
the last cycle (which will need to go stable@ shortly as well), a couple 
client-side directory fragmentation fixes, a fix for a race in the cap 
release queuing path, and a couple race fixes in the request abort 
and resend code.

Obviously some of this could have gone into 3.12 final, but I preferred to 
overtest rather than send things in for a late -rc, and then my travel 
schedule intervened--my apologies there.

Thanks!
sage


everything (for-linus):

----------------------------------------------------------------
Li Wang (1):
      ceph: allocate non-zero page to fscache in readpage()

Milosz Tanski (1):
      ceph: hung on ceph fscache invalidate in some cases

Yan, Zheng (8):
      ceph: remove outdated frag information
      ceph: handle frag mismatch between readdir request and reply
      ceph: drop unconnected inodes
      ceph: queue cap release in __ceph_remove_cap()
      ceph: set caps count after composing cap reconnect message
      ceph: handle race between cap reconnect and cap release
      ceph: cleanup aborted requests when re-sending requests.
      ceph: wake up 'safe' waiters when unregistering request

majianpeng (2):
      ceph: Implement writev/pwritev for sync operation.
      ceph: implement readv/preadv for sync operation

 fs/ceph/addr.c       |    2 +-
 fs/ceph/cache.c      |    3 +
 fs/ceph/caps.c       |   27 ++--
 fs/ceph/dir.c        |   11 +-
 fs/ceph/file.c       |  435 +++++++++++++++++++++++++++++++++++---------------
 fs/ceph/inode.c      |   59 ++++++-
 fs/ceph/mds_client.c |   61 +++++--
 fs/ceph/mds_client.h |    1 +
 fs/ceph/super.c      |    1 +
 fs/ceph/super.h      |    9 +-
 10 files changed, 442 insertions(+), 167 deletions(-)


or the bug fixes only (for-linus-bugs):

----------------------------------------------------------------
Li Wang (1):
      ceph: allocate non-zero page to fscache in readpage()

Milosz Tanski (1):
      ceph: hung on ceph fscache invalidate in some cases

Yan, Zheng (7):
      ceph: remove outdated frag information
      ceph: handle frag mismatch between readdir request and reply
      ceph: queue cap release in __ceph_remove_cap()
      ceph: set caps count after composing cap reconnect message
      ceph: handle race between cap reconnect and cap release
      ceph: cleanup aborted requests when re-sending requests.
      ceph: wake up 'safe' waiters when unregistering request

 fs/ceph/addr.c       |    2 +-
 fs/ceph/cache.c      |    3 +++
 fs/ceph/caps.c       |   27 +++++++++++++---------
 fs/ceph/dir.c        |   11 ++++++++-
 fs/ceph/inode.c      |   49 +++++++++++++++++++++++++++++++++++-----
 fs/ceph/mds_client.c |   61 +++++++++++++++++++++++++++++++++++++-------------
 fs/ceph/mds_client.h |    1 +
 fs/ceph/super.h      |    8 +------
 8 files changed, 121 insertions(+), 41 deletions(-)
