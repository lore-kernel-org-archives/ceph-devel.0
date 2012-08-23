From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: How to increase the number of pgs at pool creation time?
Date: Thu, 23 Aug 2012 15:48:23 -0600
Message-ID: <5036A527.5020001@sandia.gov>
References: <CANLRBoxdu7iPvBU45T5Nk0zDYT1QSX9-oyo4g1nEav-+ybGA4g@mail.gmail.com>
 <50369DDB.8020905@sandia.gov>
 <CANLRBozjtrpsKJ-cE=RxP0ihdkO4cYjV9bx=c+rb+F8HzZ=zmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:60450 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759267Ab2HWVsm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Aug 2012 17:48:42 -0400
In-Reply-To: <CANLRBozjtrpsKJ-cE=RxP0ihdkO4cYjV9bx=c+rb+F8HzZ=zmw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: ceph-devel@vger.kernel.org

On 08/23/2012 03:26 PM, Tren Blackburn wrote:
> On Thu, Aug 23, 2012 at 2:17 PM, Jim Schutt<jaschut@sandia.gov>  wrote:
>> On 08/23/2012 02:39 PM, Tren Blackburn wrote:
>>>
>>> 2) Increase the number of pgs via ceph.conf (osd pg bits = 7) and
>>> create the cluster. This does not work either as the cluster comes up
>>> with 6 pgs bits per osd still.
>>>       re:http://ceph.com/docs/master/config-cluster/osd-config-ref/
>>
>>
>> I use this regularly.  Do you have that in your global section, i.e.
>>
>> [global]
>>          osd pg bits = 7
>>          osd pgp bits = 7
>>
> Hi Jim;
>
> Sorry about the direct reply. I have cc'ed the list. To answer your
> question I put that setting in the [osd] section, not the [global]
> section. How would a person know these settings go in [global]?

I'm sorry to admit I haven't learned how to know this
either.  I recall trying it in the [osd] section and
not having it work, and thinking maybe the monitor
would need to know, and putting it in the [global]
section would give it access.  It worked, so I moved on.

> Also,
> I could not find documentation about "pgp bits" What is a "placement
> group p bit"?

Again, I'm not sure.  The default config has pg bits and
pgp bits set to the same value, so I think I assumed it
would be best to have them the same if I changed pg bits.

>
> Thank you in advance!

Sorry I don't know more....

-- Jim

>
> Regards,
>
> Tren
>
>


