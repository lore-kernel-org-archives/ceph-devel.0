From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: rbd and ceph
Date: Tue, 15 May 2012 10:01:48 -0400 (EDT)
Message-ID: <d69c8b47-b14b-49fe-8449-715c56990bbc@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 195-67-7-55.customer.telia.com ([195.67.7.55]:39281 "EHLO
	mail.linserv.se" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755758Ab2EOODG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 May 2012 10:03:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 209932A00A
	for <ceph-devel@vger.kernel.org>; Tue, 15 May 2012 10:01:49 -0400 (EDT)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ormCr0QsX-EC for <ceph-devel@vger.kernel.org>;
	Tue, 15 May 2012 10:01:48 -0400 (EDT)
Received: from mail.linserv.se (mail.linserv.se [195.67.7.55])
	by mail.linserv.se (Postfix) with ESMTP id 502062A002
	for <ceph-devel@vger.kernel.org>; Tue, 15 May 2012 10:01:48 -0400 (EDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I have a xenhost using rbd device for the guests. In the guest I have a mounted ceph file system.
From time to time I get the guest hanging and I have the following error in my logfiles on the guest.

Maybe I should not use both rbd and ceph ?

May 15 14:13:18 lintx2 kernel: [ 3560.225095] Modules linked in: cryptd aes_x86_64 aes_generic cbc ceph libceph crc32c libcrc32c evdev snd_pcm snd_timer snd soundcore snd_page_alloc pcspkr ext3 jbd mbcache xen_netfront xen_blkfront
May 15 14:13:18 lintx2 kernel: [ 3560.225140] Pid: 18, comm: kworker/0:1 Tainted: G        W    3.2.0-0.bpo.2-amd64 #1
May 15 14:13:18 lintx2 kernel: [ 3560.225148] Call Trace:
May 15 14:13:18 lintx2 kernel: [ 3560.225155]  [<ffffffff810497b4>] ? warn_slowpath_common+0x78/0x8c
May 15 14:13:18 lintx2 kernel: [ 3560.225167]  [<ffffffffa00db647>] ? ceph_add_cap+0x38e/0x49e [ceph]
May 15 14:13:18 lintx2 kernel: [ 3560.225178]  [<ffffffffa00d220a>] ? fill_inode+0x4eb/0x602 [ceph]
May 15 14:13:18 lintx2 kernel: [ 3560.225186]  [<ffffffff811157ad>] ? __d_instantiate+0x8b/0xda
May 15 14:13:18 lintx2 kernel: [ 3560.225197]  [<ffffffffa00d317d>] ? ceph_readdir_prepopulate+0x2de/0x375 [ceph]
May 15 14:13:18 lintx2 kernel: [ 3560.225209]  [<ffffffffa00e2d3f>] ? dispatch+0xa35/0xef2 [ceph]
May 15 14:13:18 lintx2 kernel: [ 3560.225220]  [<ffffffffa00ae841>] ? ceph_tcp_recvmsg+0x43/0x4f [libceph]
May 15 14:13:18 lintx2 kernel: [ 3560.225231]  [<ffffffffa00b0821>] ? con_work+0x1070/0x13b8 [libceph]
May 15 14:13:18 lintx2 kernel: [ 3560.225240]  [<ffffffff81006f7f>] ? xen_restore_fl_direct_reloc+0x4/0x4
May 15 14:13:18 lintx2 kernel: [ 3560.225248]  [<ffffffff81044549>] ? update_curr+0xbc/0x160
May 15 14:13:18 lintx2 kernel: [ 3560.225259]  [<ffffffffa00af7b1>] ? try_write+0xbe1/0xbe1 [libceph]
May 15 14:13:18 lintx2 kernel: [ 3560.225268]  [<ffffffff8105f897>] ? process_one_work+0x1cc/0x2ea
May 15 14:13:18 lintx2 kernel: [ 3560.225277]  [<ffffffff8105fae2>] ? worker_thread+0x12d/0x247
May 15 14:13:18 lintx2 kernel: [ 3560.225285]  [<ffffffff8105f9b5>] ? process_one_work+0x2ea/0x2ea
May 15 14:13:18 lintx2 kernel: [ 3560.225294]  [<ffffffff810632ed>] ? kthread+0x7a/0x82
May 15 14:13:18 lintx2 kernel: [ 3560.225302]  [<ffffffff8136b974>] ? kernel_thread_helper+0x4/0x10
May 15 14:13:18 lintx2 kernel: [ 3560.225311]  [<ffffffff81369a33>] ? int_ret_from_sys_call+0x7/0x1b
May 15 14:13:18 lintx2 kernel: [ 3560.225319]  [<ffffffff8136453c>] ? retint_restore_args+0x5/0x6
May 15 14:13:18 lintx2 kernel: [ 3560.225328]  [<ffffffff8136b970>] ? gs_change+0x13/0x13
May 15 14:13:18 lintx2 kernel: [ 3560.225335] ---[ end trace 111652db8892cd8b ]---
May 15 14:13:19 lintx2 kernel: [ 3560.467074] ------------[ cut here ]------------
May 15 14:13:19 lintx2 kernel: [ 3560.467086] WARNING: at /build/buildd-linux-2.6_3.2.15-1~bpo60+1-amd64-Rdi2JW/linux-2.6-3.2.15/debian/build/source_amd64_none/fs/ceph/caps.c:590 ceph_add_cap+0x38e/0x49e [ceph]()
May 15 14:13:19 lintx2 kernel: [ 3560.467102] Modules linked in: cryptd aes_x86_64 aes_generic cbc ceph libceph crc32c libcrc32c evdev snd_pcm snd_timer snd soundcore snd_page_alloc pcspkr ext3 jbd mbcache xen_netfront xen_blkfront
May 15 14:13:19 lintx2 kernel: [ 3560.467147] Pid: 18, comm: kworker/0:1 Tainted: G        W    3.2.0-0.bpo.2-amd64 #1
May 15 14:13:19 lintx2 kernel: [ 3560.467155] Call Trace:
May 15 14:13:19 lintx2 kernel: [ 3560.467163]  [<ffffffff810497b4>] ? warn_slowpath_common+0x78/0x8c
May 15 14:13:19 lintx2 kernel: [ 3560.467175]  [<ffffffffa00db647>] ? ceph_add_cap+0x38e/0x49e [ceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467187]  [<ffffffffa00d220a>] ? fill_inode+0x4eb/0x602 [ceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467196]  [<ffffffff811157ad>] ? __d_instantiate+0x8b/0xda
May 15 14:13:19 lintx2 kernel: [ 3560.467207]  [<ffffffffa00d317d>] ? ceph_readdir_prepopulate+0x2de/0x375 [ceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467220]  [<ffffffffa00e2d3f>] ? dispatch+0xa35/0xef2 [ceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467229]  [<ffffffff8136453c>] ? retint_restore_args+0x5/0x6
May 15 14:13:19 lintx2 kernel: [ 3560.467241]  [<ffffffffa00ae841>] ? ceph_tcp_recvmsg+0x43/0x4f [libceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467252]  [<ffffffffa00b0821>] ? con_work+0x1070/0x13b8 [libceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467262]  [<ffffffff81006f7f>] ? xen_restore_fl_direct_reloc+0x4/0x4
May 15 14:13:19 lintx2 kernel: [ 3560.467271]  [<ffffffff81044549>] ? update_curr+0xbc/0x160
May 15 14:13:19 lintx2 kernel: [ 3560.467280]  [<ffffffff81362d0d>] ? __schedule+0x5a0/0x5cd
May 15 14:13:19 lintx2 kernel: [ 3560.467290]  [<ffffffffa00af7b1>] ? try_write+0xbe1/0xbe1 [libceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467299]  [<ffffffff8105f897>] ? process_one_work+0x1cc/0x2ea
May 15 14:13:19 lintx2 kernel: [ 3560.467308]  [<ffffffff8105fae2>] ? worker_thread+0x12d/0x247
May 15 14:13:19 lintx2 kernel: [ 3560.467317]  [<ffffffff8105f9b5>] ? process_one_work+0x2ea/0x2ea
May 15 14:13:19 lintx2 kernel: [ 3560.467325]  [<ffffffff810632ed>] ? kthread+0x7a/0x82
May 15 14:13:19 lintx2 kernel: [ 3560.467334]  [<ffffffff8136b974>] ? kernel_thread_helper+0x4/0x10
May 15 14:13:19 lintx2 kernel: [ 3560.467343]  [<ffffffff81369a33>] ? int_ret_from_sys_call+0x7/0x1b
May 15 14:13:19 lintx2 kernel: [ 3560.467352]  [<ffffffff8136453c>] ? retint_restore_args+0x5/0x6
May 15 14:13:19 lintx2 kernel: [ 3560.467361]  [<ffffffff8136b970>] ? gs_change+0x13/0x13
May 15 14:13:19 lintx2 kernel: [ 3560.467368] ---[ end trace 111652db8892cd8c ]---
May 15 14:13:19 lintx2 kernel: [ 3560.467384] ------------[ cut here ]------------
May 15 14:13:19 lintx2 kernel: [ 3560.467395] WARNING: at /build/buildd-linux-2.6_3.2.15-1~bpo60+1-amd64-Rdi2JW/linux-2.6-3.2.15/debian/build/source_amd64_none/fs/ceph/caps.c:590 ceph_add_cap+0x38e/0x49e [ceph]()
May 15 14:13:19 lintx2 kernel: [ 3560.467408] Modules linked in: cryptd aes_x86_64 aes_generic cbc ceph libceph crc32c libcrc32c evdev snd_pcm snd_timer snd soundcore snd_page_alloc pcspkr ext3 jbd mbcache xen_netfront xen_blkfront
May 15 14:13:19 lintx2 kernel: [ 3560.467452] Pid: 18, comm: kworker/0:1 Tainted: G        W    3.2.0-0.bpo.2-amd64 #1
May 15 14:13:19 lintx2 kernel: [ 3560.467460] Call Trace:
May 15 14:13:19 lintx2 kernel: [ 3560.467467]  [<ffffffff810497b4>] ? warn_slowpath_common+0x78/0x8c
May 15 14:13:19 lintx2 kernel: [ 3560.467478]  [<ffffffffa00db647>] ? ceph_add_cap+0x38e/0x49e [ceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467489]  [<ffffffffa00d220a>] ? fill_inode+0x4eb/0x602 [ceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467498]  [<ffffffff811157ad>] ? __d_instantiate+0x8b/0xda
May 15 14:13:19 lintx2 kernel: [ 3560.467508]  [<ffffffffa00d317d>] ? ceph_readdir_prepopulate+0x2de/0x375 [ceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467521]  [<ffffffffa00e2d3f>] ? dispatch+0xa35/0xef2 [ceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467529]  [<ffffffff8136453c>] ? retint_restore_args+0x5/0x6
May 15 14:13:19 lintx2 kernel: [ 3560.467540]  [<ffffffffa00ae841>] ? ceph_tcp_recvmsg+0x43/0x4f [libceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467551]  [<ffffffffa00b0821>] ? con_work+0x1070/0x13b8 [libceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467560]  [<ffffffff81006f7f>] ? xen_restore_fl_direct_reloc+0x4/0x4
May 15 14:13:19 lintx2 kernel: [ 3560.467569]  [<ffffffff81044549>] ? update_curr+0xbc/0x160
May 15 14:13:19 lintx2 kernel: [ 3560.467577]  [<ffffffff81362d0d>] ? __schedule+0x5a0/0x5cd
May 15 14:13:19 lintx2 kernel: [ 3560.467587]  [<ffffffffa00af7b1>] ? try_write+0xbe1/0xbe1 [libceph]
May 15 14:13:19 lintx2 kernel: [ 3560.467596]  [<ffffffff8105f897>] ? process_one_work+0x1cc/0x2ea
May 15 14:13:19 lintx2 kernel: [ 3560.467605]  [<ffffffff8105fae2>] ? worker_thread+0x12d/0x247
May 15 14:13:19 lintx2 kernel: [ 3560.467613]  [<ffffffff8105f9b5>] ? process_one_work+0x2ea/0x2ea
May 15 14:13:19 lintx2 kernel: [ 3560.467622]  [<ffffffff810632ed>] ? kthread+0x7a/0x82
May 15 14:13:19 lintx2 kernel: [ 3560.467630]  [<ffffffff8136b974>] ? kernel_thread_helper+0x4/0x10
May 15 14:13:19 lintx2 kernel: [ 3560.467639]  [<ffffffff81369a33>] ? int_ret_from_sys_call+0x7/0x1b
May 15 14:13:19 lintx2 kernel: [ 3560.467647]  [<ffffffff8136453c>] ? retint_restore_args+0x5/0x6
May 15 14:13:19 lintx2 kernel: [ 3560.467656]  [<ffffffff8136b970>] ? gs_change+0x13/0x13
May 15 14:13:19 lintx2 kernel: [ 3560.467663] ---[ end trace 111652db8892cd8d ]---
May 15 14:13:19 lintx2 kernel: [ 3560.467777] ------------[ cut here ]------------
May 15 14:13:19 lintx2 kernel: [ 3560.467787] WARNING: at /build/buildd-linux-2.6_3.2.15-1~bpo60+1-amd64-Rdi2JW/linux-2.6-3.2.15/debian/build/source_amd64_none/fs/ceph/caps.c:590 ceph_add_cap+0x38e/0x49e [ceph]()
May 15 14:13:19 lintx2 kernel: [ 3560.467801] Modules linked in: cryptd aes_x86_64 aes_generic cbc ceph libceph crc32c libcrc32c evdev snd_pcm snd_timer snd soundcore snd_page_alloc pcspkr ext3 jbd mbcache xen_netfront xen_blkfront
May 15 14:13:19 lintx2 kernel: [ 3560.470923] Pid: 18, comm: kworker/0:1 Tainted: G        W    3.2.0-0.bpo.2-amd64 #1
May 15 14:13:19 lintx2 kernel: [ 3560.470923] Call Trace:
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff810497b4>] ? warn_slowpath_common+0x78/0x8c
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffffa00db647>] ? ceph_add_cap+0x38e/0x49e [ceph]
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffffa00d220a>] ? fill_inode+0x4eb/0x602 [ceph]
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff811157ad>] ? __d_instantiate+0x8b/0xda
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffffa00d317d>] ? ceph_readdir_prepopulate+0x2de/0x375 [ceph]
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffffa00e2d3f>] ? dispatch+0xa35/0xef2 [ceph]
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff8136453c>] ? retint_restore_args+0x5/0x6
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffffa00ae841>] ? ceph_tcp_recvmsg+0x43/0x4f [libceph]
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffffa00b0821>] ? con_work+0x1070/0x13b8 [libceph]
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff81006f7f>] ? xen_restore_fl_direct_reloc+0x4/0x4
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff81044549>] ? update_curr+0xbc/0x160
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff81362d0d>] ? __schedule+0x5a0/0x5cd
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffffa00af7b1>] ? try_write+0xbe1/0xbe1 [libceph]
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff8105f897>] ? process_one_work+0x1cc/0x2ea
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff8105fae2>] ? worker_thread+0x12d/0x247
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff8105f9b5>] ? process_one_work+0x2ea/0x2ea
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff810632ed>] ? kthread+0x7a/0x82
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff8136b974>] ? kernel_thread_helper+0x4/0x10
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff81369a33>] ? int_ret_from_sys_call+0x7/0x1b
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff8136453c>] ? retint_restore_args+0x5/0x6
May 15 14:13:19 lintx2 kernel: [ 3560.470923]  [<ffffffff8136b970>] ? gs_change+0x13/0x13
May 15 14:13:19 lintx2 kernel: [ 3560.470923] ---[ end trace 111652db8892cd8e ]---

Regards
Martin 
