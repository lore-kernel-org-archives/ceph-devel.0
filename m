From: Sage Weil <sweil@redhat.com>
Subject: crush_location hook vs calamari
Date: Fri, 16 Jan 2015 09:39:31 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501160924050.15918@cobra.newdream.net>
References: <CAOWd=nBExJbD72ereRmn_mv_u=cODRnvDif8RcUiLejcQqKoOg@mail.gmail.com> <CAGd4Wr2+AD2J690cdcSwknLhUX16SR+WRQDVpn=+UB9mnO0-Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55279 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328AbbAPRjh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 16 Jan 2015 12:39:37 -0500
In-Reply-To: <CAGd4Wr2+AD2J690cdcSwknLhUX16SR+WRQDVpn=+UB9mnO0-Yg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Gregory Meno <gmeno@redhat.com>, Dan Mick <dmick@redhat.com>, John Spray <jspray@redhat.com>, ceph-devel@vger.kernel.org, ceph-calamari@ceph.com

[adding ceph-devel, ceph-calamari]

On Fri, 16 Jan 2015, John Spray wrote:
> Ideally we would have a solution that preserved the OSD hot-plugging
> ability (it's a neat feature).
> 
> Perhaps the crush location logic should be:
> * If nobody ever overrode me, default behaviour
> * If someone (calamari) set an explicit location, preserve that
> * UNLESS I am on a different hostname than I was when the explicit
> location was set, in which case kick in the hotplug behaviour

This would be nice...

> The hotplug path might just be to reset my location in the existing
> way, or if calamari was really clever it could define how to handle a
> hostname change within a different root (typically the 'ssd' root
> people create) such that if I unplugged ssd_root->myhost_ssd and
> plugged it into foohost, then it would reset its crush location to
> ssd_root->foohost_ssd instead of root->foohost.
> 
> We might want to consider adding a flag into the crush map itself so
> that nodes can be "locked" to indicate that their location was set by
> human intent rather than the crush-location script.

Perhaps a per-osd flag in the OSDMap?  We have a field for this right now, 
although none of the fields are user-modifiable (they are things up up and 
exists).  I think that makes the most sense.

We may also be able to avoid the pain in some cases if we bite the bullet 
and standardize how to handle parallel hdd vs ssd vs whatever trees.  Two 
approaches have come up that come to mind:

1) Make a tree like

 root ssd
     host host1:ssd
         osd.0
         osd.1
     host host2:ssd
         osd.2
         osd.3
 root sata
     host host1:sata
         osd.4
         osd.5
     host host2:sata
         osd.6
         osd.7

where we 'standardize' (by convention) : as a separator between name and 
device type.  Then we could modify the crush location process to take a 
'host=host1' location and current host of host1:ssd as a match and make no 
change.

2) Make the per-type tree generation programatic.  So you would build a 
single tree like this:

 root default
     host host1
         devicetype ssd
             osd.0
             osd.1
         devicetype hdd
             osd.4
             osd.5
     host host2
         devicetype ssd
             osd.2
             osd.3
         devicetype hdd
             osd.6
             osd.7

and then on any map change a function in the monitor would programatically 
create a set of per-type trees in the same map:

 root default
     host host1
         devicetype ssd
             osd.0
             osd.1
         devicetype hdd
             osd.4
             osd.5
     host host2
         devicetype ssd
             osd.2
             osd.3
         devicetype hdd
             osd.6
             osd.7
 root default-devicetype:ssd
     host host1-devicetype:ssd
         osd.0
         osd.1
     host host2-devicetype:ssd
         osd.2
         osd.3
 root default-devicetype:hdd
     host host1-devicetype:hdd
         osd.4
         osd.5
     host host2-devicetype:hdd
         osd.6
         osd.7

The nice thing about this is the crush location script goes on specifying 
the same thing it does now, like host=host1 rack=rack1 etc.  The only 
thing we add is a devicetype=ssd or hdd, perhaps based on was we glean 
from the /sys/block/* (e.g., there is a 'rotating' flag in there to help 
identify SSDs).  Rules that use 'default' will see no change.  But if this 
feature is enabled and we start generating trees based on the 'devicetype' 
crush type we'll get a new set of automagic roots that rules can use 
instead.

This doesn't really address the Calamari problem, though... but it would 
solve one of the main use-cases for customizing the map, I think?

sage







> 
> John
> 
> On Fri, Jan 16, 2015 at 2:14 PM, Gregory Meno <gmeno@redhat.com> wrote:
> > The problem I am trying to solve is:
> > Calamari now has the ability to manage the crush map and for that to be
> > useful I need to prevent the default behavior of OSDs set update on start.
> >
> > The config surrounding crush_location seems complicated enough that I want
> > some help deciding on the best approach.
> >
> > http://tracker.ceph.com/issues/8667 contains the background info
> >
> > options:
> > - Calamari sets "osd update on start to false" on all OSDs it manages.
> >
> > - Calamari sets "osd crush location hook" on all OSDs it manages
> >
> > criteria:
> >
> > - don't piss off admins with existing clusters and configs
> >
> > - solution applies after life-cycle requires addition of new OSDs
> >
> > - ??? am I missing more
> >
> > comparison:
> >  TBD
> >
> > recommendation:
> >
> > after talking to Dan the solution that seems best is:
> >
> > Have calamari set "osd crush location hook" to a script that asks either
> > calamari or the cluster for the OSDs last known location in the CRUSH map if
> > this is a new OSD fallback to a sensible default e.g. the behavior as it
> > "osd update on start" were true
> >
> > The thing I like most about this approach is that we edit the config file
> > one time.
> >
> > regards,
> > Gregory
> 
> 
