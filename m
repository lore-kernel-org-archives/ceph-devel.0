From: Christian Wuerdig <christian.wuerdig@gmail.com>
Subject: Re: config on mons
Date: Mon, 13 Nov 2017 17:30:45 +1300
Message-ID: <CAE_BDMLSLKw0+nvuibuFLQG8C2tVWw8UqtmevffQXjAd=becyg@mail.gmail.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:46606 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbdKMEar (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Nov 2017 23:30:47 -0500
Received: by mail-lf0-f41.google.com with SMTP id k66so4743165lfg.3
        for <ceph-devel@vger.kernel.org>; Sun, 12 Nov 2017 20:30:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hm, have you guys considered utilizing existing key-value stores like
Consul or etcd for this instead of rolling your own? Not sure about
the details of etcd but the Consul API is quite nice, supports long
polling and transactional support. Obvious downside is that you depend
on a separate service but that can also be an advantage.

On Sat, Nov 11, 2017 at 4:30 AM, Sage Weil <sweil@redhat.com> wrote:
> I've started on this long-discussed feature!  I haven't gotten too far but
> you can see what's there so far at
>
>         https://github.com/ceph/ceph/pull/18856
>
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
>
> - Bootstrapping/upgrade: So far my best idea is to make the client share
> it's config with the mon on startup, and the first time a given daemon
> connects the mon will use that to populate it's config database.
> Thereafter it will be ignored.
>
> - OSD startup: lots of stuff happens before we authenticate.  I think
> there will be a new initial step to fetch config, then do all that work,
> then start up for real.  And a new option to bypass mon configuration
> to avoid that (and for old school folks who don't want centralized
> configs... e.g. mon_config = false and everything works as before).
>
> Feedback welcome!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
