From: Wido den Hollander <wido@42on.com>
Subject: Re: OSD memory leaks?
Date: Mon, 25 Feb 2013 08:51:20 +0100
Message-ID: <512B17F8.2090604@42on.com>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com> <8366806.170.1357747859058.JavaMail.dspano@it1> <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com> <CAF6-1L4WOGHNU=qLOuOWktsDirc-nO2ZM0+nQL9vxF2KKuWVqg@mail.gmail.com> <CAPYLRziCObXZaOcqA8CDfheJTYce1w3m5754+0Dz-ToYJYKuDg@mail.gmail.com> <CAOLwVUkA5G+RyzembvZnv2gA5h-E+kNR_me_Hgoisjk0dmSWSg@mail.gmail.com> <CAPYLRzjx24oOEpjcvKa2ELJYb6QAxTegVatysMAobbP-h1v8Xg@mail.gmail.com> <CAOLwVUn0SetsDgE2vqioFn+53xDi7Uh9TivDX2JOH6Qu5pEEUA@mail.gmail.com> <alpine.DEB.2.00.1302221642570.5703@cobra.newdream.net> <CAOLwVU=iAvD4pd_SZdL5MAWvd3fOYno7=rdk+YA8Tc6EBFy_cA@mail.gmail.com> <alpine.DEB.2.00.1302241619380.26649@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:38058 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756611Ab3BYHvX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Feb 2013 02:51:23 -0500
In-Reply-To: <alpine.DEB.2.00.1302241619380.26649@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, Gregory Farnum <greg@inktank.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Dave Spano <dspano@optogenics.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

On 02/25/2013 01:21 AM, Sage Weil wrote:
> On Mon, 25 Feb 2013, S?bastien Han wrote:
>> Hi Sage,
>>
>> Sorry it's a production system, so I can't test it.
>> So at the end, you can't get anything out of the core dump?
>
> I saw a bunch of dup object anmes, which is what led us to the pg log
> theory.  I can look a bit more carefully to confirm, but in the end it
> would be nice to see users scrubbing without leaking.
>
> This may be a bit moot because we want to allow trimming for other
> reasons, so those patches are being tested and working their way into
> master.  We'll backport when things are solid.
>
> In the meantime, if someone has been able to reproduce this in a test
> environment, testing is obviously welcome :)
>

I'll see what I can do later this week. I know of a cluster which has 
the same issues which is in semi-production as far as I know.

Wido

> sage
>
>
>
>
>   >
>> --
>> Regards,
>> S?bastien Han.
>>
>>
>> On Sat, Feb 23, 2013 at 1:44 AM, Sage Weil <sage@inktank.com> wrote:
>>> On Fri, 22 Feb 2013, S?bastien Han wrote:
>>>> Hi all,
>>>>
>>>> I finally got a core dump.
>>>>
>>>> I did it with a kill -SEGV on the OSD process.
>>>>
>>>> https://www.dropbox.com/s/ahv6hm0ipnak5rf/core-ceph-osd-11-0-0-20100-1361539008
>>>>
>>>> Hope we will get something out of it :-).
>>>
>>> AHA!  We have a theory.  The pg log isnt trimmed during scrub (because teh
>>> old scrub code required that), but the new (deep) scrub can take a very
>>> long time, which means the pg log will eat ram in the meantime..
>>> especially under high iops.
>>>
>>> Can you try wip-osd-log-trim (which is bobtail + a simple patch) and see
>>> if that seems to work?  Note that that patch shouldn't be run in a mixed
>>> argonaut+bobtail cluster, since it isn't properly checking if the scrub is
>>> class or chunky/deep.
>>>
>>> Thanks!
>>> sage
>>>
>>>
>>>   > --
>>>> Regards,
>>>> S?bastien Han.
>>>>
>>>>
>>>> On Fri, Jan 11, 2013 at 7:13 PM, Gregory Farnum <greg@inktank.com> wrote:
>>>>> On Fri, Jan 11, 2013 at 6:57 AM, S?bastien Han <han.sebastien@gmail.com> wrote:
>>>>>>> Is osd.1 using the heap profiler as well? Keep in mind that active use
>>>>>>> of the memory profiler will itself cause memory usage to increase ?
>>>>>>> this sounds a bit like that to me since it's staying stable at a large
>>>>>>> but finite portion of total memory.
>>>>>>
>>>>>> Well, the memory consumption was already high before the profiler was
>>>>>> started. So yes with the memory profiler enable an OSD might consume
>>>>>> more memory but this doesn't cause the memory leaks.
>>>>>
>>>>> My concern is that maybe you saw a leak but when you restarted with
>>>>> the memory profiling you lost whatever conditions caused it.
>>>>>
>>>>>> Any ideas? Nothing to say about my scrumbing theory?
>>>>> I like it, but Sam indicates that without some heap dumps which
>>>>> capture the actual leak then scrub is too large to effectively code
>>>>> review for leaks. :(
>>>>> -Greg
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
