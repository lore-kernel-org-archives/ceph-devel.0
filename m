From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 00/11 linux-next] super magic values consolidation
Date: Sun, 21 May 2017 17:39:47 +0200
Message-ID: <20170521153947.26281-1-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, fabf@skynet.be, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, pvfs2-developers@beowulf-underground.org, ceph-devel@vger.kernel.org, ocfs2-devel@oss.oracle.com
List-Id: ceph-devel.vger.kernel.org

This small patchset reorganizes magic.h and fixes filesystems
which defined locally super magic values.

Fabian Frederick (11):
  uapi: reorganize magic.h
  exofs: use magic.h
  ceph: use magic.h
  orangefs: use magic.h
  ubifs: use magic.h
  jfs: use magic.h
  ocfs2: use magic.h
  fuse: use magic.h
  freevxfs: use magic.h
  fs: define hfs super magic values globally
  hfsplus: export super magic value

 fs/ceph/super.h            |   4 +-
 fs/exofs/common.h          |   6 +--
 fs/freevxfs/vxfs.h         |   6 +--
 fs/fuse/control.c          |   3 +-
 fs/fuse/inode.c            |   3 +-
 fs/hfs/hfs.h               |   4 +-
 fs/hfsplus/hfsplus_raw.h   |   2 +-
 fs/hfsplus/part_tbl.c      |   2 -
 fs/jfs/jfs_incore.h        |   6 +--
 fs/ocfs2/ocfs2_fs.h        |   5 +--
 fs/orangefs/protocol.h     |   3 +-
 fs/ubifs/ubifs.h           |   4 +-
 include/uapi/linux/magic.h | 104 ++++++++++++++++++++++-----------------------
 13 files changed, 65 insertions(+), 87 deletions(-)

-- 
2.9.3


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
