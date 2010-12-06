From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v8)
Date: Mon, 06 Dec 2010 13:48:49 +0100
Message-ID: <4CFCDBB1.5000800@redhat.com>
References: <20101117214223.GA31321@sir.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200Ab0LFMrt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 Dec 2010 07:47:49 -0500
In-Reply-To: <20101117214223.GA31321@sir.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, kvm@vger.kernel.org

Am 17.11.2010 22:42, schrieb Christian Brunner:
> Here is another update for the ceph storage driver. It includes changes
> for the annotations Stefan made last week and a bit more things Sage
> discovered while looking over the driver again.
> 
> I really hope that this time we are not only close, but have reached
> a quality that everyone is satisfied with. - Of course suggestions for 
> further improvements are always welcome.
> 
> Regards,
> Christian
> 
> 
> RBD is an block driver for the distributed file system Ceph
> (http://ceph.newdream.net/). This driver uses librados (which
> is part of the Ceph server) for direct access to the Ceph object
> store and is running entirely in userspace (Yehuda also
> wrote a driver for the linux kernel, that can be used to access
> rbd volumes as a block device).
> ---
>  Makefile.objs     |    1 +
>  block/rbd.c       | 1059 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  block/rbd_types.h |   71 ++++
>  configure         |   31 ++
>  4 files changed, 1162 insertions(+), 0 deletions(-)
>  create mode 100644 block/rbd.c
>  create mode 100644 block/rbd_types.h

This lacks a Signed-off-by. Please merge Yehuda's fix for configure when
you resend the patch.

What's the easiest way to try it out? I tried to use vstart.sh and copy
the generated ceph.conf to /etc/ceph/ceph.conf so that qemu-img etc.
find the monitor address. However, that leads to a hang when I try "rbd
list" or "./qemu-img create -f rbd rbd:data/test.img 4G", so I seem to
be missing something.

The only thing I have achieved until now with my attempts of trying it
out (and trying wrong things, of course) is that I stumbled over the the
following segfault in librados:

Program received signal SIGSEGV, Segmentation fault.
Objecter::shutdown (this=0x0) at osdc/Objecter.cc:59
59        assert(client_lock.is_locked());  // otherwise event
cancellation is unsafe
(gdb) bt
#0  Objecter::shutdown (this=0x0) at osdc/Objecter.cc:59
#1  0x00007ffff7ca5ce4 in RadosClient::shutdown (this=0xa58a90) at
librados.cc:392
#2  0x00007ffff7ca8ccc in rados_deinitialize () at librados.cc:1770
#3  0x000000000043150c in rbd_create (filename=<value optimized out>,
options=<value optimized out>) at block/rbd.c:304
#4  0x0000000000405f10 in img_create (argc=5, argv=0x7fffffffde80) at
qemu-img.c:409
#5  0x0000003c9f01eb1d in __libc_start_main () from /lib64/libc.so.6
#6  0x0000000000403999 in _start ()

Kevin
