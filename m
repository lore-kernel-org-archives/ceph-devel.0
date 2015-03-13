From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Bounding OSD memory requirements during peering/recovery
Date: Fri, 13 Mar 2015 12:24:48 +0100
Message-ID: <CABZ+qqkr1ioQBtfqwAnBoFv+Ew=hE-_rCcZVvRoahuZ6659-VA@mail.gmail.com>
References: <54D78939.4000708@cam.ac.uk> <CAC6JEv8NYw2qk9O7pcSmrVwd2p=7mfLDrA+1tBmFxf2-_f-tZw@mail.gmail.com>
 <54D92850.5080409@cam.ac.uk> <alpine.DEB.2.00.1502091746100.3035@cobra.newdream.net>
 <CABZ+qqnaRfuSbttG4vFQLPoBiptV2m7KFTBxg505369VoiEGMQ@mail.gmail.com> <CAC6JEv-wLAnjRxJBYRrKG9Wqbd1pNKdKs4zSAK_Vojfy+kjVtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33340 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbbCMLZb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Mar 2015 07:25:31 -0400
Received: by lbdu14 with SMTP id u14so22136111lbd.0
        for <ceph-devel@vger.kernel.org>; Fri, 13 Mar 2015 04:25:30 -0700 (PDT)
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com. [209.85.215.49])
        by mx.google.com with ESMTPSA id kx8sm343802lbc.3.2015.03.13.04.25.29
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2015 04:25:29 -0700 (PDT)
Received: by lams18 with SMTP id s18so21875784lam.9
        for <ceph-devel@vger.kernel.org>; Fri, 13 Mar 2015 04:25:28 -0700 (PDT)
In-Reply-To: <CAC6JEv-wLAnjRxJBYRrKG9Wqbd1pNKdKs4zSAK_Vojfy+kjVtA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Sage Weil <sage@newdream.net>, David McBride <dwm37@cam.ac.uk>, Ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Mar 9, 2015 at 4:47 PM, Gregory Farnum <greg@gregs42.com> wrote:
> On Mon, Mar 9, 2015 at 8:42 AM, Dan van der Ster <dan@vanderster.com> wrote:
>> Hi Sage,
>>
>> On Tue, Feb 10, 2015 at 2:51 AM, Sage Weil <sage@newdream.net> wrote:
>>> On Mon, 9 Feb 2015, David McBride wrote:
>>>> On 09/02/15 15:31, Gregory Farnum wrote:
>>>>
>>>> > So, memory usage of an OSD is usually linear in the number of PGs it
>>>> > hosts. However, that memory can also grow based on at least one other
>>>> > thing: the number of OSD Maps required to go through peering. It
>>>> > *looks* to me like this is what you're running in to, not growth on
>>>> > the number of state machines. In particular, those past_intervals you
>>>> > mentioned. ;)
>>>>
>>>> Hi Greg,
>>>>
>>>> Right, that sounds entirely plausible, and is very helpful.
>>>>
>>>> In practice, that means I'll need to be careful to avoid this situation
>>>> occurring in production ? but given that's unlikely to occur except in the
>>>> case of non-trivial neglect, I don't think I need be particularly concerned.
>>>>
>>>> (Happily, I'm in the situation that my existing cluster is purely for testing
>>>> purposes; the data is expendable.)
>>>>
>>>> That said, for my own peace of mind, it would be valuable to have a procedure
>>>> that can be used to recover from this state, even if it's unlikely to occur in
>>>> practice.
>>>
>>> The best luck I've had recovering from situations is something like:
>>>
>>> - stop all osds
>>> - osd set nodown
>>> - osd set nobackfill
>>> - osd set noup
>>> - set map cache size smaller to reduce memory footprint.
>>>
>>>   osd map cache size = 50
>>>   osd map max advance = 25
>>>   osd map share max epochs = 25
>>>   osd pg epoch persisted max stale = 25
>
> It can cause extreme slowness if you get into a failure situation and
> your OSDs need to calculate past intervals across more maps than will
> fit in the cache. :(

.. extreme slowness or is it also possible to get into a situation
where the PGs are stuck incomplete forever?

The reason I ask is because we actually had a network issue this
morning that left OSDs flapping and a lot of osdmap epoch churn. Now
our network has stabilized but 10 PGs are incomplete, even though all
the OSDs are up. One PG looks like this, for example:

pg 75.45 is stuck inactive for 87351.077529, current state incomplete,
last acting [6689,1919,2329]
pg 75.45 is stuck unclean for 87351.096198, current state incomplete,
last acting [6689,1919,2329]
pg 75.45 is incomplete, acting [6689,1919,2329]

1919     3.62000                 osd.1919                      up
1.00000          1.00000
2329     3.62000                 osd.2329                      up
1.00000          1.00000
6689     3.62000                 osd.6689                      up
1.00000          1.00000

The pg query output here: http://pastebin.com/WyTAU69W

Is that a result of these short map caches or could it be something
else?  (we're running 0.93-76-gc35f422)
WWGD (what would Greg do?) to activate these PGs?

Thanks! Dan
