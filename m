From: John Spray <jspray@redhat.com>
Subject: Re: config on mons
Date: Tue, 14 Nov 2017 23:45:18 +0000
Message-ID: <CALe9h7ciU3ajzPTkh1iCC=+qdEdHbt3n97NCgQDgsML6cLUS2w@mail.gmail.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal> <alpine.DEB.2.11.1711142208490.28240@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:51631 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755000AbdKNXpk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Nov 2017 18:45:40 -0500
Received: by mail-wm0-f49.google.com with SMTP id b189so18445019wmd.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Nov 2017 15:45:40 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711142208490.28240@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 14, 2017 at 10:21 PM, Sage Weil <sage@newdream.net> wrote:
> I've updated the pad at
>
>         http://pad.ceph.com/p/config
>
> After thinking about this a bit more, I think we may need to abandon the
> idea of a pure ceph.conf-less world.  Lots of people already have tooling
> around ceph.conf, getting rid of it will be an awkward process (even for a
> one-time upgrade), and I'm not sure we can eliminate it entirely anyway
> since many options affect the bootstrapping phase, authentication, and so
> on.
>
> Instead, I'm currently partial to giving processes a more nuanced view of
> their config based on where the value comes from.  A single option may
> include
>
> 1- a default value (compiled in)
> 2- a value from the mon
> 3- a value from ceph.conf
> 4- a value set via command line, 'ceph tell', 'ceph daemon ... config set
> ...', etc.
>
> We would always use the highest-priority value on that list.  This means
> that ceph.conf can override the mon, just like a command-line argument
> overrides ceph.conf.

I think that if there are some folks who just cannot work without
loading local configs onto their nodes, I want to insulate folks
working on user interfaces from having to handle the resulting
complexity.  The folks pushing config files out to their nodes
presumably have their own preferred way of dealing with this stuff, so
they shouldn't miss it from the Ceph UI.

In that spirit, I think that we don't need to have a per-setting
granularity of what is overridden and what isn't: daemons should just
flag whether they are consuming the mon config (default), or whether
they are using local ceph.conf.  That way, folks building UIs can grey
things out at a whole-page level if the cluster is not using
centralized config.  It sacrifices some flexibility for the people who
want to use local conf for some things but central conf for others (do
those people exist?) but I think it's worth it to avoid having a
complicated UI that has to worry about displaying and communicating
the subtle distinctions between those 1/2/3/4 values which might all
be different.

The upshot would be that UI developers could build elements that work
as expected by default for systems that use the central config, but
safely disable themselves on systems where the user has gone their own
way and pushed out local configuration.

> On the flip side of this, all of these values are also reported to the mgr
> and tracked along with the other daemon state.  So regardless of where
> config values come from, it is all still visible via the CLI, GUI, or
> whatever else.
>
> Further, we can then make the GUI (or CLI or whatever) act on that
> information to, say,
>
> - assimilate ceph.conf values into the mon so that ceph.cong can be
> removed/abbreviated (i.e., the upgrade/transition path to centralized
> config)

> - see override values set via cli (i.e., in gui)
> - clear override values (i.e., ceph tell <daemon> config rm <name>)
> - surface a HEALTH_WARN if a CLI or 'config set' override has been
> set on one or more daemons (so the operator knows the running config is
> not persistent).

This comes back to our recurring discussion about whether a
HEALTH_INFO level should exist: I'm increasingly of the opinion that
when we run into things like this, it's nature's way of telling us
that maybe our underlying model is weird (in this case, maybe we
didn't need to have the concept of ephemeral configuration settings in
the system at all).

Maybe ephemeral config changes should be treated the same way I
propose to treat local overrides: the daemon reports just that it has
been overridden, and the GUI goes hands-off and does not attempt to
communicate the story to the user "Well, you see, it's currently set
to xyz until the next restart, at which point it will revert to abc,
that is unless you have a local ceph.conf in which case...".

The ability to rollback config changes seems like it would be the
"right way" to accomplish having some config settings that we set and
then subsequently revert, rather than having the revert happen
implicitly when the daemon next restarts (intentionally or not).

> - surface a HEALTH_WARN if a mon option is overriden by a daemon's local
> ceph.conf file.

Hmm, this makes me a bit confused, as if you're still thinking of the
local ceph.conf being a deprecated/upgrade thing?  If it's really
permitted in general than it wouldn't make sense for it to be a WARN.

John

> Notably, the user can also do nothing and the cluster can continue to
> operate as it always has.  The mgr will still have the new visibility into
> running daemon options, so the GUI experience will still be
> consistent--they just won't be able to change configs centrally (or
> rather, those settings won't have any effect if old ceph.conf's override
> them).
>
> I think Kyle's revision history suggestion is a great one.  I don't have
> any bright ideas about how this should be managed on the mon side yet, but
> I agree that it is an important function and should be baked in from day
> 1.
>
> Thoughts?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
