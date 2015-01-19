From: Gregory Meno <gmeno@redhat.com>
Subject: Fwd: crush_location hook vs calamari
Date: Mon, 19 Jan 2015 11:12:43 -0500
Message-ID: <CAOWd=nAEyuENX63roRhXDnf3QGi4ewm=61FyBAjNHZsGRMVyMg@mail.gmail.com>
References: <CAOWd=nBExJbD72ereRmn_mv_u=cODRnvDif8RcUiLejcQqKoOg@mail.gmail.com>
	<CAGd4Wr2+AD2J690cdcSwknLhUX16SR+WRQDVpn=+UB9mnO0-Yg@mail.gmail.com>
	<alpine.DEB.2.00.1501160924050.15918@cobra.newdream.net>
	<CAOWd=nCSAqmSok7+sXm8VqZDUWbdsBDiLovzcDVUXk3018pQ2w@mail.gmail.com>
Reply-To: gmeno@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:34189 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbbASQMo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jan 2015 11:12:44 -0500
Received: by mail-qa0-f44.google.com with SMTP id w8so24451809qac.3
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jan 2015 08:12:43 -0800 (PST)
In-Reply-To: <CAOWd=nCSAqmSok7+sXm8VqZDUWbdsBDiLovzcDVUXk3018pQ2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jan 16, 2015 at 12:39 PM, Sage Weil <sweil@redhat.com> wrote:
>
> [adding ceph-devel, ceph-calamari]
>
> On Fri, 16 Jan 2015, John Spray wrote:
> > Ideally we would have a solution that preserved the OSD hot-plugging
> > ability (it's a neat feature).
> >
> > Perhaps the crush location logic should be:
> > * If nobody ever overrode me, default behaviour
> > * If someone (calamari) set an explicit location, preserve that
> > * UNLESS I am on a different hostname than I was when the explicit
> > location was set, in which case kick in the hotplug behaviour
>
> This would be nice...


I agree this sounds fine, and easy enough to explain.

>
>
> > The hotplug path might just be to reset my location in the existing
> > way, or if calamari was really clever it could define how to handle a
> > hostname change within a different root (typically the 'ssd' root
> > people create) such that if I unplugged ssd_root->myhost_ssd and
> > plugged it into foohost, then it would reset its crush location to
> > ssd_root->foohost_ssd instead of root->foohost.
> >
> > We might want to consider adding a flag into the crush map itself so
> > that nodes can be "locked" to indicate that their location was set by
> > human intent rather than the crush-location script.
>
> Perhaps a per-osd flag in the OSDMap?  We have a field for this right now,
> although none of the fields are user-modifiable (they are things up up and
> exists).  I think that makes the most sense.


So If I understand this correctly we are talking about adding data to
the CRUSH map for the crush-location script to read.

It appears to not talk to the cluster presently
ubuntu@vpm148:~$ strace ceph-crush-location --cluster ceph --id 0
--type osd 2>&1 | grep ^open
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
open("/usr/bin/ceph-crush-location", O_RDONLY) = 3

>
>
> We may also be able to avoid the pain in some cases if we bite the bullet
> and standardize how to handle parallel hdd vs ssd vs whatever trees.  Two
> approaches have come up that come to mind:


I have always thought it strange to have multiple trees that duplicate
things with one physical presence. e.g. foohost-spinning-disk and
foohost-SSD. It seems to me if we are going to change things we should
be tagging the OSDs with SSD, I don't think we should restrict the
tagging to them. It seems to be a good option for the future if each
node were able to be tagged in some way. It seems that there are
things on a host that you might care to tag like networking capability
10Gbit vs 1Gbit links.

This suggestion would introduce a need to migrate existing crush-maps
and rules perhaps more than we want. Maybe we take steps in this
direction so we can be here at ceph K series.

>
>
> 1) Make a tree like
>
>  root ssd
>      host host1:ssd
>          osd.0
>          osd.1
>      host host2:ssd
>          osd.2
>          osd.3
>  root sata
>      host host1:sata
>          osd.4
>          osd.5
>      host host2:sata
>          osd.6
>          osd.7
>
> where we 'standardize' (by convention) : as a separator between name and
> device type.  Then we could modify the crush location process to take a
> 'host=host1' location and current host of host1:ssd as a match and make no
> change.
>
> 2) Make the per-type tree generation programatic.  So you would build a
> single tree like this:
>
>  root default
>      host host1
>          devicetype ssd
>              osd.0
>              osd.1
>          devicetype hdd
>              osd.4
>              osd.5
>      host host2
>          devicetype ssd
>              osd.2
>              osd.3
>          devicetype hdd
>              osd.6
>              osd.7
>
> and then on any map change a function in the monitor would programatically
> create a set of per-type trees in the same map:
>
>  root default
>      host host1
>          devicetype ssd
>              osd.0
>              osd.1
>          devicetype hdd
>              osd.4
>              osd.5
>      host host2
>          devicetype ssd
>              osd.2
>              osd.3
>          devicetype hdd
>              osd.6
>              osd.7
>  root default-devicetype:ssd
>      host host1-devicetype:ssd
>          osd.0
>          osd.1
>      host host2-devicetype:ssd
>          osd.2
>          osd.3
>  root default-devicetype:hdd
>      host host1-devicetype:hdd
>          osd.4
>          osd.5
>      host host2-devicetype:hdd
>          osd.6
>          osd.7
>
> The nice thing about this is the crush location script goes on specifying
> the same thing it does now, like host=host1 rack=rack1 etc.  The only
> thing we add is a devicetype=ssd or hdd, perhaps based on was we glean
> from the /sys/block/* (e.g., there is a 'rotating' flag in there to help
> identify SSDs).  Rules that use 'default' will see no change.  But if this
> feature is enabled and we start generating trees based on the 'devicetype'
> crush type we'll get a new set of automagic roots that rules can use
> instead.


Regardless of the representation more smarts about how we discover
these capabilities sounds awesome to me.
>
>
> This doesn't really address the Calamari problem, though... but it would
> solve one of the main use-cases for customizing the map, I think?


You are right about not really addressing calamari. The thing I need
to solve is how to make ceph-crush-location script smart about
coexisting with changes to the crush map.

Gregory


>
> sage
>
>
>
>
>
>
>
> >
> > John
> >
> > On Fri, Jan 16, 2015 at 2:14 PM, Gregory Meno <gmeno@redhat.com> wrote:
> > > The problem I am trying to solve is:
> > > Calamari now has the ability to manage the crush map and for that to be
> > > useful I need to prevent the default behavior of OSDs set update on start.
> > >
> > > The config surrounding crush_location seems complicated enough that I want
> > > some help deciding on the best approach.
> > >
> > > http://tracker.ceph.com/issues/8667 contains the background info
> > >
> > > options:
> > > - Calamari sets "osd update on start to false" on all OSDs it manages.
> > >
> > > - Calamari sets "osd crush location hook" on all OSDs it manages
> > >
> > > criteria:
> > >
> > > - don't piss off admins with existing clusters and configs
> > >
> > > - solution applies after life-cycle requires addition of new OSDs
> > >
> > > - ??? am I missing more
> > >
> > > comparison:
> > >  TBD
> > >
> > > recommendation:
> > >
> > > after talking to Dan the solution that seems best is:
> > >
> > > Have calamari set "osd crush location hook" to a script that asks either
> > > calamari or the cluster for the OSDs last known location in the CRUSH map if
> > > this is a new OSD fallback to a sensible default e.g. the behavior as it
> > > "osd update on start" were true
> > >
> > > The thing I like most about this approach is that we edit the config file
> > > one time.
> > >
> > > regards,
> > > Gregory
> >
> >
