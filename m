From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Fscache support for Ceph
Date: Wed, 29 May 2013 09:35:48 -0400
Message-ID: <CANP1eJG1EoC916mBXMvh2vk8m0cQzxQ92Dh2qQq8fg+eQzLaMA@mail.gmail.com>
References: <CANP1eJHjpUJ1ZFszAy=ZsAvZKpPDFMHjNj7JRRUhV88yuH0dyg@mail.gmail.com>
	<CAKxz0mwqStYgeHnCvYokizsJXoe_cOccMSjx8L=EO9rFPyaK_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46016 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759457Ab3E2Nfs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 May 2013 09:35:48 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so1594719iec.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 06:35:48 -0700 (PDT)
In-Reply-To: <CAKxz0mwqStYgeHnCvYokizsJXoe_cOccMSjx8L=EO9rFPyaK_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elso Andras <elso.andras@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-cachefs@redhat.com

Elbandi,

Thanks to your stack trace I see the bug. I'll send you a fix as soon
as I get back to my office. Apparently, I spent too much time testing
it in UP vms and UML.

Thanks,
-- Milosz

On Wed, May 29, 2013 at 5:47 AM, Elso Andras <elso.andras@gmail.com> wrote:
> Hi,
>
> I try your fscache patch on my test cluster. the client node is a
> ubuntu lucid (10.4) with 3.8 kernel (*) + your patch.
> Little after i mount the cephfs, i got this:
>
> [  316.303851] Pid: 1565, comm: lighttpd Not tainted 3.8.0-22-fscache
> #33 HP ProLiant DL160 G6
> [  316.303853] RIP: 0010:[<ffffffff81045c42>]  [<ffffffff81045c42>]
> __ticket_spin_lock+0x22/0x30
> [  316.303861] RSP: 0018:ffff8804180e79f8  EFLAGS: 00000297
> [  316.303863] RAX: 0000000000000004 RBX: ffffffffa0224e53 RCX: 0000000000000004
> [  316.303865] RDX: 0000000000000005 RSI: 00000000000000d0 RDI: ffff88041eb29a50
> [  316.303866] RBP: ffff8804180e79f8 R08: ffffe8ffffa40150 R09: 0000000000000000
> [  316.303868] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88041da75050
> [  316.303869] R13: ffff880428ef0000 R14: ffffffff81702b86 R15: ffff8804180e7968
> [  316.303871] FS:  00007fbcca138700(0000) GS:ffff88042f240000(0000)
> knlGS:0000000000000000
> [  316.303873] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  316.303875] CR2: 00007f5c96649f00 CR3: 00000004180c9000 CR4: 00000000000007e0
> [  316.303877] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  316.303878] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [  316.303880] Process lighttpd (pid: 1565, threadinfo
> ffff8804180e6000, task ffff88041cc22e80)
> [  316.303881] Stack:
> [  316.303883]  ffff8804180e7a08 ffffffff817047ae ffff8804180e7a58
> ffffffffa02c816a
> [  316.303886]  ffff8804180e7a58 ffff88041eb29a50 0000000000000000
> ffff88041eb29d50
> [  316.303889]  ffff88041eb29a50 ffff88041b29ed00 ffff88041eb29a40
> 0000000000000d01
> [  316.303892] Call Trace:
> [  316.303898]  [<ffffffff817047ae>] _raw_spin_lock+0xe/0x20
> [  316.303910]  [<ffffffffa02c816a>] ceph_init_file+0xca/0x1c0 [ceph]
> [  316.303917]  [<ffffffffa02c83e1>] ceph_open+0x181/0x3c0 [ceph]
> [  316.303925]  [<ffffffffa02c8260>] ? ceph_init_file+0x1c0/0x1c0 [ceph]
> [  316.303930]  [<ffffffff8119a62e>] do_dentry_open+0x21e/0x2a0
> [  316.303933]  [<ffffffff8119a6e5>] finish_open+0x35/0x50
> [  316.303940]  [<ffffffffa02c9304>] ceph_atomic_open+0x214/0x2f0 [ceph]
> [  316.303944]  [<ffffffff811b416f>] ? __d_alloc+0x5f/0x180
> [  316.303948]  [<ffffffff811a7fa1>] atomic_open+0xf1/0x460
> [  316.303951]  [<ffffffff811a86f4>] lookup_open+0x1a4/0x1d0
> [  316.303954]  [<ffffffff811a8fad>] do_last+0x30d/0x820
> [  316.303958]  [<ffffffff811ab413>] path_openat+0xb3/0x4d0
> [  316.303962]  [<ffffffff815da87d>] ? sock_aio_read+0x2d/0x40
> [  316.303965]  [<ffffffff8119c333>] ? do_sync_read+0xa3/0xe0
> [  316.303968]  [<ffffffff811ac232>] do_filp_open+0x42/0xa0
> [  316.303971]  [<ffffffff811b9eb5>] ? __alloc_fd+0xe5/0x170
> [  316.303974]  [<ffffffff8119be8a>] do_sys_open+0xfa/0x250
> [  316.303977]  [<ffffffff8119cacd>] ? vfs_read+0x10d/0x180
> [  316.303980]  [<ffffffff8119c001>] sys_open+0x21/0x30
> [  316.303983]  [<ffffffff8170d61d>] system_call_fastpath+0x1a/0x1f
>
> And the console print this lines forever, server is freezed:
> [  376.305754] BUG: soft lockup - CPU#2 stuck for 22s! [lighttpd:1565]
> [  404.294735] BUG: soft lockup - CPU#1 stuck for 22s! [kworker/1:1:39]
> [  404.306735] BUG: soft lockup - CPU#2 stuck for 22s! [lighttpd:1565]
> [  432.295716] BUG: soft lockup - CPU#1 stuck for 22s! [kworker/1:1:39]
>
> Have you any idea?
>
> Elbandi
>
> * http://packages.ubuntu.com/raring/linux-image-3.8.0-19-generic
>
> 2013/5/23 Milosz Tanski <milosz@adfin.com>:
>> This is my first at adding fscache support for the Ceph Linux module.
>>
>> My motivation for doing this work was speedup our distributed database
>> that uses the Ceph filesystem as a backing store. By far more of the
>> workload that our application is doing is read only and latency is our
>> biggest challenge. Being able to cache frequently used blocks on the
>> SSD drives that our machines use dramatically speeds up our query
>> setup time when we're fetching multiple compressed indexes and then
>> navigating the block tree.
>>
>> The branch containing the two patches is here:
>> https://bitbucket.org/adfin/linux-fs.git in the forceph branch.
>>
>> If you want to review it in your browser here is the bitbucket url:
>> https://bitbucket.org/adfin/linux-fs/commits/branch/forceph
>>
>> I've tested this both in mainline and in the branch that features
>> upcoming fscache changes. The patches are broken into two pieces.
>>
>> 01 - Setups the facility for fscache in it's independent files
>> 02 - Enables fscache in the ceph filesystem and adds a new configuration option
>>
>> The patches will follow in the new few emails as well.
>>
>> Future wise; there's some new work being done to add write-back
>> caching to fscache & NFS. When that's done I'd like to integrated the
>> Ceph fscache implementation. From the benchmarks of the author of that
>> it seams like it has much the same benefit for write to NFS as bcache
>> does.
>>
>> I'd like to get this into ceph, and I'm looking for feedback.
>>
>> Thanks,
>> - Milosz
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
