From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: disable pg_num warning?
Date: Fri, 20 Feb 2015 11:33:28 -0500
Message-ID: <CAGbvivK0WqcZ_NYtwSHuy9ECcObAzmAsKNqeqKXCTM2+mvBbfg@mail.gmail.com>
References: <CAGbvivKMkar+cEhNeXATp76BzPtfxdERZ=6JoieD3k57e19PxA@mail.gmail.com>
	<alpine.DEB.2.00.1502200812040.14643@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:51179 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbbBTQd2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Feb 2015 11:33:28 -0500
Received: by mail-oi0-f43.google.com with SMTP id z81so3436304oif.2
        for <ceph-devel@vger.kernel.org>; Fri, 20 Feb 2015 08:33:28 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502200812040.14643@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Great, thanks!

On Fri, Feb 20, 2015 at 11:15 AM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 20 Feb 2015, Wyllys Ingersoll wrote:
>> Is there a way to disable the warning (shown when doing "ceph -s", for
>> example) about the number of pgs ("too few pgs per osd") ?
>
> All of the PG-related warnings are tuanble:
>
> OPTION(mon_pg_warn_min_per_osd, OPT_INT, 30)  // min # pgs per (in) osd before we warn the admin
> OPTION(mon_pg_warn_max_per_osd, OPT_INT, 300)  // max # pgs per (in) osd before we warn the admin
> OPTION(mon_pg_warn_max_object_skew, OPT_FLOAT, 10.0) // max skew few average in objects per pg
> OPTION(mon_pg_warn_min_objects, OPT_INT, 10000)  // do not warn below this object #
> OPTION(mon_pg_warn_min_pool_objects, OPT_INT, 1000)  // do not warn on pools below this object #
>
>> Would it be considered risky to disable it?
>
> Go for it.  They are advisory only.  Just keep in mind you're outside of
> the recommended range.
>
>> Consider when a cluster is initially created with just a single pool,
>> and you don't anticipate that this pool will ever be more than a very
>> small percentage of the total capacity (1%, for example).  The new
>> calculator (http://ceph.com/pgcalc) recommends a small pg_num like
>> 128.  However, for a cluster with 144 OSDs, this will trigger the
>> warning about the pg num being too small.
>>
>> It seems that the calculation that triggers the warning is a little
>> bit too simplistic, and while it might be useful in some cases, it is
>> also a nuisance warning that can be ignored in some environments.  It
>> would be nice to tell ceph to ignore it and return a healthy status if
>> everything else is clean.
>
> Hmm, it will go away after the other pool(s) are created that will hold
> the bulk of the data, right?  Unfortunately it's hard to make a helpful
> warning that doesn't make noise during the initial cluster setup...
>
> sage
