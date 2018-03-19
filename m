From: KAMEI Hitoshi <hitoshi.kamei.xm@hitachi.com>
Subject: [PATCH 0/2] rbd: thick-provision image support
Date: Mon, 19 Mar 2018 21:00:33 +0900
Message-ID: <5AAFA661.60103@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: idryomov@gmail.com, sage@redhat.com, elder@kernel.org, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

This patch series adds the thick-provision image support to
/drivers/block/rbd.c relating to https://github.com/ceph/ceph/pull/18317.
The rbd will not issue the discard operation to thick-provision
images, if applied.

The rbd should not discard any allocated blocks of thick-provision
image to ensure writing data to rbd images. So this patch
prevents from discarding allocated blocks on thick-provision
image.

This patch series creates sysfs file to manipulate thick-provision
status. If users write "1" to /sys/bus/rbd/devices/<dev-id>/thick,
then the image is changed to thick-provision image. And if users
write "0" to it, then the image is changed to thin-provision
image. I will add the code changing status for the rbd map command.

Hitoshi Kamei (2):
  rbd: RBD_DEV_FLAG_THICK rbd_dev_flags bit
  rbd: add 'thick' sysfs rbd device attribute

 Documentation/ABI/testing/sysfs-bus-rbd |  6 ++++++
 drivers/block/rbd.c                     | 37 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
2.15.1
