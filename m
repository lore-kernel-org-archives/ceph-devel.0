From: Sage Weil <sage@inktank.com>
Subject: Re: ceph fs
Date: Sun, 3 Jun 2012 17:42:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206031734380.13750@cobra.newdream.net>
References: <fce756f2-a2b0-4c5b-9c61-5ea34b384e20@mail.linserv.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59234 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab2FDAmQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Jun 2012 20:42:16 -0400
In-Reply-To: <fce756f2-a2b0-4c5b-9c61-5ea34b384e20@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Martin,

On Sat, 2 Jun 2012, Martin Wilderoth wrote:

> I have some problems with my ceph filesystem. I have a folder that i 
> cant remove.
> 
> I.E.
> root@lintx2:/mnt/backuppc/pc# ls -la toberemoved/ 
> total 0
> drwxr-x--- 1 backuppc backuppc    28804802 May 15 13:29 .
> drwxr-x--- 1 backuppc backuppc 29421083732 Jun  1 15:16 ..
> 
> root@lintx2:/mnt/backuppc/pc# rm -rf toberemoved 
> rm: cannot remove `toberemoved': Directory not empty

This is a bug in the internal rstats accounting that the rmdir is relying 
on to verify the directory is empty.  Right now, the workaround is to just 
rename that directory out of the way somewhere.  This will be at the top 
of the list of MDS bugs we'll look at when we shift focus to the fs in the 
next month or two.

http://tracker.newdream.net/issues/2494

> I also have a folder that when I do ls i get the following message
> 
> [ 1828.569091] ceph: ceph_add_cap: couldn't find snap realm 100

This too.  

In both cases, if you are able to reproduce the bug reliably, that is 
incredibly useful information that will make it much easier to fix the 
bug.  Please include that info in the tracker, if you can!

For example, on the second bug,

http://tracker.newdream.net/issues/2506

- what snapshots did you create?
- what operations were you doing that triggered the bug?
- (ideally) how do you reproduce it from a fresh fs or fresh mount?

Thanks!  Sorry we can't be more help now, but we'll get to this soon...

sage


> [ 1828.569105] ------------[ cut here ]------------
> [ 1828.569121] WARNING: at /build/buildd-linux-2.6_3.2.17-1~bpo60+1-amd64-CJo7Ex/linux-2.6-3.2.17/debian/build/source_amd64_none/fs/ceph/caps.c:590 ceph_add_cap+0x38e/0x49e [ceph]()
> [ 1828.569139] Modules linked in: cryptd aes_x86_64 aes_generic cbc ceph libceph crc32c libcrc32c evdev snd_pcm snd_timer snd soundcore snd_page_alloc pcspkr ext3 jbd mbcache xen_netfront xen_blkfront
> [ 1828.569182] Pid: 18, comm: kworker/0:1 Tainted: G        W    3.2.0-0.bpo.2-amd64 #1
> [ 1828.569193] Call Trace:
> [ 1828.569207]  [<ffffffff810497ec>] ? warn_slowpath_common+0x78/0x8c
> [ 1828.569221]  [<ffffffffa00db647>] ? ceph_add_cap+0x38e/0x49e [ceph]
> [ 1828.569233]  [<ffffffffa00d220a>] ? fill_inode+0x4eb/0x602 [ceph]
> [ 1828.569244]  [<ffffffffa00d331b>] ? ceph_dentry_lru_touch+0x2a/0x68 [ceph]
> [ 1828.569258]  [<ffffffffa00d317d>] ? ceph_readdir_prepopulate+0x2de/0x375 [ceph]
> [ 1828.569271]  [<ffffffffa00e2d3f>] ? dispatch+0xa35/0xef2 [ceph]
> [ 1828.569286]  [<ffffffffa00ae841>] ? ceph_tcp_recvmsg+0x43/0x4f [libceph]
> [ 1828.569297]  [<ffffffffa00b0821>] ? con_work+0x1070/0x13b8 [libceph]
> [ 1828.569308]  [<ffffffff81044580>] ? update_curr+0xbc/0x160
> [ 1828.569319]  [<ffffffffa00af7b1>] ? try_write+0xbe1/0xbe1 [libceph]
> [ 1828.569332]  [<ffffffff8105f8bb>] ? process_one_work+0x1cc/0x2ea
> [ 1828.569342]  [<ffffffff8105fb06>] ? worker_thread+0x12d/0x247
> [ 1828.569353]  [<ffffffff8105f9d9>] ? process_one_work+0x2ea/0x2ea
> [ 1828.569361]  [<ffffffff8105f9d9>] ? process_one_work+0x2ea/0x2ea
> [ 1828.569372]  [<ffffffff81063311>] ? kthread+0x7a/0x82
> [ 1828.569384]  [<ffffffff8136bb34>] ? kernel_thread_helper+0x4/0x10
> [ 1828.569395]  [<ffffffff81369bf3>] ? int_ret_from_sys_call+0x7/0x1b
> [ 1828.569406]  [<ffffffff813646fc>] ? retint_restore_args+0x5/0x6
> [ 1828.569417]  [<ffffffff8136bb30>] ? gs_change+0x13/0x13
> [ 1828.569423] ---[ end trace 98770cddb79a6a55 ]---
> [ 1828.569433] ceph: ceph_add_cap: couldn't find snap realm 100
> [ 1828.569442] ------------[ cut here ]------------
> [ 1828.569452] WARNING: at /build/buildd-linux-2.6_3.2.17-1~bpo60+1-amd64-CJo7Ex/linux-2.6-3.2.17/debian/build/source_amd64_none/fs/ceph/caps.c:590 ceph_add_cap+0x38e/0x49e [ceph]()
> [ 1828.569467] Modules linked in: cryptd aes_x86_64 aes_generic cbc ceph libceph crc32c libcrc32c evdev snd_pcm snd_timer snd soundcore snd_page_alloc pcspkr ext3 jbd mbcache xen_netfront xen_blkfront
> [ 1828.569500] Pid: 18, comm: kworker/0:1 Tainted: G        W    3.2.0-0.bpo.2-amd64 #1
> [ 1828.569508] Call Trace:
> [ 1828.569513]  [<ffffffff810497ec>] ? warn_slowpath_common+0x78/0x8c
> [ 1828.569523]  [<ffffffffa00db647>] ? ceph_add_cap+0x38e/0x49e [ceph]
> [ 1828.569533]  [<ffffffffa00d220a>] ? fill_inode+0x4eb/0x602 [ceph]
> [ 1828.569543]  [<ffffffffa00d331b>] ? ceph_dentry_lru_touch+0x2a/0x68 [ceph]
> [ 1828.569552]  [<ffffffffa00d317d>] ? ceph_readdir_prepopulate+0x2de/0x375 [ceph]
> [ 1828.569563]  [<ffffffffa00e2d3f>] ? dispatch+0xa35/0xef2 [ceph]
> [ 1828.569573]  [<ffffffffa00ae841>] ? ceph_tcp_recvmsg+0x43/0x4f [libceph]
> [ 1828.569583]  [<ffffffffa00b0821>] ? con_work+0x1070/0x13b8 [libceph]
> [ 1828.569590]  [<ffffffff81044580>] ? update_curr+0xbc/0x160
> [ 1828.569599]  [<ffffffffa00af7b1>] ? try_write+0xbe1/0xbe1 [libceph]
> [ 1828.569607]  [<ffffffff8105f8bb>] ? process_one_work+0x1cc/0x2ea
> [ 1828.569615]  [<ffffffff8105fb06>] ? worker_thread+0x12d/0x247
> [ 1828.569622]  [<ffffffff8105f9d9>] ? process_one_work+0x2ea/0x2ea
> [ 1828.569630]  [<ffffffff8105f9d9>] ? process_one_work+0x2ea/0x2ea
> [ 1828.569637]  [<ffffffff81063311>] ? kthread+0x7a/0x82
> [ 1828.569644]  [<ffffffff8136bb34>] ? kernel_thread_helper+0x4/0x10
> [ 1828.569652]  [<ffffffff81369bf3>] ? int_ret_from_sys_call+0x7/0x1b
> [ 1828.569660]  [<ffffffff813646fc>] ? retint_restore_args+0x5/0x6
> [ 1828.569667]  [<ffffffff8136bb30>] ? gs_change+0x13/0x13
> [ 1828.569673] ---[ end trace 98770cddb79a6a56 ]---
> Then i see some folders
> 
> Is there a way to remove this error directories or a reason / bug why I get this messages.
> 
> The folder that I try to remove had a similar problem as the one above, I manages to remove
> all visible files.
> 
>  /Regards Martin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
