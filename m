From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: deadlocks in rbd unmap and map
Date: Fri, 8 Jul 2016 20:46:16 +0200
Message-ID: <CAOi1vP_HwML=7+iZrJFzJpbRcSomKBX5r8RT2hnRGF23agN1FQ@mail.gmail.com>
References: <CAE2NFgVL6_+6JmW7aFO+v3j37BFnxXEneaOHk0eOCx-Vj1pAOA@mail.gmail.com>
 <CAOi1vP8NhgYHpfZT8w=meFf6vwPrS-izRZnvSPwrRc+3vwvAWQ@mail.gmail.com> <CAE2NFgW0ntzuFkRup5QCGfYMBuHo4Er9+y+OtKDTeaXBBtgE3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36100 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955AbcGHSqT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jul 2016 14:46:19 -0400
Received: by mail-wm0-f52.google.com with SMTP id f126so21401150wma.1
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2016 11:46:19 -0700 (PDT)
In-Reply-To: <CAE2NFgW0ntzuFkRup5QCGfYMBuHo4Er9+y+OtKDTeaXBBtgE3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McLean <patrickm@gaikai.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jul 8, 2016 at 7:51 PM, Patrick McLean <patrickm@gaikai.com> wrote:
> On Fri, Jul 8, 2016 at 4:40 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>> On Fri, Jul 8, 2016 at 3:28 AM, Patrick McLean <patrickm@gaikai.com> wrote:
>>> This is on linus git master as of 2016/07/01
>>>
>>> These appear to be two separate deadlocks, one on a a map operation,
>>> and one on an unmap operation. We can reproduce these pretty
>>> regularly, but it seems like there is some sort of race condition, as
>>> it happens no where near every time.
>>>
>
>>
>> It's a single deadlock between "rbd map" and a kworker thread, a later
>> "rbd unmap" is just a victim.
>>
>> Are you mapping the same image more than once?
>>
>
> We shouldn't be, there is a higher-level locking system that is
> supposed to prevent that.

It's actually allowed, I'm just trying to get an idea of what was going
on.

I spoke too soon.  The trace of pid 14109 is inconsistent - the entries
in the middle don't make sense.  Do you have a different set of traces
or are they all the same?

Were there other images mapped at the time 14109 was exec'ed?  Other
concurrent "rbd map" processes?

What was/is the state of the cluster?  Can you provide the output of
ceph -s?  Any stuck PGs?

Thanks,

                Ilya
