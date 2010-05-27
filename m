From: Christian Brunner <chb@muc.de>
Subject: [PATCH 0/1] ceph/rbd block driver for qemu-kvm (v2)
Date: Thu, 27 May 2010 21:09:18 +0200
Message-ID: <20100527190918.GA16854@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi,

Based on the review notes Blue Swirl sent us after my last mail, Yehuda
cleaned up the header files. The patch is much smaller now and I hope
that you accept it for inclusion.

To build it, you will need the testing (or unstable) git head of ceph 
now. The required header files will be part of the next release of 
ceph (0.20.3).

In case you didn't read my last posting, here is the short description
again:

This patch is a block driver for the distributed file system Ceph
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

Regards,
Christian

---
 Makefile          |    3 +
 Makefile.objs     |    1 +
 block/rbd.c       |  584 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/rbd_types.h |   52 +++++
 configure         |   27 +++
 5 files changed, 667 insertions(+), 0 deletions(-)
 create mode 100644 block/rbd.c
 create mode 100644 block/rbd_types.h
