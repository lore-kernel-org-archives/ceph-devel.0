From: Samuel Just <sjust@redhat.com>
Subject: Re: Question about how rebuild works.
Date: Fri, 6 Nov 2015 08:48:57 -0800
Message-ID: <CAN=+7FXFfDWif3Fv9FC9QCazFEWEQ45iAOWfZ+ND8m97S9+VAQ@mail.gmail.com>
References: <BY1PR0201MB09044CA844EFDC46E6DA589EE8280@BY1PR0201MB0904.namprd02.prod.outlook.com>
	<CAJ4mKGb=ikHAcfuSNSQr8wSh6b78ovfg2Nu2CQBK9uPL9qcd4w@mail.gmail.com>
	<BY1PR0201MB09044B80D3799ECCA8817AAAE8280@BY1PR0201MB0904.namprd02.prod.outlook.com>
	<CAN=+7FXLCvW7kLMSK8aWqoi8JWNJbasZC9JEUiwHbxiRoFXyYw@mail.gmail.com>
	<CAJ4mKGY8AacZ0E2758hjGXjW50XPSSsMqtTWgBFcehUBB-Aw7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35581 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340AbbKFQs6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 11:48:58 -0500
Received: by ioc74 with SMTP id 74so61908489ioc.2
        for <ceph-devel@vger.kernel.org>; Fri, 06 Nov 2015 08:48:57 -0800 (PST)
In-Reply-To: <CAJ4mKGY8AacZ0E2758hjGXjW50XPSSsMqtTWgBFcehUBB-Aw7Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Nope, it's worse, there could be arbitrary portions of backfilled and
unbackfilled portions on any particular incomplete osd.  We'd need a
backfilled_regions field with a type like map<hobject_t, hobject_t>
mapping backfilled regions begin->end.  It's pretty tedious, but
doable provided that we bound how large the mapping gets.  I'm
skeptical about how large an effect this would actually have on
overall durability (how frequent is this case?).  Once Allen does the
math, we'll have a better idea :)
-Sam

On Fri, Nov 6, 2015 at 8:43 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> Argh, I guess I was wrong. Sorry for the misinformation, all! :(
>
> If we were to try and do this, Sam, do you have any idea how much it
> would take? Presumably we'd have to add a backfill_begin marker to
> bookend with last_backfill_started, and then everywhere we send over
> object ops we'd have to compare against both of those values. But I'm
> not sure how many sites that's likely to be, what other kinds of paths
> rely on last_backfill_started, or if I'm missing something.
> -Greg
>
> On Fri, Nov 6, 2015 at 8:30 AM, Samuel Just <sjust@redhat.com> wrote:
>> What it actually does is rebuild 3 until it catches up with 2 and then
>> it rebuilds them in parallel (to minimize reads).  Optimally, we'd
>> start 3 from where 2 left off and then circle back, but we'd have to
>> complicate the metadata we use to track backfill.
>> -Sam
