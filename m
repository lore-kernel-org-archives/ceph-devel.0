From: Cedric Morandin <cedric.morandin@inria.fr>
Subject: Re: Ceph hangs when accessed
Date: Thu, 29 Sep 2011 17:22:09 +0200 (CEST)
Message-ID: <1433144686.87355.1317309729100.JavaMail.root@zmbs4.inria.fr>
References: <CAORUGqAoe1=DTNMw43e9LRbaLVrEqw_4koYZiYfVrwJfmUzXCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail4-relais-sop.national.inria.fr ([192.134.164.105]:9039 "EHLO
	mail4-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932123Ab1I2PWL convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Sep 2011 11:22:11 -0400
In-Reply-To: <CAORUGqAoe1=DTNMw43e9LRbaLVrEqw_4koYZiYfVrwJfmUzXCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Hello Tommi,

I followed your advice and tried with ext4.
Everything is working fine with ext4.
I'll try with a newer version of btrfs when I would have time.

I paste below the trace related to btrfs which appears in var/log/messa=
ges during the problem :

Sep 26 23:04:51 node95 kernel: INFO: task cosd:2988 blocked for more th=
an 120 seconds.
Sep 26 23:04:51 node95 kernel: "echo 0 > /proc/sys/kernel/hung_task_tim=
eout_secs" disables this message.
Sep 26 23:04:51 node95 kernel: cosd          D ffff880c3fc25700     0  =
2988      1 0x00000080
Sep 26 23:04:51 node95 kernel: ffff8817fb919bc8 0000000000000082 000000=
0000000000 ffffffffa0175fa1
Sep 26 23:04:51 node95 kernel: 0000000000000000 ffff8817f844f448 ffffff=
ffa015df40 0000000100d0253c
Sep 26 23:04:51 node95 kernel: ffff881806d05a98 ffff8817fb919fd8 000000=
0000010518 ffff881806d05a98
Sep 26 23:04:51 node95 kernel: Call Trace:
Sep 26 23:04:51 node95 kernel: [<ffffffffa0175fa1>] ? extent_writepages=
+0x51/0x60 [btrfs]
Sep 26 23:04:51 node95 kernel: [<ffffffffa015df40>] ? btrfs_get_extent+=
0x0/0x8b0 [btrfs]
Sep 26 23:04:51 node95 kernel: [<ffffffffa016ef8d>] btrfs_start_ordered=
_extent+0x6d/0xc0 [btrfs]
Sep 26 23:04:51 node95 kernel: [<ffffffff81091ca0>] ? autoremove_wake_f=
unction+0x0/0x40
Sep 26 23:04:51 node95 kernel: [<ffffffffa016f16b>] btrfs_wait_ordered_=
extents+0x12b/0x1e0 [btrfs]
Sep 26 23:04:51 node95 kernel: [<ffffffffa015336f>] btrfs_commit_transa=
ction+0x20f/0x710 [btrfs]
Sep 26 23:04:51 node95 kernel: [<ffffffff81091ca0>] ? autoremove_wake_f=
unction+0x0/0x40
Sep 26 23:04:51 node95 kernel: [<ffffffffa01801b6>] btrfs_mksubvol+0x2d=
6/0x350 [btrfs]
Sep 26 23:04:51 node95 kernel: [<ffffffffa0180343>] btrfs_ioctl_snap_cr=
eate+0x113/0x160 [btrfs]
Sep 26 23:04:51 node95 kernel: [<ffffffffa0181d9a>] btrfs_ioctl+0x4ca/0=
x970 [btrfs]
Sep 26 23:04:51 node95 kernel: [<ffffffff8117f182>] vfs_ioctl+0x22/0xa0
Sep 26 23:04:51 node95 kernel: [<ffffffff81059d12>] ? finish_task_switc=
h+0x42/0xd0
Sep 26 23:04:51 node95 kernel: [<ffffffff8117f324>] do_vfs_ioctl+0x84/0=
x580
Sep 26 23:04:51 node95 kernel: [<ffffffff8116c892>] ? vfs_write+0x132/0=
x1a0
Sep 26 23:04:51 node95 kernel: [<ffffffff8117f8a1>] sys_ioctl+0x81/0xa0
Sep 26 23:04:51 node95 kernel: [<ffffffff81013172>] system_call_fastpat=
h+0x16/0x1b
Sep 26 23:06:51 node95 kernel: INFO: task btrfs-transacti:1093 blocked =
for more than 120 seconds.
Sep 26 23:06:51 node95 kernel: "echo 0 > /proc/sys/kernel/hung_task_tim=
eout_secs" disables this message.
Sep 26 23:06:51 node95 kernel: btrfs-transac D ffff880c3fc25700     0  =
1093      2 0x00000000
Sep 26 23:06:51 node95 kernel: ffff880c070e5d50 0000000000000046 000000=
0000000000 ffffffff81059d12
Sep 26 23:06:51 node95 kernel: 0000000000000000 0000000000016980 000000=
0000000000 0000000100d09a6f
Sep 26 23:06:51 node95 kernel: ffff880c058fd028 ffff880c070e5fd8 000000=
0000010518 ffff880c058fd028
Sep 26 23:06:51 node95 kernel: Call Trace:
Sep 26 23:06:51 node95 kernel: [<ffffffff81059d12>] ? finish_task_switc=
h+0x42/0xd0
Sep 26 23:06:51 node95 kernel: [<ffffffffa0151ec9>] wait_for_commit+0x8=
9/0xf0 [btrfs]
Sep 26 23:06:51 node95 kernel: [<ffffffff81091ca0>] ? autoremove_wake_f=
unction+0x0/0x40
Sep 26 23:06:51 node95 kernel: [<ffffffffa015374e>] btrfs_commit_transa=
ction+0x5ee/0x710 [btrfs]
Sep 26 23:06:51 node95 kernel: [<ffffffff814c963e>] ? mutex_lock+0x1e/0=
x50
Sep 26 23:06:51 node95 kernel: [<ffffffffa0153c8b>] ? start_transaction=
+0x1ab/0x230 [btrfs]
Sep 26 23:06:51 node95 kernel: [<ffffffff81091ca0>] ? autoremove_wake_f=
unction+0x0/0x40
Sep 26 23:06:51 node95 kernel: [<ffffffffa014d9ab>] transaction_kthread=
+0x26b/0x280 [btrfs]
Sep 26 23:06:51 node95 kernel: [<ffffffffa014d740>] ? transaction_kthre=
ad+0x0/0x280 [btrfs]
Sep 26 23:06:51 node95 kernel: [<ffffffff81091936>] kthread+0x96/0xa0
Sep 26 23:06:51 node95 kernel: [<ffffffff810141ca>] child_rip+0xa/0x20
Sep 26 23:06:51 node95 kernel: [<ffffffff810918a0>] ? kthread+0x0/0xa0
Sep 26 23:06:51 node95 kernel: [<ffffffff810141c0>] ? child_rip+0x0/0x2=
0

Regards

C=E9dric

----- Mail original -----
> De: "Tommi Virtanen" <tommi.virtanen@dreamhost.com>
> =C0: "C=E9dric Morandin" <cedric.morandin@inria.fr>
> Cc: "Wido den Hollander" <wido@widodh.nl>, ceph-devel@vger.kernel.org
> Envoy=E9: Mardi 27 Septembre 2011 18:32:24
> Objet: Re: Ceph hangs when accessed
> On Mon, Sep 26, 2011 at 14:23, C=E9dric Morandin
> <cedric.morandin@inria.fr> wrote:
> > 2011-09-26 23:07:49.404867 osd e13: 4 osds: 2 up, 4 in
> ...
> > 2011-09-26 22:57:06.822182 7faf6a6f8700 -- 138.96.126.92:6802/3157
> > >> 138.96.126.93:6801/3162 pipe(0x7faf50001320 sd=3D20 pgs=3D0 cs=3D=
0
> > l=3D0).accept connect_seq 2 vs existing 1 state 3
> > 2011-09-26 23:07:09.084901 7faf8e1b5700 FileStore: sync_entry timed
> > out after 600 seconds.
> > =A0ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6=
d6)
>=20
> And earlier you said the OSDs are using btrfs. That definitely sounds
> like a btrfs bug, then.
>=20
> Do the osd machines have anything interesting in dmesg or
> /var/log/kern.log ?
>=20
> You may want to try a newer kernel, or running on ext4 for now.


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
