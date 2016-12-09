From: Samuel Just <sjust@redhat.com>
Subject: Re: random thoughts on past_intervals
Date: Fri, 9 Dec 2016 14:38:34 -0800
Message-ID: <CAN=+7FWJ4J32dkNSmDrpVnUTcvwo6J1m14ON1COhcp5d_UrweQ@mail.gmail.com>
References: <CAN=+7FUSq49OxTbKNRO7xkay0MQAGyfZyBKnUnn+Nux-ysNVOA@mail.gmail.com>
 <CAN=+7FUBDFcDUVztaGh0xf2rU833HEM9ja2i1G5garSooEuJrw@mail.gmail.com> <alpine.DEB.2.11.1612092214330.5710@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34439 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbcLIWif (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Dec 2016 17:38:35 -0500
Received: by mail-qt0-f178.google.com with SMTP id n6so29489946qtd.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Dec 2016 14:38:35 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612092214330.5710@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Currently, never.  However, I'm thinking that we might want to retain
the freedom to not send the structure if it's really big.  And
actually, we won't ever need to extend a received past_intervals
structure to the current epoch since if the interval changed, we'd
throw out the whole message.
-Sam

On Fri, Dec 9, 2016 at 2:16 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 9 Dec 2016, Samuel Just wrote:
>> In particular, we don't need PG::generate_past_intervals duplicating
>> the logic in build_past_intervals_parallel since constructed PG
>> objects only ever need to maintain a consistent past_intervals
>> structure, never build it from scratch.
>
> Sounds good to me.
>
> My main question is:
>
>> On Fri, Dec 9, 2016 at 11:59 AM, Samuel Just <sjust@redhat.com> wrote:
>> > There's code for dealing with some odd past_intervals configurations
>> > including doesn't go back far enough and doesn't go forward far
>> > enough.  I *think* we can simplify this as follows:
>> > 1) Once the PG object is constructed and in memory, past_intervals
>> > extends from history.last_epoch_started to the PG's current map
>> > 2) On disk, either 1) is true or the set is empty (after an import)
>> >
>> > On boot, the OSD generates past_intervals in parallel for any PGs
>> > without them (and perhaps verifies 1) for the rest).  On receipt of a
>> > Notify creating a PG, the OSD generates the past_intervals structure
>> > before instantiating the PG using the same process as on boot --
>> > starting with the included past_intervals if present (may not extend
>> > to the current map, and so may need to be extended).
>
> When does this actually happen?  If PGs are always in state 1, can we
> instead ensure that PG notify will always include past_intervals and that
> a received notify will never require us to go off do the (slow) work of
> loading up old maps to generate old intervals?
>
> Then, we can focus our efforts on make the past_intervals representation
> compact (e.g., by discarding redundant intervals)...
>
> sage
