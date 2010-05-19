From: Christian Brunner <chb@muc.de>
Subject: [RFC PATCH 0/1] ceph/rbd block driver for qemu-kvm
Date: Wed, 19 May 2010 21:20:53 +0200
Message-ID: <20100519192053.GC61706@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:51156 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214Ab0ESTUz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 May 2010 15:20:55 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org

Hi,

this patch is a block driver for the distributed file system Ceph
(http://ceph.newdream.net/). Ceph was included in the Linux v2.6.34
kernel. However, this driver uses librados (which is part of the Ceph
server) for direct access to the Ceph object store and is running entirely
in userspace. Therefore it is called "rbd" - rados block device.

The basic idea is to stripe a VM block device over (by default) 4MB objects
stored in the Ceph distributed object store.  This is very similar to what
the sheepdog project is doing, but uses the ceph server as a storage backend.
If you don't plan on using the entire ceph filesystem you may leave out the
metadata service of ceph.

Yehuda Sadeh helped me with the implementation and put some additional
usage information on the Ceph-Wiki (http://ceph.newdream.net/wiki/Kvm-rbd).
He has also written a Linux kernel driver to make an rbd image accessible as
a block device.

To compile the driver a recent version of ceph (>= 0.20.1) is needed and
you have to "--enable-rbd" when running configure.

Since our tests where quite promising, I would like to have feedback from
other qemu-kvm developers/users. If someone could check the AIO handling
of the driver I would be glad, too.

Thanks,
Christian

PS: The patch is based on git://repo.or.cz/qemu/kevin.git block

---
 Makefile          |    3 +
 Makefile.objs     |    1 +
 block/rados.h     |  376 ++++++++++++++++++++++++++++++++++
 block/rbd.c       |  585 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/rbd_types.h |   48 +++++
 configure         |   27 +++
 6 files changed, 1040 insertions(+), 0 deletions(-)
 create mode 100644 block/rados.h
 create mode 100644 block/rbd.c
 create mode 100644 block/rbd_types.h

