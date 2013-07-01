From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Contribution
Date: Mon, 1 Jul 2013 13:23:31 -0700
Message-ID: <CABBk=J812X6RKR0cBo1mPF2Xm4agHHJrRMjgqpOEn9uosBt6-Q@mail.gmail.com>
References: <CAA8043idUL1qbWfrBffhYXL8JX0LZ+WsMseUypatret7PrxBGw@mail.gmail.com>
	<CABBk=J9-hrMgGJ6ofvR0uuzX_gTfKJhH_TFCS4fR6m6gD=UBmg@mail.gmail.com>
	<CAA8043g_vkZvx_ErHZbF8eq12T2bvvXGWA_u=NRdwEWnmaqaug@mail.gmail.com>
	<CAA8043iF3GFwQLonGvCY=A=_mKWYX1zAXEYFFMJ1cyuw1ZOspw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:45600 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab3GAUXc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jul 2013 16:23:32 -0400
Received: by mail-ve0-f172.google.com with SMTP id jz10so4251559veb.3
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jul 2013 13:23:31 -0700 (PDT)
In-Reply-To: <CAA8043iF3GFwQLonGvCY=A=_mKWYX1zAXEYFFMJ1cyuw1ZOspw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: christophe courtaut <christophe.courtaut@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On Mon, Jul 1, 2013 at 12:52 PM, christophe courtaut
<christophe.courtaut@gmail.com> wrote:
> Hi,
>
> I updated my pull request and looking forward #5416, and asked for
> more information on the tracker.
>
> Nowadays, i'm iterating on the tracker to find issues i can fix.
> I currently proposed fixes for #1779, #5228 and #5324.

I pulled your fix for 1779. I commented on 5228 (a similar fix for
that issue already went in, but your fix does some other things). I
will pull 5324 (already commented on that at github).

>
> I'm not very familiar with tests, and it might be a little too big for
> me to start with.
> Btw, I was also in contact with Joe Buck to properly setup a fake cluster
> suitable to make tests, as i was having trouble in doing that.
>
> To get started, i'm looking for things a bit smaller, that could fit in a day.
>
> I would be glad if you could point me to some specific tasks,
> even if they are not specially related to the geo-replication blueprint,
> the best for me remaining rgw related tasks as it's what i am trying to learn.


Here are a few (ordered by complexity):

 - 3074 (trivial)
 - swift temp URLs (there's already a similar mechanism for S3)
 - 5374
 - 4365

Thanks!
Yehuda

>
> Best regards.
>
> On Thu, Jun 27, 2013 at 5:25 PM, christophe courtaut
> <christophe.courtaut@gmail.com> wrote:
>> ---------- Forwarded message ----------
>> From: Yehuda Sadeh <yehuda@inktank.com>
>> Date: Thu, Jun 27, 2013 at 5:21 PM
>> Subject: Re: Contribution
>> To: christophe courtaut <christophe.courtaut@gmail.com>
>>
>>
>> On Thu, Jun 27, 2013 at 7:30 AM, christophe courtaut
>> <christophe.courtaut@gmail.com> wrote:
>>> Hi Yehuda,
>>>
>>> I went thru http://tracker.ceph.com/projects/rgw/issues today ( all 22
>>> of them ;-) and contributed a patch to
>>> http://tracker.ceph.com/issues/5324 ( that was an easy one ). I'd be
>>> happy to either fix more bugs on the current development branch or
>>> contribute to the geo-replication
>>> https://github.com/ceph/ceph/commits/wip-rgw-geo-2
>>>
>>> The amount of work going on with wip-rgw-geo is impressive and I'm not
>>> sure what I could do to help. It would be most convenient for me to
>>> pick from a list of self contained tasks in the tracker. I would be
>>> happy to spend a few days on each of them, one at a time. Since I'm
>>> still new to the code base, working on a tasks that would require
>>> weeks of work is probably too ambitious at this point. However, I very
>>> much understand that the definition of such tasks requires a fair
>>> amount of work on your part. And if noone works on these tasks, this
>>> would be a waste of your time. If that helps, I promise to diligently
>>> work on them, full time :-)
>>>
>>
>> Hi,
>>
>>    I saw your pull request, and also commented on the commit. There's
>> a similar easy issue (#5416) that you can take a look at now if you'd
>> like.
>> I think that at the moment with regard to the geo-replication, the
>> most helpful thing would be to test the different APIs, make sure they
>> work as expected as we're on a tight schedule, and planning a feature
>> freeze by the end of next week.
>> The API specifications are in the wiki
>> (http://wiki.ceph.com/RESTful_API_for_DR_%2F%2F_Geo-Replication).
>> Specifically I'm interested in data sync, as it's the path less
>> tested. If you could simulate (even manually) a scenario, where you
>> put an object in a bucket, check to see whether bucket is listed in
>> the data log, then go to the bucket index log, see the change entry in
>> the bucket index log, then generate a copy of that object from the
>> master zone to the secondary zone. Look at the operation state log to
>> see whether this operation is marked as completed.
>> Check to see whether the object appears in the secondary zone, check
>> its attributes.
>> That tests a wide range of the new APIs, and it'll be really helpful.
>> If you could somewhat automate it and create a script that does it,
>> it'll be extra helpful.
>>
>> Most of the other DR/geo-replication tasks are either done (waiting
>> for review and merge) or being implemented now. There are other
>> non-geo-replication issues that I can assign to you if you want to get
>> your feet dipped in the rgw code. Even if these are not a direct
>> geo-replication issues it may help us getting geo-replication out the
>> door faster as it'll free me to work on geo-replication. Let me know
>> if you're interested.
>>
>> Thanks!
>> Yehuda
>>
>>
>> --
>> Christophe Courtaut
>
>
>
> --
> Christophe Courtaut
