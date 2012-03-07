From: Sage Weil <sage@newdream.net>
Subject: Re: Braindump: path names, partition labels, FHS, auto-discovery
Date: Wed, 7 Mar 2012 12:54:01 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203071240550.32072@cobra.newdream.net>
References: <CAORUGqB-XXXt3Gdx6xdKupg+dwC7XMGptg-K_2QTmn4ybcK+Qg@mail.gmail.com>
 <1331114101.19173.34.camel@squire.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47187 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab2CGUyD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Mar 2012 15:54:03 -0500
In-Reply-To: <1331114101.19173.34.camel@squire.doc.ic.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David McBride <dwm@doc.ic.ac.uk>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 7 Mar 2012, David McBride wrote:
> On Tue, 2012-03-06 at 13:19 -0800, Tommi Virtanen wrote:
> 
> > - scan the partitions for partition label with the prefix
> > "ceph-osd-data-".
> 
> Thought: I'd consider not using a numbered partition label as the
> primary identifier for an OSD.
> 
> There are failure modes that can occur, for example, if you have disks
> from multiple different Ceph clusters accessible to a given host, or if
> you have a partially failed (or historical copy) of an OSD disk
> accessible at the same time as a current instance.
> 
> (Though you might reasonably rule these cases as out-of-scope.)
> 
> To make handling cases like these straightforward, I suspect Ceph may
> want to use something functionally equivalent to an MD superblock --
> though in practice, with an OSD, this could simply be a file containing
> the appropriate meta-data.
> 
> In fact, I imagine that the OSDs could already contain the necessary
> fields -- a reference to their parent cluster's UUID, to ensure foreign
> volumes aren't mistakenly mounted; something like mdadm's event-counters
> to distinguish between current/historical versions of the same OSD.
> (Configuration epoch-count?); a UUID reference to that OSD's journal
> file, etc.

We're mostly there.  Each cluster has a uuid, and each ceph-osd instance 
gets a uuid when you do ceph-osd --mkfs.  That uuid is recorded in the osd 
data dir and in the journal, so you know that they go together.  

I think the 'epoch count' type stuff is sort of subsumed by all the osdmap 
versioning and so forth... are you imagining a duplicate/backup instance 
of an osd drive getting plugged in or something?  We don't guard for 
that, but I'm not sure offhand how we would.  :/

Anyway, I suspect the missing piece here is to incorporate the uuids into 
the path names somehow.  

TV wrote:
> - FHS says human-editable configuration goes in /etc
> - FHS says machine-editable state goes in /var/lib/ceph
> - use /var/lib/ceph/mon/$id/ for mon.$id
> - use /var/lib/ceph/osd-journal/$id for osd.$id journal; symlink to
> actual location
> - use /var/lib/ceph/osd-data/$id for osd.$id data; may be a symlink to
> actual location?

I wonder if these should be something like

 /var/lib/ceph/$cluster_uuid/mon/$id
 /var/lib/ceph/$cluster_uuid/osd-data/$osd_uuid.$id
 /var/lib/ceph/$cluster_uuid/osd-journal/$osd_uuid.$id

so that cluster instances don't stomp on one another.  OTOH, that would 
imply that we should do something like

 /etc/ceph/$cluster_uuid/ceph.conf, keyring, etc.

too.


>  - - -
> 
> Perhaps related to this, I've been looking to determine whether it's
> feasible to build and configure a Ceph cluster incrementally -- building
> an initial cluster containing just a single MON node, and then piecewise
> adding additional OSDs / MDSs / MONs to build up to the full-set.
> 
> In part, this is so that the processes for initially setting up the
> cluster and for expanding the cluster once its in operation are
> identical.  But this is also to avoid needing to hand-maintain a
> configuration file, replicated across all hosts, that enumerates all of
> the different cluster elements -- replicating a function already handled
> better by the MON elements.
> 
> I can almost see the ceph.conf file only being used at cluster
> initialization-time, then discarded in favour of run-time commands that
> update the live cluster state.
> 
> Is this practical?  (Or even desirable?)

This is exactly what the eventual chef/juju/etc building blocks will do.  
The tricky part is really the monitor cluster bootstrap (because you may 
have 3 of them coming up in parallel, and they need to form an initial 
quorum in a safe/sane way).  Once that happens, expanding the cluster is 
pretty mechanical.

The goal is to provide building blocks (simple scripts, hooks, whatever) 
for doing things like mapping a new block device to the proper location, 
starting up the appropriate ceph-osd, initializing/labeling a new device, 
creating a new ceph-osd on it and adding it to the cluster, etc.  The 
chef/juju/whatever scripts would then build on the common set of tools.

Most of the pieces are worked out in TV's head or mine, but we haven't had 
time to put it all together.  First we need to get our new qa hardware 
online..

sage
