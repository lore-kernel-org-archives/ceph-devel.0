From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [RFC 0/2] rbd authentication
Date: Wed,  9 Nov 2011 16:20:54 -0800
Message-ID: <cover.1320884065.git.josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47231 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab1KJAVk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 19:21:40 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, kwolf@redhat.com

These patches allow keys to be passed to rbd devices for
authentication via the same interface that qcow uses for encryption -
the monitor block_passwd command.

Since rbd cannot read anything from the cluster before authenticating,
the size of the device is unknown until the key is set. At this point,
the size can be refreshed as if the device were resized. This works
fine with the virtio driver, but other drivers, like ide, don't
implement the resize callback. What do you think is the best way to
solve this?

Josh Durgin (2):
  block: let bdrv_set_key be used for authentication
  rbd: implement bdrv_set_key

 block.c          |   27 +++++++---
 block.h          |    2 +-
 block/rbd.c      |  160 ++++++++++++++++++++++++++++++++++++++----------------
 block_int.h      |    3 +-
 blockdev.c       |    3 +-
 hmp-commands.hx  |    6 +-
 monitor.c        |   13 +++--
 qapi-schema.json |    7 ++-
 qemu-img.c       |    4 +-
 qerror.c         |   16 +++---
 qerror.h         |   12 ++--
 qmp-commands.hx  |    6 ++-
 12 files changed, 172 insertions(+), 87 deletions(-)

