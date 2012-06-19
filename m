From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: kernel crash from RBD in Ubuntu 12.04
Date: Tue, 19 Jun 2012 14:50:50 -0400
Message-ID: <CACkq2mp8zhs-T-Z9gqKcdTrayB_n4V443=hQdL11oLv5jz+m-w@mail.gmail.com>
References: <CACkq2mpAZ9-g+Y2peGhP7S2nVCY+j+TCJ9jK6Yu1jMBAuxpY+g@mail.gmail.com>
 <4FE0C8C3.9020603@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38287 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab2FSSvM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 14:51:12 -0400
Received: by lbbgm6 with SMTP id gm6so6127966lbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jun 2012 11:51:10 -0700 (PDT)
In-Reply-To: <4FE0C8C3.9020603@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com
Cc: ceph-devel@vger.kernel.org

Awesome.  Thanks Alex.  I'll eagerly await 0.48 once it has finished QA=
=2E

 - Travis

On Tue, Jun 19, 2012 at 2:45 PM, Alex Elder <elder@dreamhost.com> wrote=
:
> On 06/19/2012 01:32 PM, Travis Rhoden wrote:
>> Hey folks,
>>
>> Ran into this today. =A0Not sure what I did wrong. =A0=3D)
>
> It appears you are running Linux 3.2.0. =A0This has symptoms that
> could be explained by a bug that has been fixed in newer Ceph
> code. =A0Specifically, I think this is the fix that, without it,
> you might see something like this:
>
> =A0 =A0rbd: don't drop the rbd_id too early
>
> https://github.com/ceph/ceph-client/commit/32eec68d2f233e8a6ae1cd3260=
22f6862e2b9ce3
>
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0-Alex
>
>> I had an RBD successfully mounted and was done with it. =A0Proceeded=
 to
>> do the following:
>>
>> root@spcnode2:~# ls /sys/bus/rbd/devices/
>> 0
>> root@spcnode2:~# echo 0 > /sys/bus/rbd/remove
>> root@spcnode2:~# ls /sys/bus/rbd/devices/ =A0 =A0 =A0<--- At this po=
int, I
>> believe the RBD has been successfully removed
>>
>> ---- =A0About an hour passes where I am messing with my ceph cluster=
=2E
>> No other commands are run on this machine ----
>> ---- =A0New cluster is up. =A0Time to mount my new RBD
>>
>> root@spcnode2:~# echo "10.55.30.0,10.55.30.1,10.55.30.2
>> name=3Dadmin,secret=3DAQCNv+BPoPQENBAAxlm39kJ5XteNxg2S/dulXw=3D=3D r=
bd
>> perftest" | tee /sys/bus/rbd/add
>> 10.55.30.0,10.55.30.1,10.55.30.2
>> name=3Dadmin,secret=3DAQCNv+BPoPQENBAAxlm39kJ5XteNxg2S/dulXw=3D=3D r=
bd
>> perftest
>> Segmentation fault
>>
>> Well that's ugly. =A0What's in syslog?
>>
>> Jun 19 11:16:56 spcnode2 kernel: [76564.387890] ------------[ cut he=
re
>> ]------------
>> Jun 19 11:16:56 spcnode2 kernel: [76564.392569] WARNING: at
>> /build/buildd/linux-3.2.0/fs/sysfs/inode.c:324
>> sysfs_hash_and_remove+0xa9/0xb0()
>> Jun 19 11:16:56 spcnode2 kernel: [76564.402233] Hardware name: Relio=
n 1702
>> Jun 19 11:16:56 spcnode2 kernel: [76564.406079] sysfs: can not remov=
e
>> 'bdi', no directory
>> Jun 19 11:16:56 spcnode2 kernel: [76564.411268] Modules linked in: r=
bd
>> libceph ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERA=
DE
>> xt_state ipt_REJECT xt_CHECKSUM iptable_mangle xt_tcpudp xt_conntrac=
k
>> iptable_nat nf_nat nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4
>> ipmi_devintf ipmi_si iptable_filter ipmi_msghandler ip_tables x_tabl=
es
>> kvm_intel kvm bnep rfcomm bluetooth parport_pc ppdev nfsd nfs lockd
>> fscache auth_rpcgss nfs_acl sunrpc ext2 xfs vesafb ib_iser rdma_cm
>> ib_cm iw_cm ib_sa ib_mad ib_core ib_addr iscsi_tcp libiscsi_tcp
>> libiscsi scsi_transport_iscsi bridge mtdchar i7core_edac psmouse 802=
1q
>> garp stp lp parport dm_multipath mac_hid serio_raw edac_core ioatdma
>> usbhid hid sfc mtd i2c_algo_bit igb mdio dca btrfs zlib_deflate
>> libcrc32c
>> Jun 19 11:16:56 spcnode2 kernel: [76564.477972] Pid: 6924, comm: bas=
h
>> Tainted: G =A0 =A0 =A0D W =A0 =A03.2.0-25-generic #40-Ubuntu
>> Jun 19 11:16:56 spcnode2 kernel: [76564.485837] Call Trace:
>> Jun 19 11:16:56 spcnode2 kernel: [76564.488394] =A0[<ffffffff810672a=
f>]
>> warn_slowpath_common+0x7f/0xc0
>> Jun 19 11:16:56 spcnode2 kernel: [76564.494511] =A0[<ffffffff810673a=
6>]
>> warn_slowpath_fmt+0x46/0x50
>> Jun 19 11:16:56 spcnode2 kernel: [76564.500348] =A0[<ffffffff8119295=
8>]
>> ? iput_final+0xe8/0x210
>> Jun 19 11:16:56 spcnode2 kernel: [76564.505888] =A0[<ffffffff811ebc5=
9>]
>> sysfs_hash_and_remove+0xa9/0xb0
>> Jun 19 11:16:56 spcnode2 kernel: [76564.512082] =A0[<ffffffff811ee35=
6>]
>> sysfs_remove_link+0x26/0x30
>> Jun 19 11:16:56 spcnode2 kernel: [76564.517959] =A0[<ffffffff812fb96=
0>]
>> del_gendisk+0x100/0x260
>> Jun 19 11:16:56 spcnode2 kernel: [76564.523448] =A0[<ffffffffa062386=
8>]
>> rbd_dev_release+0x108/0x110 [rbd]
>> Jun 19 11:16:56 spcnode2 kernel: [76564.529861] =A0[<ffffffff813f140=
7>]
>> device_release+0x27/0xa0
>> Jun 19 11:16:56 spcnode2 kernel: [76564.535432] =A0[<ffffffff8130cfd=
c>]
>> kobject_release+0x4c/0xa0
>> Jun 19 11:16:56 spcnode2 kernel: [76564.541163] =A0[<ffffffff8130cf9=
0>]
>> ? kobject_del+0x40/0x40
>> Jun 19 11:16:56 spcnode2 kernel: [76564.546694] =A0[<ffffffff8130e68=
6>]
>> kref_put+0x36/0x70
>> Jun 19 11:16:56 spcnode2 kernel: [76564.551764] =A0[<ffffffff8130ce9=
7>]
>> kobject_put+0x27/0x60
>> Jun 19 11:16:56 spcnode2 kernel: [76564.557126] =A0[<ffffffff8131d33=
c>]
>> ? _kstrtoull+0x2c/0x90
>> Jun 19 11:16:56 spcnode2 kernel: [76564.562523] =A0[<ffffffff813f116=
7>]
>> put_device+0x17/0x20
>> Jun 19 11:16:56 spcnode2 kernel: [76564.567808] =A0[<ffffffff813f225=
e>]
>> device_unregister+0x1e/0x30
>> Jun 19 11:16:56 spcnode2 kernel: [76564.573647] =A0[<ffffffffa06211e=
a>]
>> rbd_remove+0x15a/0x160 [rbd]
>> Jun 19 11:16:56 spcnode2 kernel: [76564.579594] =A0[<ffffffff813f3c4=
7>]
>> bus_attr_store+0x27/0x30
>> Jun 19 11:16:56 spcnode2 kernel: [76564.585113] =A0[<ffffffff811ebeb=
f>]
>> sysfs_write_file+0xef/0x170
>> Jun 19 11:16:56 spcnode2 kernel: [76564.590907] =A0[<ffffffff81177f2=
3>]
>> vfs_write+0xb3/0x180
>> Jun 19 11:16:56 spcnode2 kernel: [76564.596158] =A0[<ffffffff8117824=
a>]
>> sys_write+0x4a/0x90
>> Jun 19 11:16:56 spcnode2 kernel: [76564.601258] =A0[<ffffffff81665c4=
2>]
>> system_call_fastpath+0x16/0x1b
>> Jun 19 11:16:56 spcnode2 kernel: [76564.607321] ---[ end trace
>> ace27f1cbf93eeaa ]---
>> Jun 19 11:16:57 spcnode2 kernel: [76564.612447] BUG: unable to handl=
e
>> kernel NULL pointer dereference at 0000000000000079
>> Jun 19 11:16:57 spcnode2 kernel: [76564.620374] IP:
>> [<ffffffff811ed770>] sysfs_find_dirent+0x10/0x110
>> Jun 19 11:16:57 spcnode2 kernel: [76564.626475] PGD 404514067 PUD
>> 5f89cc067 PMD 0
>> Jun 19 11:16:57 spcnode2 kernel: [76564.630958] Oops: 0000 [#2] SMP
>> Jun 19 11:16:57 spcnode2 kernel: [76564.634254] CPU 5
>> Jun 19 11:16:57 spcnode2 kernel: [76564.636113] Modules linked in: r=
bd
>> libceph ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERA=
DE
>> xt_state ipt_REJECT xt_CHECKSUM iptable_mangle xt_tcpudp xt_conntrac=
k
>> iptable_nat nf_nat nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4
>> ipmi_devintf ipmi_si iptable_filter ipmi_msghandler ip_tables x_tabl=
es
>> kvm_intel kvm bnep rfcomm bluetooth parport_pc ppdev nfsd nfs lockd
>> fscache auth_rpcgss nfs_acl sunrpc ext2 xfs vesafb ib_iser rdma_cm
>> ib_cm iw_cm ib_sa ib_mad ib_core ib_addr iscsi_tcp libiscsi_tcp
>> libiscsi scsi_transport_iscsi bridge mtdchar i7core_edac psmouse 802=
1q
>> garp stp lp parport dm_multipath mac_hid serio_raw edac_core ioatdma
>> usbhid hid sfc mtd i2c_algo_bit igb mdio dca btrfs zlib_deflate
>> libcrc32c
>> Jun 19 11:16:57 spcnode2 kernel: [76564.701251]
>> Jun 19 11:16:57 spcnode2 kernel: [76564.702740] Pid: 6924, comm: bas=
h
>> Tainted: G =A0 =A0 =A0D W =A0 =A03.2.0-25-generic #40-Ubuntu Penguin=
 Computing
>> Relion 1702/X8DTT
>> Jun 19 11:16:57 spcnode2 kernel: [76564.713752] RIP:
>> 0010:[<ffffffff811ed770>] =A0[<ffffffff811ed770>]
>> sysfs_find_dirent+0x10/0x110
>> Jun 19 11:16:57 spcnode2 kernel: [76564.722319] RSP:
>> 0018:ffff8805f8f9bc58 =A0EFLAGS: 00010246
>> Jun 19 11:16:57 spcnode2 kernel: [76564.727719] RAX: ffff8806186edbc=
0
>> RBX: 0000000000000000 RCX: 00000000000988e6
>> Jun 19 11:16:57 spcnode2 kernel: [76564.734892] RDX: ffffffff81a0158=
d
>> RSI: 0000000000000000 RDI: 0000000000000000
>> Jun 19 11:16:57 spcnode2 kernel: [76564.742083] RBP: ffff8805f8f9bc7=
8
>> R08: ffffea00303f6580 R09: ffffffff8130cfe9
>> Jun 19 11:16:57 spcnode2 kernel: [76564.749221] R10: ffff880c0fe5de2=
8
>> R11: 0000000000000000 R12: 0000000000000000
>> Jun 19 11:16:57 spcnode2 kernel: [76564.756437] R13: ffffffff81a0158=
d
>> R14: ffff880bf45a5a50 R15: ffff880c0fd1de18
>> Jun 19 11:16:57 spcnode2 kernel: [76564.763630] FS:
>> 00007fe308eb7700(0000) GS:ffff880c3fc20000(0000)
>> knlGS:0000000000000000
>> Jun 19 11:16:57 spcnode2 kernel: [76564.771717] CS: =A00010 DS: 0000=
 ES:
>> 0000 CR0: 0000000080050033
>> Jun 19 11:16:57 spcnode2 kernel: [76564.777549] CR2: 000000000000007=
9
>> CR3: 00000005f89cd000 CR4: 00000000000006e0
>> Jun 19 11:16:57 spcnode2 kernel: [76564.784738] DR0: 000000000000000=
0
>> DR1: 0000000000000000 DR2: 0000000000000000
>> Jun 19 11:16:57 spcnode2 kernel: [76564.791877] DR3: 000000000000000=
0
>> DR6: 00000000ffff0ff0 DR7: 0000000000000400
>> Jun 19 11:16:57 spcnode2 kernel: [76564.798991] Process bash (pid:
>> 6924, threadinfo ffff8805f8f9a000, task ffff8806186edbc0)
>> Jun 19 11:16:57 spcnode2 kernel: [76564.807295] Stack:
>> Jun 19 11:16:57 spcnode2 kernel: [76564.809302] =A00000000000000000
>> 0000000000000000 ffffffff81a0158d ffff880bf45a5a50
>> Jun 19 11:16:57 spcnode2 kernel: [76564.816832] =A0ffff8805f8f9bca8
>> ffffffff811ed9bc ffff8805f8f9bcd8 ffffffff81c34b00
>> Jun 19 11:16:57 spcnode2 kernel: [76564.824341] =A0ffff880605b36878
>> 0000000000000000 ffff8805f8f9bce8 ffffffff811efa15
>> Jun 19 11:16:57 spcnode2 kernel: [76564.831894] Call Trace:
>> Jun 19 11:16:57 spcnode2 kernel: [76564.834337] =A0[<ffffffff811ed9b=
c>]
>> sysfs_get_dirent+0x3c/0x80
>> Jun 19 11:16:57 spcnode2 kernel: [76564.840041] =A0[<ffffffff811efa1=
5>]
>> sysfs_remove_group+0x35/0x100
>> Jun 19 11:16:57 spcnode2 kernel: [76564.846029] =A0[<ffffffff810fee2=
4>]
>> blk_trace_remove_sysfs+0x14/0x20
>> Jun 19 11:16:57 spcnode2 kernel: [76564.852195] =A0[<ffffffff812f50d=
9>]
>> blk_unregister_queue+0x59/0x80
>> Jun 19 11:16:57 spcnode2 kernel: [76564.858270] =A0[<ffffffff812fb97=
b>]
>> del_gendisk+0x11b/0x260
>> Jun 19 11:16:57 spcnode2 kernel: [76564.863661] =A0[<ffffffffa062386=
8>]
>> rbd_dev_release+0x108/0x110 [rbd]
>> Jun 19 11:16:57 spcnode2 kernel: [76564.869962] =A0[<ffffffff813f140=
7>]
>> device_release+0x27/0xa0
>> Jun 19 11:16:57 spcnode2 kernel: [76564.875448] =A0[<ffffffff8130cfd=
c>]
>> kobject_release+0x4c/0xa0
>> Jun 19 11:16:57 spcnode2 kernel: [76564.881061] =A0[<ffffffff8130cf9=
0>]
>> ? kobject_del+0x40/0x40
>> Jun 19 11:16:57 spcnode2 kernel: [76564.886502] =A0[<ffffffff8130e68=
6>]
>> kref_put+0x36/0x70
>> Jun 19 11:16:57 spcnode2 kernel: [76564.891521] =A0[<ffffffff8130ce9=
7>]
>> kobject_put+0x27/0x60
>> Jun 19 11:16:57 spcnode2 kernel: [76564.896739] =A0[<ffffffff8131d33=
c>]
>> ? _kstrtoull+0x2c/0x90
>> Jun 19 11:16:57 spcnode2 kernel: [76564.902043] =A0[<ffffffff813f116=
7>]
>> put_device+0x17/0x20
>> Jun 19 11:16:57 spcnode2 kernel: [76564.907226] =A0[<ffffffff813f225=
e>]
>> device_unregister+0x1e/0x30
>> Jun 19 11:16:57 spcnode2 kernel: [76564.913057] =A0[<ffffffffa06211e=
a>]
>> rbd_remove+0x15a/0x160 [rbd]
>> Jun 19 11:16:57 spcnode2 kernel: [76564.918881] =A0[<ffffffff813f3c4=
7>]
>> bus_attr_store+0x27/0x30
>> Jun 19 11:16:57 spcnode2 kernel: [76564.924436] =A0[<ffffffff811ebeb=
f>]
>> sysfs_write_file+0xef/0x170
>> Jun 19 11:16:57 spcnode2 kernel: [76564.930174] =A0[<ffffffff81177f2=
3>]
>> vfs_write+0xb3/0x180
>> Jun 19 11:16:57 spcnode2 kernel: [76564.935450] =A0[<ffffffff8117824=
a>]
>> sys_write+0x4a/0x90
>> Jun 19 11:16:57 spcnode2 kernel: [76564.940497] =A0[<ffffffff81665c4=
2>]
>> system_call_fastpath+0x16/0x1b
>> Jun 19 11:16:57 spcnode2 kernel: [76564.946488] Code: 41 5c 41 5d 41
>> 5e 41 5f 5d c3 90 4c 89 f7 e8 68 df 46 00 eb c3 0f 0b 0f 1f 40 00 55
>> 48 89 e5 41 56 41 55 41 54 53 66 66 66 66 90 <80> 7f 79 00 4c 8b 67 =
70
>> 49 89 d6 48 89 f3 0f 95 c0 48 85 f6 0f
>> Jun 19 11:16:57 spcnode2 kernel: [76564.966571] RIP
>> [<ffffffff811ed770>] sysfs_find_dirent+0x10/0x110
>> Jun 19 11:16:57 spcnode2 kernel: [76564.972826] =A0RSP <ffff8805f8f9=
bc58>
>> Jun 19 11:16:57 spcnode2 kernel: [76564.976331] CR2: 000000000000007=
9
>> Jun 19 11:16:57 spcnode2 kernel: [76564.979725] ---[ end trace
>> ace27f1cbf93eeab ]---
>>
>>
>> Had to do a hard reset on the machine afterwards.
>>
>> The machine mounting the RBD is running Ubuntu 12.04, and is not
>> hosting any OSDs or MONs.
>> root@spcnode2:~# uname -a
>> Linux spcnode2 3.2.0-25-generic #40-Ubuntu SMP Wed May 23 20:30:51 U=
TC
>> 2012 x86_64 x86_64 x86_64 GNU/Linux
>> root@spcnode2:~# ceph --version
>> ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372=
)
>>
>> - Travis
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
