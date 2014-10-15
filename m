From: Samuel Just <sam.just@inktank.com>
Subject: Re: snap_trimming + backfilling is inefficient with many purged_snaps
Date: Wed, 15 Oct 2014 10:50:45 -0700
Message-ID: <CA+4uBUbxVjvbcUBC1aqW4WxWK9dNGbU6BD+iaPX0qUkETHgQSw@mail.gmail.com>
References: <alpine.DEB.2.00.1409190819070.18018@cobra.newdream.net>
	<CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>
	<D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch>
	<CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com>
	<541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAPUexz_H7-b8SY6J+dLnAyw663eHXoLKYccB1edwH9XgFBZCpw@mail.gmail.com>
	<07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com>
	<CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com>
	<alpine.DEB.2.00.1409181446110.19460@cobra.newdream.net>
	<CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com>
	<alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net>
	<CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com>
	<1878E4A4-2363-4717-ABEC-B587B0337D6B@cern.ch>
	<CABZ+qqks_qSbgG4QhkaH8A1zTP=o+fR4ptHPbtA9-MxrM8sJ5w@mail.gmail.com>
	<63ccef299522995cc0704e349ef86503@webmail.vanderster.com>
	<6A154A11-04F9-4D21-BF81-C585B6E6BD41@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:48618 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaJORur (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Oct 2014 13:50:47 -0400
Received: by mail-lb0-f178.google.com with SMTP id w7so1505333lbi.9
        for <ceph-devel@vger.kernel.org>; Wed, 15 Oct 2014 10:50:45 -0700 (PDT)
In-Reply-To: <6A154A11-04F9-4D21-BF81-C585B6E6BD41@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Van Der Ster <daniel.vanderster@cern.ch>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Florian Haas <florian@hastexo.com>

It's in giant, the firefly backport will happen once we are happy with
the fallout from the 80.7 thing.
-Sam

On Wed, Oct 15, 2014 at 7:47 AM, Dan Van Der Ster
<daniel.vanderster@cern.ch> wrote:
> Hi Sage,
>
>> On 19 Sep 2014, at 17:37, Dan Van Der Ster <daniel.vanderster@cern.ch> wrote:
>>
>> September 19 2014 5:19 PM, "Sage Weil" <sweil@redhat.com> wrote:
>>> On Fri, 19 Sep 2014, Dan van der Ster wrote:
>>>
>>>> On Fri, Sep 19, 2014 at 10:41 AM, Dan Van Der Ster
>>>> <daniel.vanderster@cern.ch> wrote:
>>>>>> On 19 Sep 2014, at 08:12, Florian Haas <florian@hastexo.com> wrote:
>>>>>>
>>>>>> On Fri, Sep 19, 2014 at 12:27 AM, Sage Weil <sweil@redhat.com> wrote:
>>>>>>> On Fri, 19 Sep 2014, Florian Haas wrote:
>>>>>>>> Hi Sage,
>>>>>>>>
>>>>>>>> was the off-list reply intentional?
>>>>>>>
>>>>>>> Whoops! Nope :)
>>>>>>>
>>>>>>>> On Thu, Sep 18, 2014 at 11:47 PM, Sage Weil <sweil@redhat.com> wrote:
>>>>>>>>>> So, disaster is a pretty good description. Would anyone from the core
>>>>>>>>>> team like to suggest another course of action or workaround, or are
>>>>>>>>>> Dan and I generally on the right track to make the best out of a
>>>>>>>>>> pretty bad situation?
>>>>>>>>>
>>>>>>>>> The short term fix would probably be to just prevent backfill for the time
>>>>>>>>> being until the bug is fixed.
>>>>>>>>
>>>>>>>> As in, osd max backfills = 0?
>>>>>>>
>>>>>>> Yeah :)
>>>>>>>
>>>>>>> Just managed to reproduce the problem...
>>>>>>>
>>>>>>> sage
>>>>>>
>>>>>> Saw the wip branch. Color me freakishly impressed on the turnaround. :) Thanks!
>>>>>
>>>>> Indeed :) Thanks Sage!
>>>>> wip-9487-dumpling fixes the problem on my test cluster. Trying in prod now?
>>>>
>>>> Final update, after 4 hours in prod and after draining 8 OSDs -- zero
>>>> slow requests :)
>>>
>>> That's great news!
>>>
>>> But, please be careful. This code hasn't been reiewed yet or been through
>>> any testing! I would hold off on further backfills until it's merged.
>
>
> Any news on those merges? It would be good to get this fixed on the dumpling and firefly branches. We're kind of stuck at the moment :(
>
> Cheers, Dan
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
