From: Sage Weil <sweil@redhat.com>
Subject: Re: config on mons
Date: Fri, 1 Dec 2017 17:53:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712011720000.12766@piezo.novalocal>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal> <alpine.DEB.2.11.1711142208490.28240@piezo.novalocal> <CALe9h7ciU3ajzPTkh1iCC=+qdEdHbt3n97NCgQDgsML6cLUS2w@mail.gmail.com> <alpine.DEB.2.11.1711151318370.28240@piezo.novalocal>
 <20171115171637.ycmpu4ovmp4laz5l@suse.com> <alpine.DEB.2.11.1711151855430.28240@piezo.novalocal> <CAJ4mKGYPa2_YoU54x95G5GAy9UQXP98gOEHqLwPeStgcKpJ0Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-542568382-1512150794=:12766"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53305 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbdLARxO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 1 Dec 2017 12:53:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F8BA267FC
        for <ceph-devel@vger.kernel.org>; Fri,  1 Dec 2017 17:53:14 +0000 (UTC)
In-Reply-To: <CAJ4mKGYPa2_YoU54x95G5GAy9UQXP98gOEHqLwPeStgcKpJ0Pw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-542568382-1512150794=:12766
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 30 Nov 2017, Gregory Farnum wrote:
> I'm resurrecting this thread since it wasn't clear a consensus was
> reached, I was out on vacation while it was happening, and it doesn't
> look like there's been much work done yet to render any discussion
> obsolete.

Thanks!

> My inclination would be to shift the documentation and expectation to
> using the central config service, but that we don't break anything
> which users might already have. As long as we expose that daemons have
> differing config values from the central service, ceph-mgr can be as
> clever or dumb as it wants about handling that.

+1
 
> By the same token, though, I don't think we need to take central
> responsibility for removing or editing configs which aren't in the
> central mon store. Doing that parsing is a pain in the butt and
> presumably anybody who set up a real ceph.conf can manage to remove it
> themselves.
> One thing we could maybe do is identify the "local config" settings in
> Nautilus (that is, stuff specifying specific disks and paths, or
> otherwise necessary to make the daemon turn on) and offer a one-click
> "delete the ceph.conf and replace it with the minimal set", but that
> would just be a one-time option to make life better for upgraders, not
> something we want to commit to.

Yeah, I view this as TBD.  I want there to be *some* transition path but 
I'm not sure how magic it should be.  Among other issues, daemons run as 
user ceph and won't be able to overwrite /etc/ceph/ceph.conf (usually 
owned by root), so... yeah.


> On Fri, Nov 10, 2017 at 7:30 AM, Sage Weil <sweil@redhat.com> wrote:
> > Namely,
> >
> >  config/option = value               # like [global]
> >  config/$type/option = value         # like [mon]
> >  config/$type.$id/option = value     # like [mon.a]
> 
> I am finding this really difficult to work with. Do you expect for
> users to manipulate this directly? I can imagine this being the
> internal schema, but I hope the CLI commands and GUI are about setting
> options on buckets which are pretty-printed in the "osd tree" command!

The plan is to *store* these in config-key, but have a new, higher-level 
CLI interface (ceph config ...) to them.  That interface would do the 
validation to make sure you are not talking nonsense: verify 
values are legal, config option exists, is not being set on a 
daemon that doesn't care, isn't something that is ceph.conf-only, 
etc.  It would also have the 'show' commands that would dump the running 
config for a daemon and so on.

> > There are two new things:
> >
> >  config/.../class:$classname/option = value
> >
> > For OSDs, this matches the device_class.  So you can do something like
> >
> >  config/osd/class:ssd/bluestore_cache_size = 10485760  # 10gb, woohoo!
> >
> > You can also match the crush location:
> >
> >  config/.../$crushtype:$crushvalue/option = value
> >
> > e.g.,
> >
> >  config/osd/rack:foo/debug_osd = 10    # hunting some issue
> >
> > This obviously makes sense for OSDs.  We can also make it makes sense for
> > non-OSDs since everybody (clients and daemons) has a concept of
> > crush_location that is a set of key/value pairs like "host=foo rack=bar"
> > which match the CRUSH hierarchy.
> 
> I am not understanding this at all — I don't think we can have any
> expectation that clients know where they are in relationship to the
> CRUSH tree. Frequently they are not sharing any of the specified
> resources, and they are much more likely to shift locations than OSDs
> are. (eg, rbd running in compute boxes in different domains from the
> storage nodes, possibly getting live migrated...)

The idea is that *everyone* knows their hostname, which (if the CRUSH 
hierarchy is populated) is enough to tell us the crush location.  
Obviously some clients will be on hosts not in the map and won't 
know--that's fine.  Generally daemons will be, or can be, if we make an 
effort to place hosts that have mon/mgr/mds/rgw/etc daemons but not OSDs 
in the map.

But even if ignore that an only make it work for OSDs that's pretty 
useful too.


> On Mon, Nov 13, 2017 at 10:40 AM, John Spray <jspray@redhat.com> wrote:
> > On Mon, Nov 13, 2017 at 6:20 PM, Kyle Bader <kyle.bader@gmail.com> wrote:
> >> Configuration files are often driven by configuration management, with
> >> previous versions stored in some kind of version control systems. We
> >> should make sure that if configuration moves to the monitors that you
> >> have some form of history and rollback capabilities. It might be worth
> >> modeling it similar to network switch configuration shells, a la
> >> Junos.
> >>
> >> * change configuration
> >> * require commit configuration change
> >> * ability to rollback N configuration changes
> >> * ability to diff to configuration versions
> >>
> >> That way an admin can figure out when the last configuration change
> >> was, what changed, and rollback if necessary.
> >
> > That is an extremely good idea.
> >
> > As a minimal thing, it should be pretty straightforward to implement a
> > snapshot/rollback.
> >
> > I imagine many users today are not so disciplined as to version
> > control their configs, but this is a good opportunity to push that as
> > the norm by building it in.
> 
> I get the appeal of snapshotting, but I am definitely not convinced
> this is something we should build directly into the monitors. Do you
> have an implementation in mind?
> It seems to me like this is something we can implement pretty easily
> in ceph-mgr (either by restricting the snapshotting to mechanisms that
> make changes via the manager, or by subscribing to config changes),
> and that for admins using orchestration frameworks they already get
> rollbackability from their own version control. Why not take advantage
> of those easier development environments, which are easy to adjust
> later if we find new requirements or issues?

I have no good implementation ideas yet, so I'm just ignoring it for the 
moment.  I think a ceph-based interface would be valuable, though.  Say,

 ceph config checkpoint foo
 ceph config set osd.0 debug_osd 20
 ...
 ceph config rollback foo

or even

 ceph config rollback foo osd.0   # just rollback osd.0's config

Even a pretty basic implementation like encoding all of config/ in a map 
and stuffing it into a config/checkpoint/foo key (compressed even?) would 
be sufficient for that sort of thing.

Alternatively, a complete config changelog/history could also support the 
above and would let you do a 'ceph config history [osd.0]' type command 
that tells you how the config has changed, and when, going backwards in 
time.

Of course, having all of that doesn't prevent you from using your 
existing external tools to manage configs and history.  Perhaps a 'ceph 
config import' type operation that takes a dump of everything 
(efficiently) is appropriate for supporting that well.


> On Tue, Nov 14, 2017 at 3:45 PM, John Spray <jspray@redhat.com> wrote:
> > This comes back to our recurring discussion about whether a
> > HEALTH_INFO level should exist: I'm increasingly of the opinion that
> > when we run into things like this, it's nature's way of telling us
> > that maybe our underlying model is weird (in this case, maybe we
> > didn't need to have the concept of ephemeral configuration settings in
> > the system at all).
> >
> > Maybe ephemeral config changes should be treated the same way I
> > propose to treat local overrides: the daemon reports just that it has
> > been overridden, and the GUI goes hands-off and does not attempt to
> > communicate the story to the user "Well, you see, it's currently set
> > to xyz until the next restart, at which point it will revert to abc,
> > that is unless you have a local ceph.conf in which case...".
> 
> I'm with you on this — I don't think there's a reason for the central
> config to distinguish between *kinds* of disagreement. We probably
> want to expose which daemons are disagreeing on which options, but I'm
> not seeing the utility of diagnosing *where* the disagreement was
> injected.

Having a active/not active on the mgr/mon seems fine; I think it's mostly 
a matter of how much effort we want to invest in that interface.

I plan to make the 'ceph daemon X config diff' show the complete story 
(from the daemons perspective), indicating each source (default, conf, 
mon, override) and value that is in play, along with the effective result.

sage
--8323329-542568382-1512150794=:12766--
