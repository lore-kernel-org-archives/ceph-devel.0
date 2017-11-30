From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: config on mons
Date: Thu, 30 Nov 2017 14:31:16 -0800
Message-ID: <CAJ4mKGYPa2_YoU54x95G5GAy9UQXP98gOEHqLwPeStgcKpJ0Pw@mail.gmail.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
 <alpine.DEB.2.11.1711142208490.28240@piezo.novalocal> <CALe9h7ciU3ajzPTkh1iCC=+qdEdHbt3n97NCgQDgsML6cLUS2w@mail.gmail.com>
 <alpine.DEB.2.11.1711151318370.28240@piezo.novalocal> <20171115171637.ycmpu4ovmp4laz5l@suse.com>
 <alpine.DEB.2.11.1711151855430.28240@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:44440 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdK3WbS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Nov 2017 17:31:18 -0500
Received: by mail-io0-f172.google.com with SMTP id w127so9226231iow.11
        for <ceph-devel@vger.kernel.org>; Thu, 30 Nov 2017 14:31:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711151855430.28240@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I'm resurrecting this thread since it wasn't clear a consensus was
reached, I was out on vacation while it was happening, and it doesn't
look like there's been much work done yet to render any discussion
obsolete.

Mostly, I agree with Sage's last email, but I think I have a few other
points to raise. :)

On Wed, Nov 15, 2017 at 1:26 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 15 Nov 2017, Lars Marowsky-Bree wrote:
>> On 2017-11-15T13:32:55, Sage Weil <sage@newdream.net> wrote:
>> > > > 1- a default value (compiled in)
>> > > > 2- a value from the mon
>> > > > 3- a value from ceph.conf
>> > > > 4- a value set via command line, 'ceph tell', 'ceph daemon ... config set
>> > > > ...', etc.
>>
>> I'm opposed to 3 and 4.
>>
>> I *can* see the need to override a value on a per-host or on a
>> per-daemon instance basis (including combinations thereof, e.g., all
>> OSDs on node X). (Back when, we also expected these to be way more
>> frequently needed; to this day, I can count on my fingers the times I
>> needed per-host overrides, I think; really the only use case where this
>> happens more often are debug flags.)
>>
>> But if you want any sort of consistency, those modify the settings in
>> the respective map on the MON, and the daemon *then* gets that one from
>> the single authoritative source of truth.
>
> The problem is this makes the system more fragile, and with a
> complex distributed, and the types of things I've needed to diagnose and
> debug in the past, I am very nervous about taking away the ability to
> force a config value locally (e.g., via 'ceph daemon ...', when it is
> having trouble pulling config from the mon for whatever reason).

Yes, we definitely need a local override. For one thing, we need to be
able to turn on and configure OSDs in disconnected modes (eg, journal
flushes with FileStore) that involve turning on an awful lot of the
full system. Remembering to mark specific config options as
"allowed-to-set-locally" is just not practical or maintainable.

>
> ...
>
> As far as broad principles go, I think we are mostly in alignment: (1) we
> want centrally managed config, (2) managed by the mons, for (3) a
> simplified user experience, and (4) an easy upgrade path to get there.
> I think the implementation required to get that is roughly what I
> described, and although it sounds complicated, none of the key pieces can
> really be taken away.
>
> 1. Daemons report running config to mgr.  We need some form of this no
> matter what for the upgrade/transition.  Beyond that, I think it's still
> important in order to tell whether the "single source of truth" is
> something that even can be true: (1) some options cannot be changed at
> runtime and require a restart, (2) some options may have illegal/invalid
> values, (3) the set of allowed options may change build to build, so
> something that used to valid may not be anymore or may not be if the
> daemon is newer or older than the mon.
>
> 2. Local overrides are possible.  This can/should be rare and reserved
> for extraordinary circumstances, but I don't feel comfortable removing
> this.  In a complex there are many things that could prevent the daemon
> from speaking to the mon to get an updated config.
>
> 3. ceph.conf is allowed in at least some cases.  This is more or less a
> given on the mon in order to handle bootstraping and to resolve bad
> changes to the mon config (that, say, break paxos itself).  There are also
> still cases where initial options are needed to fetch the rest of the
> config from the mon.  And during the transition period it is required.
>
> I think the real question is whether, post-nautilus, we continue to
> encourage or allow ceph.conf for daemons.  I think this is a decision that
> amounts to turning it off in certain circumstances to force users into a
> better world, but it's not something we can do away with to simplify the
> world today.  We can still ignore this possibility from the GUI, perhaps,
> but I think we're better off lumping it together with #2 and doing
> something extremely simple like, say, putting a (!) icon next to options
> that the daemon isn't respecting (because they have overridden it, or need
> to restart, or it is not valid, or whatever else).
>
> I can't see a way to change 1-3 above without a very different approach
> (like, using something external to the mons).  Am I missing something?

I think you're correct about these three statements.

My inclination would be to shift the documentation and expectation to
using the central config service, but that we don't break anything
which users might already have. As long as we expose that daemons have
differing config values from the central service, ceph-mgr can be as
clever or dumb as it wants about handling that.

By the same token, though, I don't think we need to take central
responsibility for removing or editing configs which aren't in the
central mon store. Doing that parsing is a pain in the butt and
presumably anybody who set up a real ceph.conf can manage to remove it
themselves.
One thing we could maybe do is identify the "local config" settings in
Nautilus (that is, stuff specifying specific disks and paths, or
otherwise necessary to make the daemon turn on) and offer a one-click
"delete the ceph.conf and replace it with the minimal set", but that
would just be a one-time option to make life better for upgraders, not
something we want to commit to.


Now, starting from the beginning of the thread, a few other things...

On Fri, Nov 10, 2017 at 7:30 AM, Sage Weil <sweil@redhat.com> wrote:
> Namely,
>
>  config/option = value               # like [global]
>  config/$type/option = value         # like [mon]
>  config/$type.$id/option = value     # like [mon.a]

I am finding this really difficult to work with. Do you expect for
users to manipulate this directly? I can imagine this being the
internal schema, but I hope the CLI commands and GUI are about setting
options on buckets which are pretty-printed in the "osd tree" command!

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
> which match the CRUSH hierarchy.

I am not understanding this at all — I don't think we can have any
expectation that clients know where they are in relationship to the
CRUSH tree. Frequently they are not sharing any of the specified
resources, and they are much more likely to shift locations than OSDs
are. (eg, rbd running in compute boxes in different domains from the
storage nodes, possibly getting live migrated...)

On Mon, Nov 13, 2017 at 10:40 AM, John Spray <jspray@redhat.com> wrote:
> On Mon, Nov 13, 2017 at 6:20 PM, Kyle Bader <kyle.bader@gmail.com> wrote:
>> Configuration files are often driven by configuration management, with
>> previous versions stored in some kind of version control systems. We
>> should make sure that if configuration moves to the monitors that you
>> have some form of history and rollback capabilities. It might be worth
>> modeling it similar to network switch configuration shells, a la
>> Junos.
>>
>> * change configuration
>> * require commit configuration change
>> * ability to rollback N configuration changes
>> * ability to diff to configuration versions
>>
>> That way an admin can figure out when the last configuration change
>> was, what changed, and rollback if necessary.
>
> That is an extremely good idea.
>
> As a minimal thing, it should be pretty straightforward to implement a
> snapshot/rollback.
>
> I imagine many users today are not so disciplined as to version
> control their configs, but this is a good opportunity to push that as
> the norm by building it in.

I get the appeal of snapshotting, but I am definitely not convinced
this is something we should build directly into the monitors. Do you
have an implementation in mind?
It seems to me like this is something we can implement pretty easily
in ceph-mgr (either by restricting the snapshotting to mechanisms that
make changes via the manager, or by subscribing to config changes),
and that for admins using orchestration frameworks they already get
rollbackability from their own version control. Why not take advantage
of those easier development environments, which are easy to adjust
later if we find new requirements or issues?

On Tue, Nov 14, 2017 at 3:45 PM, John Spray <jspray@redhat.com> wrote:
> This comes back to our recurring discussion about whether a
> HEALTH_INFO level should exist: I'm increasingly of the opinion that
> when we run into things like this, it's nature's way of telling us
> that maybe our underlying model is weird (in this case, maybe we
> didn't need to have the concept of ephemeral configuration settings in
> the system at all).
>
> Maybe ephemeral config changes should be treated the same way I
> propose to treat local overrides: the daemon reports just that it has
> been overridden, and the GUI goes hands-off and does not attempt to
> communicate the story to the user "Well, you see, it's currently set
> to xyz until the next restart, at which point it will revert to abc,
> that is unless you have a local ceph.conf in which case...".

I'm with you on this — I don't think there's a reason for the central
config to distinguish between *kinds* of disagreement. We probably
want to expose which daemons are disagreeing on which options, but I'm
not seeing the utility of diagnosing *where* the disagreement was
injected.

We can do a lot with those reported config options and their
disagreements that I think will be of value, though!
*) we can specify that certain config options must not be overridden —
heartbeat timeouts, for instance — and we boot anybody who does so
*) we can be selective about which configs we care about matching in
the GUI. If we roll out a new AwesomeMessenger, we may want to let
users switch to it incrementally and expose that in the GUI. We may
get ambitious someday and have a one-click "convert this OSD to
Bluestore" button. etc. But maybe we just ignore all filestore config
settings, since we're moving to BlueStore and don't care how those may
be set differently for different classes of OSDs. We can deal with the
fact that sometimes a support tech will tell customers to restart an
OSD with debug settings on the command line, and we don't want to
disable part of their dashboard gui when that happens.
*) we can recommend importing differences into the central config
store (eg on upgrade) when they match some heuristic standard of
"makes sense"

-Greg
