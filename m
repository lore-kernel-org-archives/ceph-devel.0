From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] libceph: do not crash on large auth tickets
Date: Thu, 30 Oct 2014 09:33:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410300932030.15740@cobra.newdream.net>
References: <1414425929-10625-1-git-send-email-idryomov@redhat.com> <alpine.DEB.2.00.1410300805270.27022@cobra.newdream.net> <CALFYKtCnc5Te6n+-pYYXDQfnxVBFdtjc6Cnys_1ok6SPVbDWiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46021 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760406AbaJ3QdW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 12:33:22 -0400
In-Reply-To: <CALFYKtCnc5Te6n+-pYYXDQfnxVBFdtjc6Cnys_1ok6SPVbDWiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 30 Oct 2014, Ilya Dryomov wrote:
> On Thu, Oct 30, 2014 at 6:10 PM, Sage Weil <sage@newdream.net> wrote:
> > On Mon, 27 Oct 2014, Ilya Dryomov wrote:
> >> Large (greater than 32k, the value of PAGE_ALLOC_COSTLY_ORDER) auth
> >> tickets will have their buffers vmalloc'ed, which leads to the
> >> following crash in crypto:
> >>
> >> [   28.685082] BUG: unable to handle kernel paging request at ffffeb04000032c0
> >> [   28.686032] IP: [<ffffffff81392b42>] scatterwalk_pagedone+0x22/0x80
> >> [   28.686032] PGD 0
> >> [   28.688088] Oops: 0000 [#1] PREEMPT SMP
> >> [   28.688088] Modules linked in:
> >> [   28.688088] CPU: 0 PID: 878 Comm: kworker/0:2 Not tainted 3.17.0-vm+ #305
> >> [   28.688088] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
> >> [   28.688088] Workqueue: ceph-msgr con_work
> >> [   28.688088] task: ffff88011a7f9030 ti: ffff8800d903c000 task.ti: ffff8800d903c000
> >> [   28.688088] RIP: 0010:[<ffffffff81392b42>]  [<ffffffff81392b42>] scatterwalk_pagedone+0x22/0x80
> >> [   28.688088] RSP: 0018:ffff8800d903f688  EFLAGS: 00010286
> >> [   28.688088] RAX: ffffeb04000032c0 RBX: ffff8800d903f718 RCX: ffffeb04000032c0
> >> [   28.688088] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8800d903f750
> >> [   28.688088] RBP: ffff8800d903f688 R08: 00000000000007de R09: ffff8800d903f880
> >> [   28.688088] R10: 18df467c72d6257b R11: 0000000000000000 R12: 0000000000000010
> >> [   28.688088] R13: ffff8800d903f750 R14: ffff8800d903f8a0 R15: 0000000000000000
> >> [   28.688088] FS:  00007f50a41c7700(0000) GS:ffff88011fc00000(0000) knlGS:0000000000000000
> >> [   28.688088] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> >> [   28.688088] CR2: ffffeb04000032c0 CR3: 00000000da3f3000 CR4: 00000000000006b0
> >> [   28.688088] Stack:
> >> [   28.688088]  ffff8800d903f698 ffffffff81392ca8 ffff8800d903f6e8 ffffffff81395d32
> >> [   28.688088]  ffff8800dac96000 ffff880000000000 ffff8800d903f980 ffff880119b7e020
> >> [   28.688088]  ffff880119b7e010 0000000000000000 0000000000000010 0000000000000010
> >> [   28.688088] Call Trace:
> >> [   28.688088]  [<ffffffff81392ca8>] scatterwalk_done+0x38/0x40
> >> [   28.688088]  [<ffffffff81392ca8>] scatterwalk_done+0x38/0x40
> >> [   28.688088]  [<ffffffff81395d32>] blkcipher_walk_done+0x182/0x220
> >> [   28.688088]  [<ffffffff813990bf>] crypto_cbc_encrypt+0x15f/0x180
> >> [   28.688088]  [<ffffffff81399780>] ? crypto_aes_set_key+0x30/0x30
> >> [   28.688088]  [<ffffffff8156c40c>] ceph_aes_encrypt2+0x29c/0x2e0
> >> [   28.688088]  [<ffffffff8156d2a3>] ceph_encrypt2+0x93/0xb0
> >> [   28.688088]  [<ffffffff8156d7da>] ceph_x_encrypt+0x4a/0x60
> >> [   28.688088]  [<ffffffff8155b39d>] ? ceph_buffer_new+0x5d/0xf0
> >> [   28.688088]  [<ffffffff8156e837>] ceph_x_build_authorizer.isra.6+0x297/0x360
> >> [   28.688088]  [<ffffffff8112089b>] ? kmem_cache_alloc_trace+0x11b/0x1c0
> >> [   28.688088]  [<ffffffff8156b496>] ? ceph_auth_create_authorizer+0x36/0x80
> >> [   28.688088]  [<ffffffff8156ed83>] ceph_x_create_authorizer+0x63/0xd0
> >> [   28.688088]  [<ffffffff8156b4b4>] ceph_auth_create_authorizer+0x54/0x80
> >> [   28.688088]  [<ffffffff8155f7c0>] get_authorizer+0x80/0xd0
> >> [   28.688088]  [<ffffffff81555a8b>] prepare_write_connect+0x18b/0x2b0
> >> [   28.688088]  [<ffffffff81559289>] try_read+0x1e59/0x1f10
> >>
> >> This is because we set up crypto scatterlists as if all buffers were
> >> kmalloc'ed.  Fix it.
> >>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
> >> ---
> >>  net/ceph/crypto.c |   33 +++++++++++++++++++++++++--------
> >>  1 file changed, 25 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
> >> index 62fc5e7a9acf..37a9b5eea3c3 100644
> >> --- a/net/ceph/crypto.c
> >> +++ b/net/ceph/crypto.c
> >> @@ -90,6 +90,27 @@ static struct crypto_blkcipher *ceph_crypto_alloc_cipher(void)
> >>
> >>  static const u8 *aes_iv = (u8 *)CEPH_AES_IV;
> >>
> >> +/*
> >> + * Should be used for buffers allocated with ceph_kvmalloc().
> >> + * Currently these are encrypt out-buffer (ceph_buffer) and decrypt
> >> + * in-buffer (msg front).  @buf has to fit in a single page.
> 
>                                ^^^^
> 
> >> + */
> >> +static void set_kvmalloc_buf(struct scatterlist *sg, const void *buf,
> >> +                          size_t len)
> >> +{
> >> +     const void *sg_buf;
> >> +     unsigned long off = offset_in_page(buf);
> >> +
> >> +     BUG_ON(off + len > PAGE_SIZE);
> 
>          ^^^^
> 
> >> +
> >> +     if (is_vmalloc_addr(buf))
> >> +             sg_buf = page_address(vmalloc_to_page(buf)) + off;
> >
> > I'm not very familiar with the vm stuff, but this confuses me.  It looks
> > like it's taking the low memory (physical?) address of the first page in
> > the vmalloc'ed range.  But the whole point of vmalloc is that it is
> > allocating non-contiguous physical memory.  How does the sg code
> > traverse the rest of the buffer if it isn't using the virtual addresses
> > that vmalloc set up?
> 
> It doesn't - the buffer has to fit in a single page, works for the
> current users.  To make it work with multiple pages we'd have to
> allocate one sg per page and init each of them in this (or similar)
> fashion.

I see now (and I should read the comments next time :).  We talked about 
this in standup, but I'm a bit worried that this breaks when the small 
range we care about spans as page boundary in the vmalloc range.  Even if 
we don't ever trigger that today, we should at least call it out clearly 
so that it's less of a surprise when a new user trips over it...

sage

