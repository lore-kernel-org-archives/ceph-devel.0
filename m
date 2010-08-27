From: Sage Weil <sage@newdream.net>
Subject: Re: Write operation is stuck
Date: Fri, 27 Aug 2010 09:09:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008270908001.1510@cobra.newdream.net>
References: <loom.20100827T140056-342@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57368 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab0H0QIQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Aug 2010 12:08:16 -0400
In-Reply-To: <loom.20100827T140056-342@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bogdan Lobodzinski <bogdan@mail.desy.de>
Cc: ceph-devel@vger.kernel.org

Hi Bogdan,

This is a bug in the ext3 xattr code.  It seems to be gone in 2.6.34 and 
later.  Or, you can switch to btrfs!

sage


On Fri, 27 Aug 2010, Bogdan Lobodzinski wrote:

> Hello,
> 
> working with ceph on my test configuration 
> (3 nodes Ubuntu 10.04.1 LTS, Linux 2.6.32-24-generic-pae #41-Ubuntu SMP)
> After starting 
> svn co https://root.cern.ch/svn/root/trunk root
> 
> on the /ceph directory, the command become stuck, and also:
> root      5303  0.0  0.0      0     0 ?        D    Aug26   0:00 [kjournald]
> root     30181  0.0  0.0   6972  2056 pts/1    D+   13:46   0:00 /usr//bin/cosd
> -i 2 -c /etc/ceph/ceph.conf
> 
> any mount, unmount are going also to the state D.
> This is a permanennt behaviour of the ceph if the command is started.
> 
> dmesg shows:
> -------------
> [99048.567704] ------------[ cut here ]------------
> [99048.568767] kernel BUG at
> /build/buildd/linux-2.6.32/fs/ext3/balloc.c:1384!
> [99048.568767] invalid opcode: 0000 [#1] SMP
> [99048.568767] last sysfs file: /sys/devices/pci0000:00/0000:00:00.0/device
> [99048.596652] Modules linked in: nfs lockd nfs_acl auth_rpcgss sunrpc ceph
> crc32c libcrc32c openafs(P) fbcon tileblit font bitblit softcursor vga
> vgastate mptctl radeon ttm drm_kms_helper drm bnx2 psmouse i5000_edac
> edac_core agpgart serio_raw i5k_amb i2c_algo_bit shpchp dell_wmi dcdbas
> usbhid mptsas mptscsih mptbase scsi_transport_sas
> [99048.596652]
> [99048.596652] Pid: 6258, comm: cosd Tainted: P
> (2.6.32-24-generic-pae #41-Ubuntu) PowerEdge 1950
> [99048.596652] EIP: 0060:[<c026dc8d>] EFLAGS: 00210296 CPU: 3
> [99048.596652] EIP is at ext3_try_to_allocate_with_rsv+0x1cd/0x2b0
> [99048.596652] EAX: 00000027 EBX: f6dd5480 ECX: fffe48f7 EDX: 00000000
> [99048.596652] ESI: 02147fff EDI: f625e200 EBP: f5ccbc54 ESP: f5ccbc14
> [99048.596652]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [99048.596652] Process cosd (pid: 6258, ti=f5cca000 task=f6263300
> task.ti=f5cca000)
> [99048.596652] Stack:
> [99048.596652]  00000428 f14f1bc0 c026cc88 00001000 00000007 f1a80e9c
> f6dd5494 02147fff
> [99048.596652] <0> f70d89c0 02140000 00000428 f625d800 00000001 00000428
> f1058500 00000000
> [99048.596652] <0> f5ccbcc8 c026e048 f14f1bc0 ffffffff f6dd5480 f5ccbcb0
> f5ccbcb4 f5ccbc90
> [99048.596652] Call Trace:
> [99048.596652]  [<c026cc88>] ? read_block_bitmap+0x48/0x160
> [99048.596652]  [<c026e048>] ? ext3_new_blocks+0x228/0x6c0
> [99048.596652]  [<c024fbd7>] ? mb_cache_entry_find_first+0x67/0x80
> [99048.596652]  [<c026e505>] ? ext3_new_block+0x25/0x30
> [99048.596652]  [<c02809a4>] ? ext3_xattr_block_set+0x554/0x670
> [99048.596652]  [<c027f589>] ? ext3_xattr_set_entry+0x29/0x350
> [99048.596652]  [<c0280d8b>] ? ext3_xattr_set_handle+0x2cb/0x3e0
> [99048.596652]  [<c0280f15>] ? ext3_xattr_set+0x75/0xc0
> [99048.596652]  [<c0280fd6>] ? ext3_xattr_user_set+0x76/0x80
> [99048.596652]  [<c022dd8c>] ? generic_setxattr+0x9c/0xb0
> [99048.596652]  [<c022dcf0>] ? generic_setxattr+0x0/0xb0
> [99048.596652]  [<c022e984>] ? __vfs_setxattr_noperm+0x44/0x160
> [99048.596652]  [<c02fed4c>] ? cap_inode_setxattr+0x2c/0x60
> [99048.596652]  [<c022eb31>] ? vfs_setxattr+0x91/0xa0
> [99048.596652]  [<c022ebf8>] ? setxattr+0xb8/0x110
> [99048.596652]  [<c021d512>] ? __link_path_walk+0x632/0xca0
> [99048.596652]  [<c014e369>] ? enqueue_task_fair+0x39/0x80
> [99048.596652]  [<c022a9bf>] ? mntput_no_expire+0x1f/0xe0
> [99048.596652]  [<c022a9bf>] ? mntput_no_expire+0x1f/0xe0
> [99048.596652]  [<c021be45>] ? path_put+0x25/0x30
> [99048.596652]  [<c021ba8b>] ? putname+0x2b/0x40
> [99048.596652]  [<c021ea6a>] ? user_path_at+0x4a/0x80
> [99048.596652]  [<c0183242>] ? sys_futex+0x72/0x120
> [99048.596652]  [<c022ee13>] ? sys_setxattr+0x83/0x90
> [99048.596652]  [<c0109763>] ? sysenter_do_call+0x12/0x28
> [99048.596652] Code: 83 3a ff ff ff 90 39 45 dc c7 45 0c ff ff ff ff 0f 83 
> 32 ff ff ff 8b 87 84 01 00 00 ba ba c6 5c c0 05 d0 00 00 00 e8 73 f1 ff<0f> 
> 0b eb fe 8b 45 ec 89 55 d4 05 cc 00 00 00 89 45 ec e8 fc 53
> [99048.596652] EIP: [<c026dc8d>] ext3_try_to_allocate_with_rsv+0x1cd/0x2b0
> SS:ESP 0068:f5ccbc14
> [99049.044090] ---[ end trace 35860103963ee444 ]---
> h1farm184#
> --------------------
> 
> my ceph.conf is:
> -------
> [global]
>        pid file = /var/run/ceph/$name.pid
>        debug ms = 1
>        keyring = /etc/ceph/keyring.bin
> ; monitors
> [mon]
>        ;Directory for monitor files
>        mon data = /x02/mon$id
>        debug mon = 20
>        debug paxos = 20
>        mon lease wiggle room = 0.5
> 
> [mon0]
>        host = h1farm182
>        mon addr = xxx.xxx.xx.116:6789
> [mon1]
>        host = h1farm183
>        mon addr = xxx.xxx.xx.117:6789
> ; metadata servers
> [mds]
>        debug mds = 20
>        mds log max segments = 2
>        keyring = /etc/ceph/keyring.$name
> [mds0]
>        host = h1farm182
> [mds1]
>        host = h1farm183
> [osd]
>        sudo = true
>        osd data = /x02/osd$id
>        osd journal = /x02/osd$id/journal
>        osd journal size = 100
>        keyring = /etc/ceph/keyring.$name
>        debug osd = 20
>        debug journal = 20
>        debug filestore = 20
>        ;osd journal size = 100
> [osd0]
>        host = h1farm182
> [osd1]
>        host = h1farm183
> [osd2]
>        host = h1farm184
> 
> ------- 
> 
> Any idea how to improve the situation ?
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
