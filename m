From: Sage Weil <sage@inktank.com>
Subject: Re: rbd and ceph
Date: Tue, 15 May 2012 09:24:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205150919190.26847@cobra.newdream.net>
References: <d69c8b47-b14b-49fe-8449-715c56990bbc@mail.linserv.se>
 <4FB27FDA.1080104@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36912 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965707Ab2EOQYG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 May 2012 12:24:06 -0400
In-Reply-To: <4FB27FDA.1080104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Martin Wilderoth <martin.wilderoth@linserv.se>, ceph-devel@vger.kernel.org

On Tue, 15 May 2012, Josh Durgin wrote:
> On 05/15/2012 07:01 AM, Martin Wilderoth wrote:
> > Hello,
> > 
> > I have a xenhost using rbd device for the guests. In the guest I have a
> > mounted ceph file system.
> >  From time to time I get the guest hanging and I have the following error in
> > my logfiles on the guest.
> > 
> > Maybe I should not use both rbd and ceph ?
> 
> While it's not a well tested configuration, I don't see any reason this
> wouldn't work. Sage, Alex, are there any shared resources in libceph
> that would cause problems with this?

There shouldn't be any problems with running rbd + ceph together.

> > May 15 14:13:18 lintx2 kernel: [ 3560.225095] Modules linked in: cryptd
> > aes_x86_64 aes_generic cbc ceph libceph crc32c libcrc32c evdev snd_pcm
> > snd_timer snd soundcore snd_page_alloc pcspkr ext3 jbd mbcache xen_netfront
> > xen_blkfront
> > May 15 14:13:18 lintx2 kernel: [ 3560.225140] Pid: 18, comm: kworker/0:1
> > Tainted: G        W    3.2.0-0.bpo.2-amd64 #1
> > May 15 14:13:18 lintx2 kernel: [ 3560.225148] Call Trace:
> > May 15 14:13:18 lintx2 kernel: [ 3560.225155]  [<ffffffff810497b4>] ?
> > warn_slowpath_common+0x78/0x8c
> > May 15 14:13:18 lintx2 kernel: [ 3560.225167]  [<ffffffffa00db647>] ?
> > ceph_add_cap+0x38e/0x49e [ceph]
> > May 15 14:13:18 lintx2 kernel: [ 3560.225178]  [<ffffffffa00d220a>] ?
> > fill_inode+0x4eb/0x602 [ceph]
> > May 15 14:13:18 lintx2 kernel: [ 3560.225186]  [<ffffffff811157ad>] ?
> > __d_instantiate+0x8b/0xda
> > May 15 14:13:18 lintx2 kernel: [ 3560.225197]  [<ffffffffa00d317d>] ?
> > ceph_readdir_prepopulate+0x2de/0x375 [ceph]
> > May 15 14:13:18 lintx2 kernel: [ 3560.225209]  [<ffffffffa00e2d3f>] ?
> > dispatch+0xa35/0xef2 [ceph]
> > May 15 14:13:18 lintx2 kernel: [ 3560.225220]  [<ffffffffa00ae841>] ?
> > ceph_tcp_recvmsg+0x43/0x4f [libceph]
> > May 15 14:13:18 lintx2 kernel: [ 3560.225231]  [<ffffffffa00b0821>] ?
> > con_work+0x1070/0x13b8 [libceph]
> > May 15 14:13:18 lintx2 kernel: [ 3560.225240]  [<ffffffff81006f7f>] ?
> > xen_restore_fl_direct_reloc+0x4/0x4
> > May 15 14:13:18 lintx2 kernel: [ 3560.225248]  [<ffffffff81044549>] ?
> > update_curr+0xbc/0x160
> > May 15 14:13:18 lintx2 kernel: [ 3560.225259]  [<ffffffffa00af7b1>] ?
> > try_write+0xbe1/0xbe1 [libceph]
> > May 15 14:13:18 lintx2 kernel: [ 3560.225268]  [<ffffffff8105f897>] ?
> > process_one_work+0x1cc/0x2ea
> > May 15 14:13:18 lintx2 kernel: [ 3560.225277]  [<ffffffff8105fae2>] ?
> > worker_thread+0x12d/0x247
> > May 15 14:13:18 lintx2 kernel: [ 3560.225285]  [<ffffffff8105f9b5>] ?
> > process_one_work+0x2ea/0x2ea
> > May 15 14:13:18 lintx2 kernel: [ 3560.225294]  [<ffffffff810632ed>] ?
> > kthread+0x7a/0x82
> > May 15 14:13:18 lintx2 kernel: [ 3560.225302]  [<ffffffff8136b974>] ?
> > kernel_thread_helper+0x4/0x10
> > May 15 14:13:18 lintx2 kernel: [ 3560.225311]  [<ffffffff81369a33>] ?
> > int_ret_from_sys_call+0x7/0x1b
> > May 15 14:13:18 lintx2 kernel: [ 3560.225319]  [<ffffffff8136453c>] ?
> > retint_restore_args+0x5/0x6
> > May 15 14:13:18 lintx2 kernel: [ 3560.225328]  [<ffffffff8136b970>] ?
> > gs_change+0x13/0x13
> > May 15 14:13:18 lintx2 kernel: [ 3560.225335] ---[ end trace
> > 111652db8892cd8b ]---
> 
> The only warning in ceph_add_cap is when it can't lookup the snap
> realm. I'm not sure if this has any real consequences. Sage?

Not really.  It is a bug, but you're seeing the _guest_ hang, not the fs, 
right?  I suspect there is something else going on, and this is a red 
herring.

FWIW, I've seen two RBD kernel hangs in the last few days in our QA (under 
xfstests workload).  We're still looking into that.

sage
