From: John Spray <jspray@redhat.com>
Subject: Re: config on mons
Date: Mon, 13 Nov 2017 13:23:55 +0000
Message-ID: <CALe9h7fSk4RrHSNCPsRsP19A5+su8jhq8=ssxcas=c1ePR1A_g@mail.gmail.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:56487 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdKMNYR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Nov 2017 08:24:17 -0500
Received: by mail-wr0-f170.google.com with SMTP id q66so14389043wrb.13
        for <ceph-devel@vger.kernel.org>; Mon, 13 Nov 2017 05:24:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Nov 10, 2017 at 3:30 PM, Sage Weil <sweil@redhat.com> wrote:
> I've started on this long-discussed feature!  I haven't gotten too far but
> you can see what's there so far at
>
>         https://github.com/ceph/ceph/pull/18856

Woohoo!

> The first thing perhaps is to finalize what flexibility we want to
> support.  I've a quick summary at
>
>         http://pad.ceph.com/p/config
>
> Namely,
>
>  config/option = value               # like [global]
>  config/$type/option = value         # like [mon]
>  config/$type.$id/option = value     # like [mon.a]
>
> There are two new things:
>
>  config/.../class:$classname/option = value
>
> For OSDs, this matches the device_class.  So you can do something like
>
>  config/osd/class:ssd/bluestore_cache_size = 10485760  # 10gb, woohoo!
>
> You can also match the crush location:
>
>  config/.../$crushtype:$crushvalue/option = value
>
> e.g.,
>
>  config/osd/rack:foo/debug_osd = 10    # hunting some issue
>
> This obviously makes sense for OSDs.  We can also make it makes sense for
> non-OSDs since everybody (clients and daemons) has a concept of
> crush_location that is a set of key/value pairs like "host=foo rack=bar"
> which match the CRUSH hierarchy.  In this case, my plan is to make the
> initial mon authentication step include the hostname of the host you're
> connecting from and then extract the rest of the location by lookup
> up the host in the CRUSH map.
>
> The precedence for these is described here:
>
>         https://github.com/ceph/ceph/pull/18856/commits/5abbd0c9e279022f185787238d21eabbbe28e336#diff-344645b5339d494e1839ff1fcaa5cb7dR15
>
>
> Lots of other thorny issues to consider.  For example:
>
> - What about monitor configs?  If they store their config paxos, and you
> set an option that breaks paxos, how can you change/fix it?  For the
> moment I'm just ignoring the mons.
>
> - What about ceph.conf?  My thought here is to mark which options are
> legal for bootstrap (i.e., used during the initial connection to mon to
> authenticate and fetch config), and warn on anything other than that in
> ceph.conf.  But what about after you connect?  Do these options get reset
> to default?

I can't immediately think of examples of something that would be
needed for bootstrap but would also be sane to change later?  In
general if something is needed for bootstrap I would imagine that the
local setting would be authoritative, but I suspect (because you're
bringing it up) that there are cases where this doesn't apply...

> - Bootstrapping/upgrade: So far my best idea is to make the client share
> it's config with the mon on startup, and the first time a given daemon
> connects the mon will use that to populate it's config database.
> Thereafter it will be ignored.

I hate upgrades :-)

This sounds like a sane thing to do.  We certainly have to do
*something* or we'll have really nasty issues like we had when the
crush_location_hook setting changed names.

For our two-major-versions commitment from Mimic onwards, I guess that
means we leave this mechanism in for the N release too, and then
eventually remove in the O release.

BTW I learned about the "cockeyed squid" aka "strawberry squid"
yesterday, so I think that's a strong candidate for the S name when we
get there, just thinking ahead :-)

> - OSD startup: lots of stuff happens before we authenticate.  I think
> there will be a new initial step to fetch config, then do all that work,
> then start up for real.  And a new option to bypass mon configuration
> to avoid that (and for old school folks who don't want centralized
> configs... e.g. mon_config = false and everything works as before).

I know I'm on the opinionated end of the spectrum here, but I'm not
quite convinced we should leave in a "mon_config = false" option.  If
we continue to let people use the local file interface through this
version, then it's at least another three versions before we can
ultimately remove it, whereas if we disable it now (apart from the
initial load on upgrade) then we are starting the clock for ultimately
removing that plumbing.

We do need to support the upgrade path, but if we enable it to
optionally run with local config on an ongoing basis then we might be
undermining the motivations for building the centralized
infrastructure (the confidence/certainty that the value set is a
validated thing, and that it is really what is in effect).

John

>
> Feedback welcome!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
