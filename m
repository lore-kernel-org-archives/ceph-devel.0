From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH v4 0/4] rbd improvements
Date: Tue, 24 May 2011 11:51:14 -0700
Message-ID: <1306263078-18089-1-git-send-email-josh.durgin__41694.0715433613$1306263332$gmane$org@dreamhost.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: kvm@vger.kernel.org, qemu-devel@nongnu.orgkvm@vger.kernel.orgqemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>
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
