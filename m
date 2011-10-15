From: Christian Brunner <chb@muc.de>
Subject: Re: OSD blocked for more than 120 seconds
Date: Sat, 15 Oct 2011 21:33:24 +0200
Message-ID: <CAO47_-8wOFxzjy-n2W_q75D=h7z8spswgghJ9iy8p6eQu-2kFA@mail.gmail.com>
References: <4E974C87.2070204@tuxadero.com>
	<1318585099.2999.10.camel@wido-laptop>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54160 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab1JOTdZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Oct 2011 15:33:25 -0400
Received: by vws1 with SMTP id 1so1757799vws.19
        for <ceph-devel@vger.kernel.org>; Sat, 15 Oct 2011 12:33:24 -0700 (PDT)
In-Reply-To: <1318585099.2999.10.camel@wido-laptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: martin@tuxadero.com, ceph-devel@vger.kernel.org

I'm not seeing the same problem, but I've experienced something similar=
:

As you might know, I had serious performance problems with btrfs some
month ago, after that, I switched to ext4 and had other problems
there. Last Saturday I decided to give josef's current btrfs git repo
a try in our ceph cluster.

Everything performed well at first, but after a day I noticed that
btrfs-cleaner was wasting more and more time in
btrfs_clean_old_snapshots. When we reached load 20 on the OSDs I
rebooted the nodes, everything was back to normal then. But again
after a a few hours the load started to rise.

My solution to fix this for the moment was, to turn of the btrfs
snapshot feature in ceph with:

filestore btrfs snaps =3D 0

Now I have good performance, low waitio values on the disks and I
haven't seen our btrfs warning until now as well.

I don't know what the implications are (does this enable writeahead
journaling in ceph?), but to me it's the only setup that does the job
at the moment.

Regards,
Christian



2011/10/14 Wido den Hollander <wido@widodh.nl>:
> Hi,
>
> On Thu, 2011-10-13 at 22:39 +0200, Martin Mailand wrote:
>> Hi,
>> on one of my OSDs the ceph-osd task hung for more than 120 sec. The =
OSD
>> had almost no load, therefore it cannot be an overload problem. I th=
ink
>> it is a btrfs problem, could someone clarify it?
>>
>> This was in the dmesg.
>>
>> [29280.890040] INFO: task btrfs-cleaner:1708 blocked for more than 1=
20
>
> Judging on the fact that I see btrfs-cleaner and btrfs-transaction
> blocking I guess this is a btrfs bug/hangup.
>
> Which kernel are you using?
>
> Wido
>
>> seconds.
>> [29280.905659] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [29280.922916] btrfs-cleaner =A0 D ffff8801153bdf80 =A0 =A0 0 =A0170=
8 =A0 =A0 =A02
>> 0x00000000
>> [29280.922931] =A0ffff88011698bbd0 0000000000000046 ffff88011698bb90
>> ffffffff81090d7d
>> [29280.922960] =A0ffff880100000000 ffff88011698bfd8 ffff88011698a000
>> ffff88011698bfd8
>> [29280.922988] =A0ffffffff81a0d020 ffff8801153bdbc0 ffff88011698bbd0
>> 0000000181090d7d
>> [29280.923018] Call Trace:
>> [29280.923043] =A0[<ffffffff81090d7d>] ? ktime_get_ts+0xad/0xe0
>> [29280.923062] =A0[<ffffffff8110cf10>] ? __lock_page+0x70/0x70
>> [29280.923082] =A0[<ffffffff815d93df>] schedule+0x3f/0x60
>> [29280.923098] =A0[<ffffffff815d948c>] io_schedule+0x8c/0xd0
>> [29280.923114] =A0[<ffffffff8110cf1e>] sleep_on_page+0xe/0x20
>> [29280.923130] =A0[<ffffffff815d9c6f>] __wait_on_bit+0x5f/0x90
>> [29280.923147] =A0[<ffffffff8110d168>] wait_on_page_bit+0x78/0x80
>> [29280.923165] =A0[<ffffffff81086bd0>] ? autoremove_wake_function+0x=
40/0x40
>> [29280.923227] =A0[<ffffffffa0065ecb>] btrfs_defrag_file+0x4fb/0xc10=
 [btrfs]
>> [29280.923246] =A0[<ffffffff8117f6ac>] ? find_inode+0xac/0xb0
>> [29280.923281] =A0[<ffffffffa003a2d0>] ?
>> btrfs_clean_old_snapshots+0x160/0x160 [btrfs]
>> [29280.923302] =A0[<ffffffff812e369b>] ? radix_tree_lookup+0xb/0x10
>> [29280.923337] =A0[<ffffffffa0034f62>] ?
>> btrfs_read_fs_root_no_name+0x1c2/0x2e0 [btrfs]
>> [29280.923375] =A0[<ffffffffa004897e>] btrfs_run_defrag_inodes+0x15e=
/0x210
>> [btrfs]
>> [29280.923410] =A0[<ffffffffa003278f>] cleaner_kthread+0x17f/0x1a0 [=
btrfs]
>> [29280.923443] =A0[<ffffffffa0032610>] ? btrfs_congested_fn+0xb0/0xb=
0 [btrfs]
>> [29280.923460] =A0[<ffffffff81086436>] kthread+0x96/0xa0
>> [29280.923477] =A0[<ffffffff815e5934>] kernel_thread_helper+0x4/0x10
>> [29280.923493] =A0[<ffffffff810863a0>] ? flush_kthread_worker+0xb0/0=
xb0
>> [29280.923510] =A0[<ffffffff815e5930>] ? gs_change+0x13/0x13
>> [29280.923521] INFO: task btrfs-transacti:1709 blocked for more than=
 120
>> seconds.
>> [29280.939551] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [29280.956782] btrfs-transacti D ffff880115745f80 =A0 =A0 0 =A01709 =
=A0 =A0 =A02
>> 0x00000000
>> [29280.956792] =A0ffff880115e6fd50 0000000000000046 ffff880115e6fd20
>> ffff880111a5a3e0
>> [29280.956800] =A0ffff880100000000 ffff880115e6ffd8 ffff880115e6e000
>> ffff880115e6ffd8
>> [29280.956809] =A0ffffffff81a0d020 ffff880115745bc0 0000000000000282
>> 0000000116758450
>> [29280.956817] Call Trace:
>> [29280.956827] =A0[<ffffffff815d93df>] schedule+0x3f/0x60
>> [29280.956855] =A0[<ffffffffa0037de5>] wait_for_commit.clone.16+0x55=
/0x90
>> [btrfs]
>> [29280.956864] =A0[<ffffffff81086b90>] ? wake_up_bit+0x40/0x40
>> [29280.956891] =A0[<ffffffffa0039726>]
>> btrfs_commit_transaction+0x776/0x860 [btrfs]
>> [29280.956900] =A0[<ffffffff8115653c>] ? kmem_cache_alloc+0x3c/0x130
>> [29280.956907] =A0[<ffffffff815db6fe>] ? _raw_spin_lock+0xe/0x20
>> [29280.956933] =A0[<ffffffffa003879d>] ?
>> join_transaction.clone.24+0x5d/0x240 [btrfs]
>> [29280.956941] =A0[<ffffffff81086b90>] ? wake_up_bit+0x40/0x40
>> [29280.956966] =A0[<ffffffffa0033323>] transaction_kthread+0x273/0x2=
90 [btrfs]
>> [29280.956991] =A0[<ffffffffa00330b0>] ? check_leaf.clone.68+0x320/0=
x320
>> [btrfs]
>> [29280.956999] =A0[<ffffffff81086436>] kthread+0x96/0xa0
>> [29280.957007] =A0[<ffffffff815e5934>] kernel_thread_helper+0x4/0x10
>> [29280.957015] =A0[<ffffffff810863a0>] ? flush_kthread_worker+0xb0/0=
xb0
>> [29280.957022] =A0[<ffffffff815e5930>] ? gs_change+0x13/0x13
>> [29280.957030] INFO: task ceph-osd:1855 blocked for more than 120 se=
conds.
>> [29280.971860] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [29280.989164] ceph-osd =A0 =A0 =A0 =A0D ffff880114865f80 =A0 =A0 0 =
=A01855 =A0 =A0 =A01
>> 0x00000004
>> [29280.989173] =A0ffff880115229c48 0000000000000082 ffff880115229bf8
>> ffff880115230fb8
>> [29280.989181] =A0ffff880115229c00 ffff880115229fd8 ffff880115228000
>> ffff880115229fd8
>> [29280.989189] =A0ffff8801151744d0 ffff880114865bc0 0000000000000282
>> ffff880117864208
>> [29280.989209] Call Trace:
>> [29280.989226] =A0[<ffffffff815d93df>] schedule+0x3f/0x60
>> [29280.989263] =A0[<ffffffffa003a017>]
>> btrfs_commit_transaction_async+0x1f7/0x270 [btrfs]
>> [29280.989296] =A0[<ffffffffa002375b>] ? block_rsv_add_bytes+0x5b/0x=
80 [btrfs]
>> [29280.989314] =A0[<ffffffff81086b90>] ? wake_up_bit+0x40/0x40
>> [29280.989344] =A0[<ffffffffa00237ba>] ? block_rsv_migrate_bytes+0x3=
a/0x50
>> [btrfs]
>> [29280.989380] =A0[<ffffffffa00655b1>] btrfs_mksubvol+0x301/0x3a0 [b=
trfs]
>> [29280.989416] =A0[<ffffffffa0065750>]
>> btrfs_ioctl_snap_create_transid+0x100/0x160 [btrfs]
>> [29280.989453] =A0[<ffffffffa00658d2>]
>> btrfs_ioctl_snap_create_v2.clone.57+0xa2/0x100 [btrfs]
>> [29280.989491] =A0[<ffffffffa0066d5d>] btrfs_ioctl+0x1fd/0xe20 [btrf=
s]
>> [29280.989507] =A0[<ffffffff811657c2>] ? do_sync_write+0xd2/0x110
>> [29280.989525] =A0[<ffffffff811a053d>] ? fsnotify+0x1cd/0x2e0
>> [29280.989541] =A0[<ffffffff811779f8>] do_vfs_ioctl+0x98/0x540
>> [29280.989557] =A0[<ffffffff81177f31>] sys_ioctl+0x91/0xa0
>> [29280.989575] =A0[<ffffffff815e37c2>] system_call_fastpath+0x16/0x1=
b
>>
>>
>> Best Regards,
>> =A0 marti
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
