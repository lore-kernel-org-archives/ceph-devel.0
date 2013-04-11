From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Latest bobtail branch still crashing KVM VMs in bh_write_commit()
Date: Wed, 10 Apr 2013 17:53:12 -0700
Message-ID: <51660978.4030003@inktank.com>
References: <CACkq2mrSvLyy9j3HMAEiCHnuktnB_EQbnQ-JvAZcyLcjmjn3uQ@mail.gmail.com> <514A13A8.7010002@profihost.ag> <CACkq2mppEb=N=dKGNWLx-pm2nZGp44D-SEYBoVhxMNDxUjE5sw@mail.gmail.com> <514A189E.7070802@profihost.ag> <514A19D7.1040309@inktank.com> <514A1CF9.5040807@inktank.com> <CACkq2mpTrjDy+RedjW2Qod8Yue0uNsM5y8ncHnmA+0nH7dsXLQ@mail.gmail.com> <CACkq2mo8Qbmr079ZG9PMM-2+qVD8Liq26+S1CZU1A+tTzNe_Fg@mail.gmail.com> <514C90C4.3050703@inktank.com> <CACkq2mrnz+QrJQ5QpsJWqQ=iCS-jtFiPG78nUJrK8nojLpMdkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:50395 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935274Ab3DKAxl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Apr 2013 20:53:41 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so552280pdi.36
        for <ceph-devel@vger.kernel.org>; Wed, 10 Apr 2013 17:53:41 -0700 (PDT)
In-Reply-To: <CACkq2mrnz+QrJQ5QpsJWqQ=iCS-jtFiPG78nUJrK8nojLpMdkg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, bcampbell@axcess-financial.com, ceph-devel <ceph-devel@vger.kernel.org>

Finally got some time to fix this (hopefully).
Could you try librbd from the wip-objectcacher-handler-ordered branch?
Just librbd on the host running qemu needs to be updated.

Thanks,
Josh

On 03/22/2013 11:30 AM, Travis Rhoden wrote:
> That's awesome Josh.  Thanks for looking into it.  Good luck with the fix!
>
>   - Travis
>
> On Fri, Mar 22, 2013 at 1:11 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
>> I think I found the root cause based on your logs:
>>
>> http://tracker.ceph.com/issues/4531
>>
>> Josh
>>
>>
>> On 03/20/2013 02:47 PM, Travis Rhoden wrote:
>>>
>>> Didn't take long to re-create with the detailed debugging (ms =  20).
>>> I'm sending Josh a link to the gzip'd log off-list, I"m not sure if
>>> the log will contain any CephX keys or anything like that.
>>>
>>> On Wed, Mar 20, 2013 at 4:39 PM, Travis Rhoden <trhoden@gmail.com> wrote:
>>>>
>>>> Thanks Josh.  I will respond when I have something useful!
>>>>
>>>> On Wed, Mar 20, 2013 at 4:32 PM, Josh Durgin <josh.durgin@inktank.com>
>>>> wrote:
>>>>>
>>>>> On 03/20/2013 01:19 PM, Josh Durgin wrote:
>>>>>>
>>>>>>
>>>>>> On 03/20/2013 01:14 PM, Stefan Priebe wrote:
>>>>>>>
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>>> In this case, they are format 2. And they are from cloned snapshots.
>>>>>>>> Exactly like the following:
>>>>>>>>
>>>>>>>> # rbd ls -l -p volumes
>>>>>>>> NAME                                                         SIZE
>>>>>>>> PARENT                                           FMT PROT LOCK
>>>>>>>> volume-099a6d74-05bd-4f00-a12e-009d60629aa8                 5120M
>>>>>>>> images/b8bdda90-664b-4906-86d6-dd33735441f2@snap   2
>>>>>>>>
>>>>>>>> I'm doing an OpenStack boot-from-volume setup.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> OK i've never used cloned snapshots so maybe this is the reason.
>>>>>>>
>>>>>>>>> strange i've never seen this. Which qemu version?
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> # qemu-x86_64 -version
>>>>>>>> qemu-x86_64 version 1.0 (qemu-kvm-1.0), Copyright (c) 2003-2008
>>>>>>>> Fabrice Bellard
>>>>>>>>
>>>>>>>> that's coming from Ubuntu 12.04 apt repos.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> maybe you should try qemu 1.4 there are a LOT of bugfixes. qemu-kvm
>>>>>>> does
>>>>>>> not exist anymore it was merged into qemu with 1.3 or 1.4.
>>>>>>
>>>>>>
>>>>>>
>>>>>> This particular problem won't be solved by upgrading qemu. It's a ceph
>>>>>> bug. Disabling caching would work around the issue.
>>>>>>
>>>>>> Travis, could you get a log from qemu of this happening with:
>>>>>>
>>>>>> debug ms = 20
>>>>>> debug objectcacher = 20
>>>>>> debug rbd = 20
>>>>>> log file = /path/writeable/by/qemu
>>>>>
>>>>>
>>>>>
>>>>> If it doesn't reproduce with those settings, try changing debug ms to 1
>>>>> instead of 20.
>>>>>
>>>>>
>>>>>>    From those we can tell whether the issue is on the client side at
>>>>>> least,
>>>>>> and hopefully what's causing it.
>>>>>>
>>>>>> Thanks!
>>>>>> Josh
>>>>>
>>>>>
>>>>>

