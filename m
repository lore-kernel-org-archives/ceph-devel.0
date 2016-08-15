From: Wido den Hollander <wido@42on.com>
Subject: Re: CephFS and Samba hang on copy of large file
Date: Mon, 15 Aug 2016 15:35:40 +0200 (CEST)
Message-ID: <1197956778.2488.1471268140723@ox.pcextreme.nl>
References: <1423426743.2483.1471267435085@ox.pcextreme.nl>
 <CAAPGDwLxomxLJMZNsW7qs9vqjnxH9zbBkUjBok7tsHXA_rt3yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:59192 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbcHONfp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Aug 2016 09:35:45 -0400
In-Reply-To: <CAAPGDwLxomxLJMZNsW7qs9vqjnxH9zbBkUjBok7tsHXA_rt3yA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ira Cooper <ira@wakeful.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 15 augustus 2016 om 15:27 schreef Ira Cooper <ira@wakeful.net>:
> 
> 
> Have you tried the ceph VFS module in Samba yet?
> 

Yes. That works, but the performance is a lot lower. So for that we are testing/using the CephFS kernel client.

I would also like to see the VFS module upstream in Samba, you still need to manually patch it in.

Wido

> -Ira
> 
> On Mon, Aug 15, 2016 at 9:23 AM, Wido den Hollander <wido@42on.com> wrote:
> 
> > Hi,
> >
> > I'm running into a issue in combination of CephFS and Samba and I was
> > wondering if a dev knew what is happening here.
> >
> > The situation:
> > - Jewel cluster
> > - CephFS kernel client version 4.7
> > - Samba re-export of CephFS
> > - Mount options: rw,noatime,acl
> >
> > A copy of a 15GB file results in Samba hanging in status D:
> >
> > root@hlms-zaken-01:~# ps aux|grep smb|grep D
> > jongh       8887  0.0  0.0 376656 19068 ?        D    14:42   0:00
> > /usr/sbin/smbd -D
> > jongh       9740  0.0  0.0 377380 19244 ?        D    14:49   0:00
> > /usr/sbin/smbd -D
> > root@hlms-zaken-01:~# cat /proc/8887/stack
> > [<ffffffff8132d353>] call_rwsem_down_write_failed+0x13/0x20
> > [<ffffffff8121a145>] vfs_setxattr+0x55/0xb0
> > [<ffffffff8121a2a5>] setxattr+0x105/0x170
> > [<ffffffff81203aa1>] filename_lookup+0xf1/0x180
> > [<ffffffff8120369f>] getname_flags+0x6f/0x1e0
> > [<ffffffff8121a3bd>] path_setxattr+0xad/0xe0
> > [<ffffffff8121a4f0>] SyS_setxattr+0x10/0x20
> > [<ffffffff815e8b76>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> > [<ffffffffffffffff>] 0xffffffffffffffff
> > root@hlms-zaken-01:~# cat /proc/9740/stack
> > [<ffffffff8132d353>] call_rwsem_down_write_failed+0x13/0x20
> > [<ffffffff8121a145>] vfs_setxattr+0x55/0xb0
> > [<ffffffff8121a2a5>] setxattr+0x105/0x170
> > [<ffffffff81203aa1>] filename_lookup+0xf1/0x180
> > [<ffffffff8120369f>] getname_flags+0x6f/0x1e0
> > [<ffffffff8121a3bd>] path_setxattr+0xad/0xe0
> > [<ffffffff8121a4f0>] SyS_setxattr+0x10/0x20
> > [<ffffffff815e8b76>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> > [<ffffffffffffffff>] 0xffffffffffffffff
> > root@hlms-zaken-01:~#
> >
> > Now, when I look in /sys/kernel/debug/ceph/*/osdc / mdsc there are no
> > outstanding requests to the OSDs or MDS.
> >
> > Both these calls just hang for ever on these requests and they don't
> > continue.
> >
> > Any pointers where to start looking for this? I tried the 4.4 kernel
> > before, it gave me the same hang. So that's why I upgraded to 4.7 to see if
> > it was fixed there.
> >
> > The Ceph cluster is currently backfilling 17 PGs, but this also happend
> > when HEALTH_OK was around.
> >
> > There are no block or slow requests in the cluster.
> >
> > Wido
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
