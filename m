From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Bounding OSD memory requirements during peering/recovery
Date: Fri, 13 Mar 2015 22:24:06 +0100
Message-ID: <CABZ+qq=DS+QgWe4Fq5dFN-2pBSSgxphzhUAoHN30U5xTcuRKsw@mail.gmail.com>
References: <54D78939.4000708@cam.ac.uk> <CAC6JEv8NYw2qk9O7pcSmrVwd2p=7mfLDrA+1tBmFxf2-_f-tZw@mail.gmail.com>
 <54D92850.5080409@cam.ac.uk> <alpine.DEB.2.00.1502091746100.3035@cobra.newdream.net>
 <CABZ+qqnaRfuSbttG4vFQLPoBiptV2m7KFTBxg505369VoiEGMQ@mail.gmail.com>
 <CAC6JEv-wLAnjRxJBYRrKG9Wqbd1pNKdKs4zSAK_Vojfy+kjVtA@mail.gmail.com>
 <CABZ+qqkr1ioQBtfqwAnBoFv+Ew=hE-_rCcZVvRoahuZ6659-VA@mail.gmail.com>
 <f943965c-b279-4e5f-ac47-1dc6443e594d@email.android.com> <CABZ+qqmf3=R9_A32388aS4YKNDN_wJvyXhsR6gNpTDTfUXx_hw@mail.gmail.com>
 <CABZ+qqkX_uezJ5CnMWV1W0OYivg6DV5WAsXxoRk7E=5VkviEaQ@mail.gmail.com>
 <55034B9C.8040000@redhat.com> <55034E36.9070402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:44183 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbCMVYu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Mar 2015 17:24:50 -0400
Received: by labgm9 with SMTP id gm9so25285616lab.11
        for <ceph-devel@vger.kernel.org>; Fri, 13 Mar 2015 14:24:48 -0700 (PDT)
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com. [209.85.217.178])
        by mx.google.com with ESMTPSA id ju14sm627195lab.8.2015.03.13.14.24.47
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2015 14:24:47 -0700 (PDT)
Received: by lbdu10 with SMTP id u10so25431379lbd.4
        for <ceph-devel@vger.kernel.org>; Fri, 13 Mar 2015 14:24:47 -0700 (PDT)
In-Reply-To: <55034E36.9070402@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <greg@gregs42.com>, David McBride <dwm37@cam.ac.uk>, Ceph-devel <ceph-devel@vger.kernel.org>

Yup, all running 0.93-76-gc35f422 (from gitbuilder just after Sage merged the
latest straw2 fix...). I just uploaded the ceph.log to help understand
the issue. Let me know if I can help further :)
Thanks! Dan

On Fri, Mar 13, 2015 at 9:53 PM, Samuel Just <sjust@redhat.com> wrote:
> Also, are you certain that all were running the same version?
> -Sam
>
>
> On 03/13/2015 01:42 PM, Samuel Just wrote:
>>
>> I've opened a bug for this  (http://tracker.ceph.com/issues/11110), I bet
>> it's related to the new logic for allowing recovery below min_size.  Exactly
>> what sha1 was running on the osds during this time period?
>> -Sam
>>
>> On 03/13/2015 08:36 AM, Dan van der Ster wrote:
>>>
>>> On Fri, Mar 13, 2015 at 1:52 PM, Dan van der Ster <dan@vanderster.com>
>>> wrote:
>>>>
>>>> Hi Sage,
>>>>
>>>> Losing a message would have been plausible given the network issue we
>>>> had today.
>>>>
>>>> I tried:
>>>>
>>>> # ceph osd pg-temp 75.45 6689
>>>> set 75.45 pg_temp mapping to [6689]
>>>>
>>>> then waited a bit. It's still incomplete -- the only difference is now
>>>> I see two more past_intervals in the pg. Full query here:
>>>> http://pastebin.com/TU7vVLpj
>>>>
>>>> I didn't have debug_osd above zero when I did that. Should I try again
>>>> with debug_osd 20?
>>>
>>> I tried again with logging. The pg goes like this:
>>>
>>> incomplete -> inactive -> remapped -> remapped+peering -> remapped ->
>>> inactive -> peering -> incomplete
>>>
>>> The killer seems to be:
>>>
>>> 2015-03-13 16:15:43.476925 7f3c2e055700 10 osd.6689 pg_epoch: 67050
>>> pg[75.45( v 66245'4028 (49044'1025,66245'4028] local-les=61515 n=3994
>>> ec=48759 les/c 66791/66791 67037/67050/67037) [6689,1919,2329]/[6689]
>>> r=0 lpr=67050 pi=66787-67049/13 crt=66226'4026 lcod 0'0 mlcod 0'0
>>> remapped+peering] choose_acting no suitable info found (incomplete
>>> backfills?), reverting to up
>>>
>>> Full log is here: http://pastebin.com/hZUBD9NT
>>>
>>> Do you have an idea what went wrong here? BTW, our firefly "prod"
>>> cluster suffered from the same network problem today, but all of those
>>> cluster's PGs recovered nicely.
>>> Does the hammer RC have different peering logic that might apply here?
>>>
>>> Thanks! Dan
>>>
>>>
>>>
>>>> Thanks :)
>>>>
>>>> Dan
>>>>
>>>> On Fri, Mar 13, 2015 at 12:59 PM, Sage Weil <sage@newdream.net> wrote:
>>>>>
>>>>> This looks a bit like a the osds may have lost a message, actually.
>>>>> You can
>>>>> kick an individual pg to repeer with something like
>>>>>
>>>>> ceph osd pg-temp 75.45 6689
>>>>>
>>>>> See if that makes it go?
>>>>>
>>>>> sage
>>>>>
>>>>>
>>>>>
>>>>> On March 13, 2015 7:24:48 AM EDT, Dan van der Ster <dan@vanderster.com>
>>>>> wrote:
>>>>>>
>>>>>> On Mon, Mar 9, 2015 at 4:47 PM, Gregory Farnum <greg@gregs42.com>
>>>>>> wrote:
>>>>>>>
>>>>>>>   On Mon, Mar 9, 2015 at 8:42 AM, Dan van der Ster
>>>>>>> <dan@vanderster.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>>   Hi Sage,
>>>>>>>>
>>>>>>>>   On Tue, Feb 10, 2015 at 2:51 AM, Sage Weil <sage@newdream.net>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>>   On Mon, 9 Feb 2015, David McBride wrote:
>>>>>>>>>>
>>>>>>>>>>   On 09/02/15 15:31, Gregory Farnum wrote:
>>>>>>>>>>
>>>>>>>>>>>   So, memory
>>>>>>>>>>> usage of an OSD is usually linear in the number of PGs it
>>>>>>>>>>>   hosts. However, that memory can also grow based on at least one
>>>>>>>>>>> other
>>>>>>>>>>>   thing: the number of OSD Maps required to go through peering.
>>>>>>>>>>> It
>>>>>>>>>>>   *looks* to me like this is what you're running in to, not
>>>>>>>>>>> growth on
>>>>>>>>>>>   the number of state machines. In particular, those
>>>>>>>>>>> past_intervals
>>>>>>>>>>> you
>>>>>>>>>>>   mentioned. ;)
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>   Hi Greg,
>>>>>>>>>>
>>>>>>>>>>   Right, that sounds entirely plausible, and is very helpful.
>>>>>>>>>>
>>>>>>>>>>   In practice, that means I'll need to be careful to avoid this
>>>>>>>>>> situation
>>>>>>>>>>   occurring in production ? but given that's unlikely to occur
>>>>>>>>>> except
>>>>>>>>>> in the
>>>>>>>>>>   case of non-trivial neglect, I don't think I need be
>>>>>>>>>> particularly
>>>>>>>>>> concerned.
>>>>>>>>>>
>>>>>>>>>>   (Happily, I'm in the situation that my existing cluster is
>>>>>>>>>> purely for
>>>>>>>>>> testing
>>>>>>>>>>   purposes; the data is expendable.)
>>>>>>>>>>
>>>>>>>>>>   That said, for my own peace of mind, it would be valuable to
>>>>>>>>>> have a
>>>>>>>>>> procedure
>>>>>>>>>>   that can be used to recover from this
>>>>>>>>>> state, even if it's unlikely to occur in
>>>>>>>>>>   practice.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>   The best luck I've had recovering from situations is something
>>>>>>>>> like:
>>>>>>>>>
>>>>>>>>>   - stop all osds
>>>>>>>>>   - osd set nodown
>>>>>>>>>   - osd set nobackfill
>>>>>>>>>   - osd set noup
>>>>>>>>>   - set map cache size smaller to reduce memory footprint.
>>>>>>>>>
>>>>>>>>>     osd map cache size = 50
>>>>>>>>>     osd map max advance = 25
>>>>>>>>>     osd map share max epochs = 25
>>>>>>>>>     osd pg epoch persisted max stale = 25
>>>>>>>
>>>>>>>
>>>>>>>   It can cause extreme slowness if you get into a failure situation
>>>>>>> and
>>>>>>>   your OSDs need to calculate past intervals across more maps than
>>>>>>> will
>>>>>>>   fit in the cache. :(
>>>>>>
>>>>>>
>>>>>> .. extreme slowness or is it also possible to get into a situation
>>>>>> where the PGs are stuck incomplete forever?
>>>>>>
>>>>>> The reason I ask is because we actually had a network issue this
>>>>>> morning that left OSDs flapping and a lot of osdmap epoch churn. Now
>>>>>> our network has
>>>>>> stabilized but 10 PGs are incomplete, even though all
>>>>>> the OSDs are up. One PG looks like this, for example:
>>>>>>
>>>>>> pg 75.45 is stuck inactive for 87351.077529, current state incomplete,
>>>>>> last acting [6689,1919,2329]
>>>>>> pg 75.45 is stuck unclean for 87351.096198, current state incomplete,
>>>>>> last acting [6689,1919,2329]
>>>>>> pg 75.45 is incomplete, acting [6689,1919,2329]
>>>>>>
>>>>>> 1919     3.62000 osd.1919                      up
>>>>>> 1.00000          1.00000
>>>>>> 2329     3.62000 osd.2329                      up
>>>>>> 1.00000          1.00000
>>>>>> 6689     3.62000 osd.6689                      up
>>>>>> 1.00000          1.00000
>>>>>>
>>>>>> The pg query output here: http://pastebin.com/WyTAU69W
>>>>>>
>>>>>> Is that a result of these short map caches or could it be something
>>>>>> else?  (we're running 0.93-76-gc35f422)
>>>>>> WWGD (what would Greg do?) to activate these PGs?
>>>>>>
>>>>>> Thanks! Dan
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>>> in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
