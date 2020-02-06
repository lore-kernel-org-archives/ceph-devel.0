From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 5.6-rc1
Date: Thu,  6 Feb 2020 10:48:04 +0100
Message-ID: <20200206094804.29473-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:

  Linux 5.5 (2020-01-26 16:23:03 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.6-rc1

for you to fetch changes up to 3325322f773bae68b20d8fa0e9e8ebb005271db5:

  rbd: set the 'device' link in sysfs (2020-01-27 16:53:40 +0100)

----------------------------------------------------------------
We have:

- a set of patches that fixes various corner cases in mount and umount
  code (Xiubo Li).  This has to do with choosing an MDS, distinguishing
  between laggy and down MDSes and parsing the server path.

- inode initialization fixes (Jeff Layton).  The one included here
  mostly concerns things like open_by_handle() and there is another
  one that will come through Al.

- copy_file_range() now uses the new copy-from2 op (Luis Henriques).
  The existing copy-from op turned out to be infeasible for generic
  filesystem use; we disable the copy offload if OSDs don't support
  copy-from2.

- a patch to link "rbd" and "block" devices together in sysfs (Hannes
  Reinecke)

And a smattering of cleanups from Xiubo, Jeff and Chengguang.

----------------------------------------------------------------
Arnd Bergmann (1):
      rbd: work around -Wuninitialized warning

Chengguang Xu (2):
      ceph: delete redundant douts in con_get/put()
      ceph: remove unnecessary assignment in ceph_pre_init_acls()

Hannes Reinecke (1):
      rbd: set the 'device' link in sysfs

Jeff Layton (6):
      ceph: drop unused ttl_from parameter from fill_inode
      ceph: ensure we have a new cap before continuing in fill_inode
      ceph: don't clear I_NEW until inode metadata is fully populated
      ceph: close holes in structs ceph_mds_session and ceph_mds_request
      ceph: print name of xattr in __ceph_{get,set}xattr() douts
      ceph: move net/ceph/ceph_fs.c to fs/ceph/util.c

Luis Henriques (1):
      ceph: use copy-from2 op in copy_file_range

Xiubo Li (14):
      ceph: fix mdsmap cluster available check based on laggy number
      ceph: only choose one MDS who is in up:active state without laggy
      ceph: fix possible long time wait during umount
      ceph: add __send_request helper
      ceph: keep the session state until it is released
      ceph: check availability of mds cluster on mount after wait timeout
      ceph: retry the same mds later after the new session is opened
      ceph: only touch the caps which have the subset mask requested
      ceph: print dentry offset in hex and fix xattr_version type
      ceph: add possible_max_rank and make the code more readable
      ceph: remove the extra slashes in the server path
      ceph: rename get_session and switch to use ceph_get_mds_session
      ceph: allocate the correct amount of extra bytes for the session features
      ceph: print r_direct_hash in hex in __choose_mds() dout

 drivers/block/rbd.c                  |   4 +-
 fs/ceph/Makefile                     |   2 +-
 fs/ceph/acl.c                        |   4 +-
 fs/ceph/caps.c                       |   3 +-
 fs/ceph/debugfs.c                    |   2 +-
 fs/ceph/dir.c                        |   4 +-
 fs/ceph/file.c                       |  11 ++-
 fs/ceph/inode.c                      |  47 +++++++---
 fs/ceph/mds_client.c                 | 171 ++++++++++++++++++++---------------
 fs/ceph/mds_client.h                 |  39 ++++----
 fs/ceph/mdsmap.c                     |  91 +++++++++++--------
 fs/ceph/super.c                      | 128 ++++++++++++++++++++++----
 fs/ceph/super.h                      |   2 +
 net/ceph/ceph_fs.c => fs/ceph/util.c |   4 -
 fs/ceph/xattr.c                      |   7 +-
 include/linux/ceph/mdsmap.h          |  11 ++-
 include/linux/ceph/osd_client.h      |   1 +
 include/linux/ceph/rados.h           |   2 +
 net/ceph/Makefile                    |   2 +-
 net/ceph/osd_client.c                |  18 ++--
 20 files changed, 360 insertions(+), 193 deletions(-)
 rename net/ceph/ceph_fs.c => fs/ceph/util.c (94%)
