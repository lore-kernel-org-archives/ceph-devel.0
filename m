From: Leander Yu <leander.yu@gmail.com>
Subject: Re: mds getattr locked again
Date: Sat, 30 Oct 2010 10:17:09 +0800
Message-ID: <AANLkTikWq7_-vwU1BTJV46Ef1_ZJ06qYLkUmzUKfPLR_@mail.gmail.com>
References: <AANLkTi=R=bnsjZeq5DibVzVK__evwajLefSHuA6iJKTW@mail.gmail.com>
	<Pine.LNX.4.64.1010282151220.27485@cobra.newdream.net>
	<AANLkTinOOi4XjfnfxP8qL81sxzOTLaS4zPJYwY979J0L@mail.gmail.com>
	<Pine.LNX.4.64.1010290920220.13796@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65078 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab0J3CRL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Oct 2010 22:17:11 -0400
Received: by fxm16 with SMTP id 16so3649945fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Oct 2010 19:17:10 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1010290920220.13796@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Henry C Chang <henry_c_chang@tcloudcomputing.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Oct 30, 2010, at 12:26 AM, Sage Weil <sage@newdream.net> wrote:

> On Fri, 29 Oct 2010, Leander Yu wrote:
>> Hi Sage,
>>
>> On Fri, Oct 29, 2010 at 1:08 PM, Sage Weil <sage@newdream.net> wrote:
>>> On Fri, 29 Oct 2010, Henry C Chang wrote:
>>>> Hi,
>>>>
>>>> getattr on mds hanged again.
>>>>
>>>> I have already reverted d91f2438d881514e4a923fd786dbd94b764a9440.
>>>> Although the probability is significant lowered down, it still has the
>>>> chance to hang on getattr.
>>>>
>>>> Attached are the logs of mds and the hanging client. :(
>>>>
>>>> I'm using ceph-client-standalone master-backport branch on 2.6.32 kernel.
>>>
>>> It looks like ceph_check_caps is hung somehow:
>>>
>>> ceph:ceph:  handle_caps from mds0
>>> ceph:ceph:   mds0 seq 99 cap seq 28
>>> ceph:ceph:   op revoke ino 10000000bd1.fffffffffffffffe inode
>>> ffff8800a6251d88
>>> ceph:ceph:  handle_cap_grant inode ffff8800a6251d88 cap ffff8800a635b780
>>> mds0 seq 28 pAsLsXsFr
>>> ceph:ceph:   size 4294967296 max_size 8594128896, i_size 4294967296
>>> ceph:ceph:  try_nonblocking_invalidate ffff8800a6251d88 success
>>> ceph:ceph:  __ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780
>>> issued pAsLsXsFscr
>>> ceph:ceph:  __ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780
>>> issued pAsLsXsFscr
>>> ceph:ceph:  ffff8800a6251d88 mode 0100644 uid.gid 0.0
>>> ceph:ceph:   my wanted = pAsxXsxFsxcrwb, used = pFcr, dirty -
>>> ceph:ceph:  revocation: pAsLsXsFscr -> pAsLsXsFr (revoking Fsc)
>>> ceph:ceph:  __ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780
>>> issued pAsLsXsFr
>>> ceph:ceph:  check_caps ffff8800a6251d88 file_want pAsxXsxFsxcrwb used pFcr
>>> dirty - flushing - issued pAsLsXsFr revoking Fsc retain pAsxLsxXsxFsxcrwbl
>>> AUTHONLY NODELAY
>>> ceph:ceph:   mds0 revoking Fsc
>>> ceph:ceph:  mdsc put_session ffff8800b41c6000 3 -> 2
>>> ceph:ceph:  mdsc con_put ffff8800b41c6000 (2)
>>> ceph:ceph:  aio_read ffff8800a6251d88 10000000bd1.fffffffffffffffe
>>> dropping cap refs on Fcr = 512
>>> ceph:ceph:  put_cap_refs ffff8800a6251d88 had Fcr last
>>> ceph:ceph:  __ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780
>>> issued pAsLsXsFr
>>> ceph:ceph:  check_caps ffff8800a6251d88 file_want pAsxXsxFsxcrwb used pFc
>>> dirty - flushing - issued pAsLsXsFr revoking Fsc retain pAsxLsxXsxFsxcrwbl
>>> ceph:ceph:  check_caps trying to invalidate on ffff8800a6251d88
>>> ceph:ceph:  try_nonblocking_invalidate ffff8800a6251d88 failed
>>> ceph:ceph:  check_caps queuing invalidate
>>>
>>> --> this means queue_invalidate = 1, and check_caps will call
>>> ceph_queue_invalidate on exit, which will always print something...
>>>
>>> ceph:ceph:  __ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780 issued pAsLsXsFr
>>> ceph:ceph:  check_caps ffff8800a6251d88 file_want pAsxXsxFsxcrwb used pFc
>>> dirty - flushing - issued pAsLsXsFr revoking Fsc retain pAsxLsxXsxFsxcrwbl
>>> ceph:ceph:   mds0 revoking Fsc
>>> ceph:ceph:  __cap_delay_cancel ffff8800a6251d88
>>>
>>> ...but that never happens.  Probably the CPU got blocked somewhere?  Can
>>> you see what the system is doing at this point?  sysrq-t, or check the
>>> process list for ceph-msgr and cat it's stack (/proc/$pid/stack)?  The
>>> task should be blocked in ceph_check_caps() somewhere...
>>
>> it didn't go to ceph_queue_invalidate because delayed and is_delayed = 0.
>>
>>         if (delayed && is_delayed)
>>                 force_requeue = 1;   /* __send_cap delayed release; requeue */
>>         if (!delayed && !is_delayed)
>>                 __cap_delay_cancel(mdsc, ci);
>>         else if (!is_delayed || force_requeue)
>>                 __cap_delay_requeue(mdsc, ci);
>>
>>         spin_unlock(&inode->i_lock);
>>
>>         if (queue_invalidate)
>>                 ceph_queue_invalidate(inode);
>>
>> so it goes to __cap_delay_cancel().
>>
>> Should I said, the correct behavior is to go to ceph_queue_invalidate(inode)?
>
> I don't think delayed && is_delayed are related.  (Those deal with whether
> we come back and re-check caps a little latter.)  The invalidate should be
> queued immediately: at this point queue_invalidate == 1, and the function
> only has one exit point, so one way or another ceph_queue_invalidate()
> should get called.  Since it's not, we must be getting stuck somewhere...
>
> Some combination of sysrq and strategic printk's should narrow down where
> things go wrong.
>
> Thanks!
> sage

From the kernel debug log we found it went to __cap_delay_cancel()
then didn't go to ceph_queue_invalidate(inode).  add one more checking
condition as following workaround it

 if (!delayed && !is_delayed && !queue_invalidate)
                 __cap_delay_cancel(mdsc, ci);

But you are right, no matter what, it should goes to
ceph_queue_invalidate() after return from __cap_delay_cancel().
We will add some more printk to see where it got stuck. The most
suspicious part is spin_lock(&mdsc->cap_delay_lock) inside
__cap_delay_cancel()

>
>
>>
>>
>>>
>>> (BTW, if you're building your own kernel, one thing that I've found
>>> helpful is enabling the CONFIG_PRINTK_TIME option in .config, and updating
>>> kernel/printk.c to also include current->pid in the line prefix.  That
>>> helps sort out what tasks are doing what when.  But if you're stuck on
>>> 2.6.32 for some reason that probably not the case!)
>>>
>>> Thanks!
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
