From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Supplying ID to ceph-disk when creating OSD
Date: Wed, 15 Feb 2017 10:13:14 -0800
Message-ID: <CAJ4mKGaYzPhYWhD3OL94KbHDuK6MjcCBqpB+NrsKGCqMje6VoA@mail.gmail.com>
References: <1907009558.10080.1487177956475@ox.pcextreme.nl>
 <CAJ4mKGZPfWg+WCfYdaobuRj0BgqSatQ11UNTFhvxqNiG2Fh-vw@mail.gmail.com> <alpine.DEB.2.11.1702151723350.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34622 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbdBOSNQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 13:13:16 -0500
Received: by mail-oi0-f45.google.com with SMTP id s203so90821714oie.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2017 10:13:16 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702151723350.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Feb 15, 2017 at 9:34 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 15 Feb 2017, Gregory Farnum wrote:
>> On Wed, Feb 15, 2017 at 8:59 AM, Wido den Hollander <wido@42on.com> wrote:
>> > Hi,
>> >
>> > Currently we can supply a OSD UUID to 'ceph-disk prepare', but we can't provide a OSD ID.
>> >
>> > With BlueStore coming I think the use-case for this is becoming very valid:
>> >
>> > 1. Stop OSD
>> > 2. Zap disk
>> > 3. Re-create OSD with same ID and UUID (with BlueStore)
>> > 4. Start OSD
>> >
>> > This allows for a in-place update of the OSD without modifying the CRUSHMap. For the cluster's point of view the OSD goes down and comes back up empty.
>> >
>> > There were some drawbacks around this and some dangers, so before I start working on a PR for this, any gotcaches which might be a problem?
>>
>> Yes. Unfortunately they are subtle and I don't remember them. :p
>>
>> I'd recommend going back and finding the historical discussions about
>> this to be sure. I *think* there were two main issues which prompted
>> us to remove that:
>> 1) people creating very large IDs, needlessly exploding OSDMap size
>> because it's all array-based,
>
> Working in terms of uuids should avoid this (i.e., users can't
> force a large oid id without significant effort).
>
>> 2) issues reusing the ID of lost OSDs versus PGs recognizing that the
>> OSD didn't have the data they wanted.
>>
>> 1 is still a bit of a problem, though if anybody has a good UX way of
>> handling it that's the real issue. 2 has hopefully been fixed over the
>> course of various refactors and improvements, but it's not something
>> I'd count on without checking very carefully.
>
> Oh yeah, this is the one that worries me.  I think the scenario we want
> to help users avoid is that osd N exists (but might be down at the moment)
> and a new, empty version of that same OSD is created and started.
> Peering will reasonably conclude that PG instances don't exist and may
> end up concluding that writes didn't happen.
>
> I think we want some sort of safety check so that the user as to say "this
> osd is dead" before they're allowed to create a new one in its image.  I
> think the simplest thing is to use the existing 'ceph osd lost ...'
> command for this.  I.e., the mon won't let a blank OSD start with a given
> uuid/id unless it is either a new osd rank or the rank is marked
> lost.

Certainly that's a good target and using "ceph osd lost" is *supposed*
to handle this case. But I remember seeing reports that even after
running "lost" — certainly after and I think before they reused the ID
— the OSDs were still waiting for data from the new incarnation. It
worried me and some of them were addressed but I don't know if the
issues have been resolved as I think it's an area of light testing.

>
> My main lingering doubt here is whether it's a bad idea to reuse a uuid;
> it seems like the whole point is that uuids are unique.  Perhaps instead
> the ceph-disk prepare --replace-oid NN command should replace the old uuid
> in the map with the new one as part of this process.  Probably something
> like 'ceph osd replace newuuid olduuid' to make the whole thing
> idempotent...
>
> sage
