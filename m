From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Question about how rebuild works.
Date: Fri, 6 Nov 2015 08:43:10 -0800
Message-ID: <CAJ4mKGY8AacZ0E2758hjGXjW50XPSSsMqtTWgBFcehUBB-Aw7Q@mail.gmail.com>
References: <BY1PR0201MB09044CA844EFDC46E6DA589EE8280@BY1PR0201MB0904.namprd02.prod.outlook.com>
	<CAJ4mKGb=ikHAcfuSNSQr8wSh6b78ovfg2Nu2CQBK9uPL9qcd4w@mail.gmail.com>
	<BY1PR0201MB09044B80D3799ECCA8817AAAE8280@BY1PR0201MB0904.namprd02.prod.outlook.com>
	<CAN=+7FXLCvW7kLMSK8aWqoi8JWNJbasZC9JEUiwHbxiRoFXyYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33359 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225AbbKFQnM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 11:43:12 -0500
Received: by wmec201 with SMTP id c201so22978359wme.0
        for <ceph-devel@vger.kernel.org>; Fri, 06 Nov 2015 08:43:10 -0800 (PST)
In-Reply-To: <CAN=+7FXLCvW7kLMSK8aWqoi8JWNJbasZC9JEUiwHbxiRoFXyYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sjust@redhat.com>

Argh, I guess I was wrong. Sorry for the misinformation, all! :(

If we were to try and do this, Sam, do you have any idea how much it
would take? Presumably we'd have to add a backfill_begin marker to
bookend with last_backfill_started, and then everywhere we send over
object ops we'd have to compare against both of those values. But I'm
not sure how many sites that's likely to be, what other kinds of paths
rely on last_backfill_started, or if I'm missing something.
-Greg

On Fri, Nov 6, 2015 at 8:30 AM, Samuel Just <sjust@redhat.com> wrote:
> What it actually does is rebuild 3 until it catches up with 2 and then
> it rebuilds them in parallel (to minimize reads).  Optimally, we'd
> start 3 from where 2 left off and then circle back, but we'd have to
> complicate the metadata we use to track backfill.
> -Sam
