From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Bounding OSD memory requirements during peering/recovery
Date: Mon, 9 Mar 2015 16:42:47 +0100
Message-ID: <CABZ+qqnaRfuSbttG4vFQLPoBiptV2m7KFTBxg505369VoiEGMQ@mail.gmail.com>
References: <54D78939.4000708@cam.ac.uk> <CAC6JEv8NYw2qk9O7pcSmrVwd2p=7mfLDrA+1tBmFxf2-_f-tZw@mail.gmail.com>
 <54D92850.5080409@cam.ac.uk> <alpine.DEB.2.00.1502091746100.3035@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:41447 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbbCIPna (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 11:43:30 -0400
Received: by lbvp9 with SMTP id p9so49000922lbv.8
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2015 08:43:29 -0700 (PDT)
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com. [209.85.217.178])
        by mx.google.com with ESMTPSA id dk7sm3512801lbc.28.2015.03.09.08.43.27
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 08:43:28 -0700 (PDT)
Received: by lbvp9 with SMTP id p9so49000712lbv.8
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2015 08:43:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1502091746100.3035@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: David McBride <dwm37@cam.ac.uk>, Gregory Farnum <greg@gregs42.com>, Ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

On Tue, Feb 10, 2015 at 2:51 AM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 9 Feb 2015, David McBride wrote:
>> On 09/02/15 15:31, Gregory Farnum wrote:
>>
>> > So, memory usage of an OSD is usually linear in the number of PGs it
>> > hosts. However, that memory can also grow based on at least one other
>> > thing: the number of OSD Maps required to go through peering. It
>> > *looks* to me like this is what you're running in to, not growth on
>> > the number of state machines. In particular, those past_intervals you
>> > mentioned. ;)
>>
>> Hi Greg,
>>
>> Right, that sounds entirely plausible, and is very helpful.
>>
>> In practice, that means I'll need to be careful to avoid this situation
>> occurring in production ? but given that's unlikely to occur except in the
>> case of non-trivial neglect, I don't think I need be particularly concerned.
>>
>> (Happily, I'm in the situation that my existing cluster is purely for testing
>> purposes; the data is expendable.)
>>
>> That said, for my own peace of mind, it would be valuable to have a procedure
>> that can be used to recover from this state, even if it's unlikely to occur in
>> practice.
>
> The best luck I've had recovering from situations is something like:
>
> - stop all osds
> - osd set nodown
> - osd set nobackfill
> - osd set noup
> - set map cache size smaller to reduce memory footprint.
>
>   osd map cache size = 50
>   osd map max advance = 25
>   osd map share max epochs = 25
>   osd pg epoch persisted max stale = 25
>

These above settings have proven to be very useful when setting up
some of our new OSD servers with not much memory per OSD: 64GB RAM for
48x4TB OSDs
Prior to applying these settings (plus one more, below) we were seeing
memory usage around 2-3GB / OSD when they are freshly created. After a
restart the processes stayed under 3-400MB.

It seems the initial bootstrapping -- getting all the most recent 500
osdmaps -- in bunches of 100 at a time causes the osd map cache to
exceed its 50 entry limit -- and that memory is then never freed. We
found that to fix this we had to also lower the "osd map message max"
setting on the mons -- like that them OSD memory is staying under
500MB per process.

Currently we're happily running a large [1] number of OSDs with the
following configuration:

[global]
   osd map message max = 10

[osd]
   osd map cache size = 20
   osd map max advance = 10
   osd map share max epochs = 10
   osd pg epoch persisted max stale = 10

and the memory consumption is 400-500MB per process, even during
backfilling. And so far we didn't see any drawbacks to this
configuration. Should we expect any problems if we continue with this
small osdmap cache, permanently?

Best Regards,
Dan

[1] "large" in this case means the osdmap is 4.6MB in size
