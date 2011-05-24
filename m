From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH v4 0/4] rbd improvements
Date: Tue, 24 May 2011 11:51:14 -0700
Message-ID: <1306263078-18089-1-git-send-email-josh.durgin@dreamhost.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org, qemu-devel@nongnu.orgkvm@vger.kernel.orgqemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>, Christian Brunner <chb@muc.de>
List-Id: ceph-devel.vger.kernel.org

This patchset moves the complexity of the rbd format into librbd and
adds truncation support.

Changes since v3:
 * trivially rebased
 * updated copyright header

Changes since v2:
 * return values are checked in rbd_aio_rw_vector
 * bdrv_truncate added

Josh Durgin (4):
  rbd: use the higher level librbd instead of just librados
  rbd: allow configuration of rados from the rbd filename
  rbd: check return values when scheduling aio
  rbd: Add bdrv_truncate implementation

 block/rbd.c       |  892 +++++++++++++++++++----------------------------------
 block/rbd_types.h |   71 -----
 configure         |   33 +--
 3 files changed, 333 insertions(+), 663 deletions(-)
 delete mode 100644 block/rbd_types.h

-- 
1.7.2.3

