From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] libceph: do not crash on large auth tickets
Date: Mon, 3 Nov 2014 14:16:51 +0400
Message-ID: <CALFYKtAXO8FX81W3QPS-4X7X3fRODtgD4Z8jjr=Jcg-esgEgbg@mail.gmail.com>
References: <1415009217-8325-1-git-send-email-idryomov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:36837 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbaKCKQw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Nov 2014 05:16:52 -0500
Received: by mail-qc0-f175.google.com with SMTP id b13so9703501qcw.20
        for <ceph-devel@vger.kernel.org>; Mon, 03 Nov 2014 02:16:51 -0800 (PST)
In-Reply-To: <1415009217-8325-1-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 3, 2014 at 1:06 PM, Ilya Dryomov <ilya.dryomov@inktank.com> wrote:
> Large (greater than 32k, the value of PAGE_ALLOC_COSTLY_ORDER) auth
> tickets will have their buffers vmalloc'ed, which leads to the
> following crash in crypto:
>
> [   28.685082] BUG: unable to handle kernel paging request at ffffeb04000032c0
> [   28.686032] IP: [<ffffffff81392b42>] scatterwalk_pagedone+0x22/0x80
> [   28.686032] PGD 0
> [   28.688088] Oops: 0000 [#1] PREEMPT SMP
> [   28.688088] Modules linked in:
> [   28.688088] CPU: 0 PID: 878 Comm: kworker/0:2 Not tainted 3.17.0-vm+ #305
> [   28.688088] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
> [   28.688088] Workqueue: ceph-msgr con_work
> [   28.688088] task: ffff88011a7f9030 ti: ffff8800d903c000 task.ti: ffff8800d903c000
> [   28.688088] RIP: 0010:[<ffffffff81392b42>]  [<ffffffff81392b42>] scatterwalk_pagedone+0x22/0x80
> [   28.688088] RSP: 0018:ffff8800d903f688  EFLAGS: 00010286
> [   28.688088] RAX: ffffeb04000032c0 RBX: ffff8800d903f718 RCX: ffffeb04000032c0
> [   28.688088] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8800d903f750
> [   28.688088] RBP: ffff8800d903f688 R08: 00000000000007de R09: ffff8800d903f880
> [   28.688088] R10: 18df467c72d6257b R11: 0000000000000000 R12: 0000000000000010
> [   28.688088] R13: ffff8800d903f750 R14: ffff8800d903f8a0 R15: 0000000000000000
> [   28.688088] FS:  00007f50a41c7700(0000) GS:ffff88011fc00000(0000) knlGS:0000000000000000
> [   28.688088] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [   28.688088] CR2: ffffeb04000032c0 CR3: 00000000da3f3000 CR4: 00000000000006b0
> [   28.688088] Stack:
> [   28.688088]  ffff8800d903f698 ffffffff81392ca8 ffff8800d903f6e8 ffffffff81395d32
> [   28.688088]  ffff8800dac96000 ffff880000000000 ffff8800d903f980 ffff880119b7e020
> [   28.688088]  ffff880119b7e010 0000000000000000 0000000000000010 0000000000000010
> [   28.688088] Call Trace:
> [   28.688088]  [<ffffffff81392ca8>] scatterwalk_done+0x38/0x40
> [   28.688088]  [<ffffffff81392ca8>] scatterwalk_done+0x38/0x40
> [   28.688088]  [<ffffffff81395d32>] blkcipher_walk_done+0x182/0x220
> [   28.688088]  [<ffffffff813990bf>] crypto_cbc_encrypt+0x15f/0x180
> [   28.688088]  [<ffffffff81399780>] ? crypto_aes_set_key+0x30/0x30
> [   28.688088]  [<ffffffff8156c40c>] ceph_aes_encrypt2+0x29c/0x2e0
> [   28.688088]  [<ffffffff8156d2a3>] ceph_encrypt2+0x93/0xb0
> [   28.688088]  [<ffffffff8156d7da>] ceph_x_encrypt+0x4a/0x60
> [   28.688088]  [<ffffffff8155b39d>] ? ceph_buffer_new+0x5d/0xf0
> [   28.688088]  [<ffffffff8156e837>] ceph_x_build_authorizer.isra.6+0x297/0x360
> [   28.688088]  [<ffffffff8112089b>] ? kmem_cache_alloc_trace+0x11b/0x1c0
> [   28.688088]  [<ffffffff8156b496>] ? ceph_auth_create_authorizer+0x36/0x80
> [   28.688088]  [<ffffffff8156ed83>] ceph_x_create_authorizer+0x63/0xd0
> [   28.688088]  [<ffffffff8156b4b4>] ceph_auth_create_authorizer+0x54/0x80
> [   28.688088]  [<ffffffff8155f7c0>] get_authorizer+0x80/0xd0
> [   28.688088]  [<ffffffff81555a8b>] prepare_write_connect+0x18b/0x2b0
> [   28.688088]  [<ffffffff81559289>] try_read+0x1e59/0x1f10
>
> This is because we set up crypto scatterlists as if all buffers were
> kmalloc'ed.  Fix it.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
> ---
> v2:
> - no single page limit

Oops, forgot to prefix the subject.  It was supposed to be

[PATCH v2] libceph: do not crash on large auth tickets

of course.

Thanks,

                Ilya
