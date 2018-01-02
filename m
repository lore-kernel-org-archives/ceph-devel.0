From: John Spray <jspray@redhat.com>
Subject: Re: formatting bytes and object counts in ceph status ouput
Date: Tue, 2 Jan 2018 16:54:55 +0000
Message-ID: <CALe9h7fCJHV+UPeNUreN-gbK3xgdBgmDJLqxC+6ZiDTA1YPPSQ@mail.gmail.com>
References: <20180102104303.hr4ohy2dkxapj6id@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:43485 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeABQzQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jan 2018 11:55:16 -0500
Received: by mail-wm0-f44.google.com with SMTP id n138so62112149wmg.2
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jan 2018 08:55:16 -0800 (PST)
In-Reply-To: <20180102104303.hr4ohy2dkxapj6id@jf_suse_laptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Ceph-Users <ceph-users@ceph.com>

On Tue, Jan 2, 2018 at 10:43 AM, Jan Fajerski <jfajerski@suse.com> wrote:
> Hi lists,
> Currently the ceph status output formats all numbers with binary unit
> prefixes, i.e. 1MB equals 1048576 bytes and an object count of 1M equals
> 1048576 objects.  I received a bug report from a user that printing object
> counts with a base 2 multiplier is confusing (I agree) so I opened a bug and
> https://github.com/ceph/ceph/pull/19117.
> In the PR discussion a couple of questions arose that I'd like to get some
> opinions on:

> - Should we print binary unit prefixes (MiB, GiB, ...) since that would be
> technically correct?

I'm not a fan of the technically correct base 2 units -- they're still
relatively rarely used, and I've spent most of my life using kB to
mean 1024, not 1000.

> - Should counters (like object counts) be formatted with a base 10
> multiplier or  a multiplier woth base 2?

I prefer base 2 for any dimensionless quantities (or rates thereof) in
computing.  Metres and kilograms go in base 10, bytes go in base 2.

It's all very subjective and a matter of opinion of course, and my
feelings aren't particularly strong :-)

John

> My proposal would be to both use binary unit prefixes and use base 10
> multipliers for counters. I think this aligns with user expectations as well
> as the relevant standard(s?).
>
> Best,
> Jan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
