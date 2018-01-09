From: John Spray <jspray@redhat.com>
Subject: Re: mon config storage (config-key vs config)
Date: Tue, 9 Jan 2018 17:17:26 +0000
Message-ID: <CALe9h7cbeZiQi5xEE2qwKZsVMyjLUCJYpWiD054_BtVFyxEa3g@mail.gmail.com>
References: <alpine.DEB.2.11.1801052100410.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:44008 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeAIRRs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jan 2018 12:17:48 -0500
Received: by mail-wm0-f41.google.com with SMTP id g1so3998336wmg.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jan 2018 09:17:47 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801052100410.24931@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jan 5, 2018 at 9:13 PM, Sage Weil <sweil@redhat.com> wrote:
> I forgot to bring this up in the other thread, so staring a new one.
>
> Currently the configs are stored in the config-key table, which means you
> can also see the source values with 'ceph config-key dump':
>
> {
>     "config/crush_chooseleaf_type": "0",
>     "config/mds/debug_mds": "20",
>     "config/mds/debug_mgrc": "20",
>     "config/mds/debug_monc": "20",
> ...
>     "config/osd/osd_scrub_load_threshold": "2000",
>     "config/osd_pool_default_min_size": "1",
>     "config/osd_pool_default_size": "1",
>     "mgr/dashboard/x/server_port": "41879",
>     "mgr/restful/keys/admin": "c28a8d35-282a-4330-aa61-c57e3d7f0ae8",
> ...
> }
>
> This was handy during development before 'ceph config *' were implemented.
> How, I'm not so sure it's the best path.
>
> The first issue is that it's not easy to detect changes directly to
> config-key from the ConfigMonitor code.  (This is an implementation
> artifact; ConfigKeyService is not a normal PaxosService for reasons lost
> of the mists of time.)
>
> More generally, I'm not sure if it *should* be visible and modifiable in a
> separate, different way.  A simple option is to simply move the
> config/* keys into a separate namespace.
>
> On the other hand, config-key so far is only lightly used, by two in-tree
> things:
>
>  - mgr module configs, which look like mgr/$module[/$mgrid]/$option
>  - ceph-disk (and soon ceph-volume) put dmcrypt keys in dm-crypt/osd/*
>
> (It's also been around forever, so users might be sticking all kinds of
> other stuff in there, who knows.)

I like the idea of keeping a schema-less KV store exposed by the mon,
but perhaps the config-key command name was always a bit awkward: it's
not really config keys, it's just whatever data the user is shoving in
there :-)  Not that I have an immediate thought on a better naming.

We do need some separation though, so that we can complain to the user
if they try to set a config value that doesn't exist in the schema,
rather than accepting typos on the assumption that they weren't meant
to be config settings.  Strict validation would mean either
requiring/expecting that the mons are >= the version of the other
daemons, or having a force flag that enables setting config options
that the mon doesn't.

> Should we try to unify the general-purpose config-key storage with the
> well-structured config options in config/*?  Or are they simply two
> different things?  It *is* kind of nice that 'ceph config-key dump' shows
> you both mgr module configs and the daemon configs.

I was hoping to unify the storage and transmission parts, so that the
mgr could subscribe for config updates using the same wiring as normal
config, even if the values in question are not part of the main config
schema.  At the moment the mgrs have some awkward caveats around when
they will actually see modified config options if they weren't the
active mgr that did the modification.

> Is the 'config/' prefix for the native ceph config options the part that
> is out of place?  For example, we could have something like
>
>  mgr/dashboard/server_port = 7000
>  mgr/debug_mgr = 20
>  mgr.x/ms_type = simple
>
> that squishes the ceph configs into the same key space as the module
> options.

Perhaps all the flexible module config should be under a prefix like
"mgr/modules/" so that we can still strictly validate everything
outside that prefix?

> This brings up another longstanding issue: most of our config options have
> a daemon type prefix in the name, e.g. osd_objectstore, mds_cache_size, or
> (more confusingly) things like mon_osd_full_ratio and
> osd_crush_chooseleaf_type (both mon options that affect the mon's initial
> OSDMap creation only).  Is there a way we can realistically rename some of
> these options, perhaps as part of the ceph.conf -> mon config transition?
> Then we would end up with configs more like
>
>  mon/crush_chooseleaf_type = foo
>  mon/initial_osd_full_ratio = ...
>  mds/cache_size = ...
>  osd/objectstore = bluestore
>
> and so on.

In principle, the config metadata is meant to remove the need to try
and express this kind of thing via the variable name.  There are quite
a few things that only make sense for a subset of daemons (e.g. the
osdc_* stuff), so there's not really any way to express that in the
name.

For those things that do have a clear mapping to a particular daemon,
I'm not sure "mds/cache_size" buys us much over "mds_cache_size".

John

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
