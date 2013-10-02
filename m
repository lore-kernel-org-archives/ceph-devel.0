From: Milosz Tanski <milosz@adfin.com>
Subject: Re: hung task on page invalidate
Date: Wed, 2 Oct 2013 18:43:25 -0400
Message-ID: <CANP1eJEpH-0_XhYmk3YUXt9aovQFTj3j1=YErXEVJiHm0Ceuzg@mail.gmail.com>
References: <CANP1eJGJMDB8hgegvncmsiXh3LtT029JWCs7rhaC=3P3GU97kQ@mail.gmail.com>
	<CAAM7YAkPRtcu=QFA1n-aO0sDdAp1mKX_YZjgtOg04EhNA26kFw@mail.gmail.com>
	<CANP1eJGu6nWgqLkBAAEEtvW8zJ4r5X+KJN3iiCMnN3x_mTkWaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:40575 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807Ab3JBWn1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Oct 2013 18:43:27 -0400
Received: by mail-we0-f177.google.com with SMTP id t60so1719995wes.22
        for <ceph-devel@vger.kernel.org>; Wed, 02 Oct 2013 15:43:26 -0700 (PDT)
In-Reply-To: <CANP1eJGu6nWgqLkBAAEEtvW8zJ4r5X+KJN3iiCMnN3x_mTkWaw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: David Howells <dhowells@redhat.com>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Franklin Cheung <franklin.cheung@adfin.com>

David,

Per your request this is a stats after the kernel hang in fscache.

root@betanode1:/sys/kernel/debug/ceph/e23a1bfc-8328-46bf-bc59-1209df3f5434.client58628#
cat /proc/fs/fscache/stats
FS-Cache statistics
Cookies: idx=4 dat=133241 spc=0
Objects: alc=133243 nal=0 avl=133241 ded=58489
ChkAux : non=0 ok=12468 upd=0 obs=6033
Pages  : mrk=624003 unc=588201
Acquire: n=133245 nul=0 noc=0 ok=133245 nbf=0 oom=0
Lookups: n=133243 neg=120822 pos=12421 crt=120822 tmo=0
Invals : n=114873 run=114859
Updates: n=0 nul=0 run=114859
Relinqs: n=58491 nul=0 wcr=0 rtr=0
AttrChg: n=0 ok=0 nbf=0 oom=0 run=0
Allocs : n=0 ok=0 wt=0 nbf=0 int=0
Allocs : ops=0 owt=0 abt=0
Retrvls: n=23344 ok=11669 wt=4009 nod=11675 nbf=0 int=0 oom=0
Retrvls: ops=23344 owt=2555 abt=0
Stores : n=62230 ok=62230 agn=0 nbf=0 oom=0
Stores : ops=10257 run=67477 pgs=57220 rxd=62216 olm=14
VmScan : nos=579819 gon=0 bsy=33 can=4996 wt=0
Ops    : pend=2600 run=148508 enq=371239 can=0 rej=0
Ops    : dfr=1 rel=148508 gc=1
CacheOp: alo=0 luo=0 luc=0 gro=0
CacheOp: inv=0 upo=0 dro=0 pto=0 atc=0 syn=0
CacheOp: rap=0 ras=0 alp=0 als=0 wrp=0 ucp=0 dsp=0

On Mon, Sep 30, 2013 at 11:46 AM, Milosz Tanski <milosz@adfin.com> wrote:
> Sorry I noticed I only did reply to Yan instead of all.
>
> Yes, a couple week old master branch version (plus the patch I sent in
> recently). Why do you ask?
>
> As a side note, this is pre-David's work on cookie enable / disabled.
>
> Best,
> - Milosz
>
> On Mon, Sep 30, 2013 at 11:03 AM, Yan, Zheng <ukernel@gmail.com> wrote:
>> On Mon, Sep 30, 2013 at 1:04 AM, Milosz Tanski <milosz@adfin.com> wrote:
>>> David,
>>>
>>> In my test cluster I started seeing an issue when the fscache get
>>> stuck waiting on pending writes when doing page invalidate. The
>>> problem happens because it looks like the page never leaves the
>>> cookie->store page tree.
>>>
>>> I've been reading the different code paths in fscache/page.c to
>>> understand why this could be the case, but on first look it looks like
>>> it does the correct thing. Do you have any ideas what could be causing
>>> this / where to look for the smoking gun.
>>>
>>> I've only begun to see this recently, I think our work load on the
>>> test cluster changed a bit and it's been showing up more.
>>>
>>> Here's the backtrace:
>>>
>>> INFO: task petabucket:5889 blocked for more than 120 seconds.
>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>> petabucket      D ffff880443513fc0     0  5889      1 0x00000000
>>>  ffff8804239c3978 0000000000000282 0000000000000002 0000000000000000
>>>  ffff880424f50000 ffff8804239c3fd8 ffff8804239c3fd8 ffff8804239c3fd8
>>>  ffff88042c518000 ffff880424f50000 ffff8804239c3988 ffff88042aa5f4b0
>>> Call Trace:
>>>  [<ffffffff81568d09>] schedule+0x29/0x70
>>>  [<ffffffffa01d4cbd>] __fscache_wait_on_page_write+0x6d/0xb0 [fscache]
>>>  [<ffffffff81083520>] ? add_wait_queue+0x60/0x60
>>>  [<ffffffffa02cd3f1>] ceph_invalidate_fscache_page+0x31/0x50 [ceph]
>>>  [<ffffffffa02b0f00>] ceph_invalidatepage+0x70/0x190 [ceph]
>>>  [<ffffffff8112656f>] ? delete_from_page_cache+0x5f/0x70
>>>  [<ffffffff81133cab>] truncate_inode_page+0x8b/0x90
>>>  [<ffffffff81133ded>] truncate_inode_pages_range.part.12+0x13d/0x620
>>>  [<ffffffffa02b7b7a>] ? __ceph_caps_issued_mask+0xda/0x2b0 [ceph]
>>>  [<ffffffff8119c338>] ? iput+0x48/0x190
>>>  [<ffffffff811a9735>] ? __inode_wait_for_writeback+0x65/0xc0
>>>  [<ffffffff8113431d>] truncate_inode_pages_range+0x4d/0x60
>>>  [<ffffffff811343b5>] truncate_inode_pages+0x15/0x20
>>>  [<ffffffff8119bbf6>] evict+0x1a6/0x1b0
>>>  [<ffffffff8119c3f3>] iput+0x103/0x190
>>>  [<ffffffff81196d88>] dentry_iput+0x98/0xe0
>>>  [<ffffffff81198a4c>] dput+0x12c/0x1e0
>>>  [<ffffffff8118d4b0>] lookup_fast+0x2a0/0x2f0
>>>  [<ffffffff8118e700>] path_lookupat+0x100/0x7a0
>>>  [<ffffffff81132c4f>] ? release_pages+0x1af/0x200
>>>  [<ffffffff8118edd4>] filename_lookup+0x34/0xc0
>>>  [<ffffffff81192139>] user_path_at_empty+0x59/0xa0
>>>  [<ffffffffa02a9f36>] ? ceph_getattr+0x46/0x100 [ceph]
>>>  [<ffffffff811a0199>] ? mntput_no_expire+0x49/0x160
>>>  [<ffffffff81187127>] ? cp_new_stat+0x107/0x120
>>>  [<ffffffff81192191>] user_path_at+0x11/0x20
>>>  [<ffffffff811873a1>] vfs_fstatat+0x51/0xb0
>>>  [<ffffffff811874cb>] vfs_stat+0x1b/0x20
>>>  [<ffffffff811874e5>] SYSC_newstat+0x15/0x30
>>>  [<ffffffff8118763e>] SyS_newstat+0xe/0x10
>>>  [<ffffffff81572d99>] system_call_fastpath+0x16/0x1b
>>> --
>>
>> is the kernel based on master branch of ceph-client?
>>
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
