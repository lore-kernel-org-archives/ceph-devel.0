From: Bernard Grymonpon <bernard@openminds.be>
Subject: Re: Braindump: path names, partition labels, FHS, auto-discovery
Date: Mon, 19 Mar 2012 09:21:46 +0000 (UTC)
Message-ID: <loom.20120319T094436-306@post.gmane.org>
References: <CAORUGqB-XXXt3Gdx6xdKupg+dwC7XMGptg-K_2QTmn4ybcK+Qg@mail.gmail.com> <1331114101.19173.34.camel@squire.doc.ic.ac.uk> <Pine.LNX.4.64.1203071240550.32072@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35176 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221Ab2CSJuG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Mar 2012 05:50:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S9ZE4-0005vK-ND
	for ceph-devel@vger.kernel.org; Mon, 19 Mar 2012 10:50:04 +0100
Received: from ip187.91pie0-1.cityconnect.schedom-europe.net ([ip187.91pie0-1.cityconnect.schedom-europe.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 19 Mar 2012 10:50:04 +0100
Received: from bernard by ip187.91pie0-1.cityconnect.schedom-europe.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 19 Mar 2012 10:50:04 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil <sage <at> newdream.net> writes:

> 
> On Wed, 7 Mar 2012, David McBride wrote:
> > On Tue, 2012-03-06 at 13:19 -0800, Tommi Virtanen wrote:
> > 
> > > - scan the partitions for partition label with the prefix
> > > "ceph-osd-data-".
> > 
> > Thought: I'd consider not using a numbered partition label as the
> > primary identifier for an OSD.
> > 

<snip>

> > To make handling cases like these straightforward, I suspect Ceph may
> > want to use something functionally equivalent to an MD superblock --
> > though in practice, with an OSD, this could simply be a file containing
> > the appropriate meta-data.
> > 
> > In fact, I imagine that the OSDs could already contain the necessary
> > fields -- a reference to their parent cluster's UUID, to ensure foreign
> > volumes aren't mistakenly mounted; something like mdadm's event-counters
> > to distinguish between current/historical versions of the same OSD.
> > (Configuration epoch-count?); a UUID reference to that OSD's journal
> > file, etc.
> 
> We're mostly there.  Each cluster has a uuid, and each ceph-osd instance 
> gets a uuid when you do ceph-osd --mkfs.  That uuid is recorded in the osd 
> data dir and in the journal, so you know that they go together.  
> 
> I think the 'epoch count' type stuff is sort of subsumed by all the osdmap 
> versioning and so forth... are you imagining a duplicate/backup instance 
> of an osd drive getting plugged in or something?  We don't guard for 
> that, but I'm not sure offhand how we would.  :/
> 
> Anyway, I suspect the missing piece here is to incorporate the uuids into 
> the path names somehow.  

I would discourage using the disk-labels, as you might not always be able to
set these (consider imported luns from other storage boxes, or some internal
regulations in labeling disks...). I would trust the sysadmin to know which
mounts go where to get everything in place (he himself can use the labels in
his fstab or some clever bootscript), and then use the ceph-metadata to start
only "sane" OSDs/MONs/...

In my opinion, a OSD should be able to figure out himself if he has a "good"
dataset to "boot" with - and it is up to the mon to either reject or accept
this OSD as a good/valid part of the cluster, or if it needs re-syncing.

> TV wrote: > > - FHS says human-editable configuration goes in /etc > > - FHS
says machine-editable state goes in /var/lib/ceph > > - use
/var/lib/ceph/mon/$id/ for mon.$id > > - use /var/lib/ceph/osd-journal/$id for
osd.$id journal; symlink to > > actual location > > - use
/var/lib/ceph/osd-data/$id for osd.$id data; may be a symlink to > > actual
location? > > I wonder if these should be something like > >
/var/lib/ceph/$cluster_uuid/mon/$id >
/var/lib/ceph/$cluster_uuid/osd-data/$osd_uuid.$id >
/var/lib/ceph/$cluster_uuid/osd-journal/$osd_uuid.$id

The numbering of the MON/OSD's is a bit a hassle now, best would be (in my
opinion)

/var/lib/ceph/$cluster_uuid/osd/$osd_uuid/data
/var/lib/ceph/$cluster_uuid/osd/$osd_uuid/journal
/var/lib/ceph/$cluster_uuid/osd/$mon_uuid/

Journal and data go together for the OSD - so no need to split these on a
lower level. One can't have a OSD without both, so seems fair to put them next
to each other...


> so that cluster instances don't stomp on one another.  OTOH, that would 
> imply that we should do something like
> 
>  /etc/ceph/$cluster_uuid/ceph.conf, keyring, etc.

Ack, although at cluster creation, the cluster_uuid is unknown, which kind of
gives a chicken-egg situation.



> > Perhaps related to this, I've been looking to determine whether it's
> > feasible to build and configure a Ceph cluster incrementally -- building
> > an initial cluster containing just a single MON node, and then piecewise
> > adding additional OSDs / MDSs / MONs to build up to the full-set.

This would be ideal - specially for use in chef (and probably other deployment
automation tools).

> > 
> > In part, this is so that the processes for initially setting up the
> > cluster and for expanding the cluster once its in operation are
> > identical.  But this is also to avoid needing to hand-maintain a
> > configuration file, replicated across all hosts, that enumerates all of
> > the different cluster elements -- replicating a function already handled
> > better by the MON elements.
> > 
> > I can almost see the ceph.conf file only being used at cluster
> > initialization-time, then discarded in favour of run-time commands that
> > update the live cluster state.
> > 
> > Is this practical?  (Or even desirable?)
> 
> This is exactly what the eventual chef/juju/etc building blocks will do.  
> The tricky part is really the monitor cluster bootstrap (because you may 
> have 3 of them coming up in parallel, and they need to form an initial 
> quorum in a safe/sane way).  Once that happens, expanding the cluster is 
> pretty mechanical.
> 
> The goal is to provide building blocks (simple scripts, hooks, whatever) 
> for doing things like mapping a new block device to the proper location, 
> starting up the appropriate ceph-osd, initializing/labeling a new device, 
> creating a new ceph-osd on it and adding it to the cluster, etc.  The 
> chef/juju/whatever scripts would then build on the common set of tools.
> 
> Most of the pieces are worked out in TV's head or mine, but we haven't had 
> time to put it all together.  First we need to get our new qa hardware 
> online..

As I've been constructing some cookbooks to setup a default cluster, this is
what I bumped into:

- the numbering (0, 1, ...) of the OSDs and their need to keep the same number
  throughout the lifetime of the cluster is a bit a hassle. Each OSD needs to
  have a complete view of all the components of the cluster before it can
  determine it's own ID. A random, auto-generated UUID would be nice (I
  currently solved this by assigning each cluster a global "clustername", and
  search the chef server for all nodes, look for the highest indexed OSDs, and
  increment this to determine the new OSD's index - there must be a better
  way).

- the configfile needs to be the same on all hosts - which is only partially
  true. From my point of view, a OSD should only have some way of contacting
  one mon, which would inform the OSD of the cluster layout. So, only the
  mon-info should be there (together with the info for the OSD itself,
  obviously)

- there is a chicken-egg problem in the authentication of a osd to the mon. An
  OSD should have permission to join the mon, for which we need to add the OSD
  to the mon. As chef works on the node, and can't trigger stuff on other
  nodes, the node that will hold the OSD needs some way of authenticating
  itself to the mon (I solved this by storing the "client.admin" secret on the
  mon-node, and then pulling this from there on the osd node, and using it to
  register myself to the mon. It is like putting a copy of your homekey on
  your front door...). I see no obvious solution here.

- the current (debian) start/stop scripts are a hassle to work with, as chef
  doesn't understand the third parameter (/etc/init.d/ceph start mon.0). Each
  mon / osd / ... should have its own start/stop script.

- there should be some way to ask a local running OSD/MON for its status,
  without having to go through the monitor-nodes. Sort of "ceph-local-daemon
  --uuid=xxx --type=mon status", which would inform us if it is running,
  healthy, part of the cluster, lost in space...

- growing the cluster bit by bit would be ideal, this is how chef works (it
  handles node per node, not a bunch of nodes in one go) 

- ideal, there would be a automatic-crushmap-expansion command which would add
  a device to an existing crushmap (or remove one). Now, the crushmap needs to
  be reconstructed completely, and if your numbering changes somehow, you're
  screwed. Ideal would be "take the current crushmap and add OSD with uuid
  xxx" - "take the current crushmap and remove OSD xxx"

Just my thoughts! I've been following the ceph project for a while now, set up
a couple of test clusters in the past and the last two weeks, and made the
cookbooks to make my life easier (and bumped in a lot of Ops-trouble doing
this...).

Rgds,
Bernard





