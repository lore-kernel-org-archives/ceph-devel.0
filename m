From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: Latest bobtail branch still crashing KVM VMs in bh_write_commit()
Date: Thu, 11 Apr 2013 11:41:48 -0400
Message-ID: <CACkq2mrUTQTLczXdT7FdLyt_4_7y0GhQG2op_vn9Rs5Y4ZejRA@mail.gmail.com>
References: <CACkq2mrSvLyy9j3HMAEiCHnuktnB_EQbnQ-JvAZcyLcjmjn3uQ@mail.gmail.com>
 <514A13A8.7010002@profihost.ag> <CACkq2mppEb=N=dKGNWLx-pm2nZGp44D-SEYBoVhxMNDxUjE5sw@mail.gmail.com>
 <514A189E.7070802@profihost.ag> <514A19D7.1040309@inktank.com>
 <514A1CF9.5040807@inktank.com> <CACkq2mpTrjDy+RedjW2Qod8Yue0uNsM5y8ncHnmA+0nH7dsXLQ@mail.gmail.com>
 <CACkq2mo8Qbmr079ZG9PMM-2+qVD8Liq26+S1CZU1A+tTzNe_Fg@mail.gmail.com>
 <514C90C4.3050703@inktank.com> <CACkq2mrnz+QrJQ5QpsJWqQ=iCS-jtFiPG78nUJrK8nojLpMdkg@mail.gmail.com>
 <51660978.4030003@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55279 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840Ab3DKPmL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 11:42:11 -0400
Received: by mail-bk0-f46.google.com with SMTP id je9so898921bkc.5
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 08:42:09 -0700 (PDT)
In-Reply-To: <51660978.4030003@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, bcampbell@axcess-financial.com, ceph-devel <ceph-devel@vger.kernel.org>

Hi Josh,

Thanks for the heads up.  I've been testing the fix all morning, and
haven't run into a single crash yet!  I turned on the RBD logging
during a couple of VM startups just to look and make sure I saw a
bunch of objectcacher traffic (to know I was really doing caching).

I'll keep the new version installed for now and see how things play
out through the day.  So far things are looking very promising.

A couple of obligatory questions:

Any idea when the fixes will be backported to bobtail?

I"m running the latest bobtail packages everywhere else.  I now have
0.60+ for librbd, librados, and ceph-common on my host running qemu
(all that host does is run virtual machiens with librbd).  Do you know
of anything that would make this mixed environment a cause for
concern?  Once the backport is done, I will revert these packages to
the bobtail version.

Thanks so much for the good work.

 - Travis

On Wed, Apr 10, 2013 at 8:53 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> Finally got some time to fix this (hopefully).
> Could you try librbd from the wip-objectcacher-handler-ordered branch?
> Just librbd on the host running qemu needs to be updated.
>
> Thanks,
> Josh
>
>
> On 03/22/2013 11:30 AM, Travis Rhoden wrote:
>>
>> That's awesome Josh.  Thanks for looking into it.  Good luck with the fix!
>>
>>   - Travis
>>
>> On Fri, Mar 22, 2013 at 1:11 PM, Josh Durgin <josh.durgin@inktank.com>
>> wrote:
>>>
>>> I think I found the root cause based on your logs:
>>>
>>> http://tracker.ceph.com/issues/4531
>>>
>>> Josh
>>>
>>>
>>> On 03/20/2013 02:47 PM, Travis Rhoden wrote:
>>>>
>>>>
>>>> Didn't take long to re-create with the detailed debugging (ms =  20).
>>>> I'm sending Josh a link to the gzip'd log off-list, I"m not sure if
>>>> the log will contain any CephX keys or anything like that.
>>>>
>>>> On Wed, Mar 20, 2013 at 4:39 PM, Travis Rhoden <trhoden@gmail.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> Thanks Josh.  I will respond when I have something useful!
>>>>>
>>>>> On Wed, Mar 20, 2013 at 4:32 PM, Josh Durgin <josh.durgin@inktank.com>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> On 03/20/2013 01:19 PM, Josh Durgin wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 03/20/2013 01:14 PM, Stefan Priebe wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>>> In this case, they are format 2. And they are from cloned
>>>>>>>>> snapshots.
>>>>>>>>> Exactly like the following:
>>>>>>>>>
>>>>>>>>> # rbd ls -l -p volumes
>>>>>>>>> NAME                                                         SIZE
>>>>>>>>> PARENT                                           FMT PROT LOCK
>>>>>>>>> volume-099a6d74-05bd-4f00-a12e-009d60629aa8                 5120M
>>>>>>>>> images/b8bdda90-664b-4906-86d6-dd33735441f2@snap   2
>>>>>>>>>
>>>>>>>>> I'm doing an OpenStack boot-from-volume setup.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> OK i've never used cloned snapshots so maybe this is the reason.
>>>>>>>>
>>>>>>>>>> strange i've never seen this. Which qemu version?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> # qemu-x86_64 -version
>>>>>>>>> qemu-x86_64 version 1.0 (qemu-kvm-1.0), Copyright (c) 2003-2008
>>>>>>>>> Fabrice Bellard
>>>>>>>>>
>>>>>>>>> that's coming from Ubuntu 12.04 apt repos.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> maybe you should try qemu 1.4 there are a LOT of bugfixes. qemu-kvm
>>>>>>>> does
>>>>>>>> not exist anymore it was merged into qemu with 1.3 or 1.4.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> This particular problem won't be solved by upgrading qemu. It's a
>>>>>>> ceph
>>>>>>> bug. Disabling caching would work around the issue.
>>>>>>>
>>>>>>> Travis, could you get a log from qemu of this happening with:
>>>>>>>
>>>>>>> debug ms = 20
>>>>>>> debug objectcacher = 20
>>>>>>> debug rbd = 20
>>>>>>> log file = /path/writeable/by/qemu
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> If it doesn't reproduce with those settings, try changing debug ms to
>>>>>> 1
>>>>>> instead of 20.
>>>>>>
>>>>>>
>>>>>>>    From those we can tell whether the issue is on the client side at
>>>>>>> least,
>>>>>>> and hopefully what's causing it.
>>>>>>>
>>>>>>> Thanks!
>>>>>>> Josh
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>
