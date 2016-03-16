From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: rbd_aio_flush cause guestos sync wirte poor iops?
Date: Wed, 16 Mar 2016 09:37:30 -0400 (EDT)
Message-ID: <578851288.38782223.1458135450823.JavaMail.zimbra@redhat.com>
References: <CAFU9Co=d-CstfhbiP3ztdpNTFp03SMGy8ciRw8xxBXkxw7TjRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:59496 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933804AbcCPNhc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 09:37:32 -0400
In-Reply-To: <CAFU9Co=d-CstfhbiP3ztdpNTFp03SMGy8ciRw8xxBXkxw7TjRw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Huan Zhang <huan.zhang.jn@gmail.com>
Cc: ceph-devel@vger.kernel.org

As previously mentioned [1], the fio rbd engine ignores the "sync" option.  You need to use "fsync=1" to issue a flush after each write to simulate what "sync=1" is doing.  When running fio within a VM against an RBD image, QEMU is not issuing sync writes to RBD -- it's issuing AIO writes and a AIO flush (as instructed by the guest OS).  Looking at the man page for O_SYNC [2], which is what that fio option enables in supported engines, that flag will act "as though each write(2) was followed by a call to fsync(2)". 

[1] http://lists.ceph.com/pipermail/ceph-users-ceph.com/2016-February/007780.html
[2] http://man7.org/linux/man-pages/man2/open.2.html

-- 

Jason Dillaman 


----- Original Message -----
> From: "Huan Zhang" <huan.zhang.jn@gmail.com>
> To: ceph-devel@vger.kernel.org
> Sent: Wednesday, March 16, 2016 12:52:33 AM
> Subject: rbd_aio_flush cause guestos sync wirte poor iops?
> 
> Hi,
>    We test sync iops with fio sync=1 for database workloads in VM,
> the backend is librbd and ceph (all SSD setup).'
>    The result is sad to me. we only get ~400 IOPS sync randwrite with
>    iodepth=1
> to iodepth=32.
>     But test in physical machine with fio ioengine=rbd sync=1, we can
> reache ~35K IOPS.
> seems the qemu rbd is the bottleneck.
> 
>     qemu version is 2.1.2 with rbd_aio_flush patched.
>     rbd cache is off, qemu cache=none.
> 
>     IMHO, ceph use sync write for every write to disk, so
> rbd_aio_flush can ignore the sync
> cache command if rbd cache is off so that we can get higher
> iops(similar to direct=1 write)
> for sync=1 iops, right?
> 
>    Very appreciated to get your reply!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
