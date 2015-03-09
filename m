From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Bounding OSD memory requirements during peering/recovery
Date: Mon, 9 Mar 2015 08:47:53 -0700
Message-ID: <CAC6JEv-wLAnjRxJBYRrKG9Wqbd1pNKdKs4zSAK_Vojfy+kjVtA@mail.gmail.com>
References: <54D78939.4000708@cam.ac.uk>
	<CAC6JEv8NYw2qk9O7pcSmrVwd2p=7mfLDrA+1tBmFxf2-_f-tZw@mail.gmail.com>
	<54D92850.5080409@cam.ac.uk>
	<alpine.DEB.2.00.1502091746100.3035@cobra.newdream.net>
	<CABZ+qqnaRfuSbttG4vFQLPoBiptV2m7KFTBxg505369VoiEGMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37924 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbbCIPrz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 11:47:55 -0400
Received: by igbhl2 with SMTP id hl2so22059943igb.3
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2015 08:47:55 -0700 (PDT)
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com. [209.85.223.173])
        by mx.google.com with ESMTPSA id vk4sm6314652igc.11.2015.03.09.08.47.54
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 08:47:54 -0700 (PDT)
Received: by iecvy18 with SMTP id vy18so40194281iec.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2015 08:47:54 -0700 (PDT)
In-Reply-To: <CABZ+qqnaRfuSbttG4vFQLPoBiptV2m7KFTBxg505369VoiEGMQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Sage Weil <sage@newdream.net>, David McBride <dwm37@cam.ac.uk>, Ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Mar 9, 2015 at 8:42 AM, Dan van der Ster <dan@vanderster.com> wrote:
> Hi Sage,
>
> On Tue, Feb 10, 2015 at 2:51 AM, Sage Weil <sage@newdream.net> wrote:
>> On Mon, 9 Feb 2015, David McBride wrote:
>>> On 09/02/15 15:31, Gregory Farnum wrote:
>>>
>>> > So, memory usage of an OSD is usually linear in the number of PGs it
>>> > hosts. However, that memory can also grow based on at least one other
>>> > thing: the number of OSD Maps required to go through peering. It
>>> > *looks* to me like this is what you're running in to, not growth on
>>> > the number of state machines. In particular, those past_intervals you
>>> > mentioned. ;)
>>>
>>> Hi Greg,
>>>
>>> Right, that sounds entirely plausible, and is very helpful.
>>>
>>> In practice, that means I'll need to be careful to avoid this situation
>>> occurring in production ? but given that's unlikely to occur except in the
>>> case of non-trivial neglect, I don't think I need be particularly concerned.
>>>
>>> (Happily, I'm in the situation that my existing cluster is purely for testing
>>> purposes; the data is expendable.)
>>>
>>> That said, for my own peace of mind, it would be valuable to have a procedure
>>> that can be used to recover from this state, even if it's unlikely to occur in
>>> practice.
>>
>> The best luck I've had recovering from situations is something like:
>>
>> - stop all osds
>> - osd set nodown
>> - osd set nobackfill
>> - osd set noup
>> - set map cache size smaller to reduce memory footprint.
>>
>>   osd map cache size = 50
>>   osd map max advance = 25
>>   osd map share max epochs = 25
>>   osd pg epoch persisted max stale = 25

It can cause extreme slowness if you get into a failure situation and
your OSDs need to calculate past intervals across more maps than will
fit in the cache. :(

That said, this might be a good idea as long as you're conscious of
needing to set it back if you get into trouble later on.
-Greg
