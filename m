From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Segmentation fault due to lacking NULL-check
Date: Fri, 12 Jul 2013 17:50:57 +0200
Message-ID: <51E025E1.8050103@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx03.stofanet.dk ([212.10.10.13]:49382 "EHLO mx03.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933072Ab3GLP6b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Jul 2013 11:58:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I have done a fresh install of Ubuntu 13.04 where I installed Ceph=20
0.61.4 from the binary packages on ceph.com.

I then installed Qemu 1.4.2 and tried to start a VM with an image on=20
RBD. Qemu segfaults with this backtrace:

#0  librbd::aio_flush (ictx=3D0x0, c=3D0x7f5f37ec6580) at=20
librbd/internal.cc:2693
#1  0x00007f5f360e67d8 in rbd_aio_flush (image=3D<optimized out>,=20
c=3D<optimized out>) at librbd/librbd.cc:1128
#2  0x00007f5f36d3bb5f in rbd_aio_flush_wrapper (comp=3D<optimized out>=
,=20
image=3D<optimized out>) at block/rbd.c:665
#3  rbd_start_aio (bs=3D<optimized out>, sector_num=3Dsector_num@entry=3D=
0,=20
qiov=3Dqiov@entry=3D0x0, nb_sectors=3Dnb_sectors@entry=3D0, cb=3D<optim=
ized out>,=20
opaque=3D<optimized out>, cmd=3Dcmd@entry=3DRBD_AIO_FLUSH) at block/rbd=
=2Ec:736
#4  0x00007f5f36d3bc2c in qemu_rbd_aio_flush (bs=3D<optimized out>,=20
cb=3D<optimized out>, opaque=3D<optimized out>) at block/rbd.c:782
#5  0x00007f5f36d1fdbb in bdrv_co_flush (bs=3D0x7f5f37e9e500) at block.=
c:4050
#6  bdrv_co_flush (bs=3D0x7f5f37e9e500) at block.c:4021
#7  0x00007f5f36d1fe00 in bdrv_flush_co_entry (opaque=3D0x7fffd5d21610)=
 at=20
block.c:4018
#8  0x00007f5f36d517da in coroutine_trampoline (i0=3D<optimized out>,=20
i1=3D<optimized out>) at coroutine-ucontext.c:138
#9  0x00007f5f329f44c0 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#10 0x00007fffd5d20e80 in ?? ()


Looking at the source code, I see that internal.cc does not check the=20
ictx parameter before it dereferences it in line 2693:

       CephContext *cct =3D ictx->cct;

As ictx has value NULL, the segfaults happens.


Another thing is that I don't understand what could cause qemu to call=20
this function with a NULL-parameter?

I have tested this also on another server running Ubuntu 12.10 and I se=
e=20
the exact same problem and backtrace.

By suggestion on IRC from joelio, I trying mapping the rbd with the=20
kernel mapper. This failed with the following:

[23504.239286] libceph: mon1 10.0.0.2:6789 feature set mismatch, my=20
40002 < server's 2040002, missing 2000000
[23504.239852] libceph: mon1 10.0.0.2:6789 socket error on read

What could this be caused by?

I have 0.61.4 on the client, and all osds and mons are also running 0.6=
1.4.


Thanks in advance,
--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
