From: Bernard Grymonpon <bernard@openminds.be>
Subject: Re: Braindump: path names, partition labels, FHS, auto-discovery
Date: Tue, 20 Mar 2012 08:55:00 +0100
Message-ID: <743795FD-1626-4709-906C-98A3FFBF27A7@openminds.be>
References: <CAORUGqB-XXXt3Gdx6xdKupg+dwC7XMGptg-K_2QTmn4ybcK+Qg@mail.gmail.com> <1331114101.19173.34.camel@squire.doc.ic.ac.uk> <Pine.LNX.4.64.1203071240550.32072@cobra.newdream.net> <loom.20120319T094436-306@post.gmane.org> <Pine.LNX.4.64.1203200004040.22592@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from november.openminds.be ([195.47.215.47]:41912 "EHLO
	november.openminds.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917Ab2CTICa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Mar 2012 04:02:30 -0400
Received: from bernard-wired.om (unknown [83.101.71.187])
	by november.openminds.be (Postfix) with ESMTPA id A010212A4037
	for <ceph-devel@vger.kernel.org>; Tue, 20 Mar 2012 08:55:00 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.1203200004040.22592@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 20 Mar 2012, at 08:25, Sage Weil wrote:

> On Mon, 19 Mar 2012, Bernard Grymonpon wrote:
>> Sage Weil <sage <at> newdream.net> writes:
>> 
>>> 
>>> On Wed, 7 Mar 2012, David McBride wrote:
>>>> On Tue, 2012-03-06 at 13:19 -0800, Tommi Virtanen wrote:
>>>> 
>>>>> - scan the partitions for partition label with the prefix
>>>>> "ceph-osd-data-".
>>>> 
>>>> Thought: I'd consider not using a numbered partition label as the
>>>> primary identifier for an OSD.
>>>> 
>> 
>> <snip>
>> 
>>>> To make handling cases like these straightforward, I suspect Ceph may
>>>> want to use something functionally equivalent to an MD superblock --
>>>> though in practice, with an OSD, this could simply be a file containing
>>>> the appropriate meta-data.
>>>> 
>>>> In fact, I imagine that the OSDs could already contain the necessary
>>>> fields -- a reference to their parent cluster's UUID, to ensure foreign
>>>> volumes aren't mistakenly mounted; something like mdadm's event-counters
>>>> to distinguish between current/historical versions of the same OSD.
>>>> (Configuration epoch-count?); a UUID reference to that OSD's journal
>>>> file, etc.
>>> 
>>> We're mostly there.  Each cluster has a uuid, and each ceph-osd instance 
>>> gets a uuid when you do ceph-osd --mkfs.  That uuid is recorded in the osd 
>>> data dir and in the journal, so you know that they go together.  
>>> 
>>> I think the 'epoch count' type stuff is sort of subsumed by all the osdmap 
>>> versioning and so forth... are you imagining a duplicate/backup instance 
>>> of an osd drive getting plugged in or something?  We don't guard for 
>>> that, but I'm not sure offhand how we would.  :/
>>> 
>>> Anyway, I suspect the missing piece here is to incorporate the uuids into 
>>> the path names somehow.  
>> 
>> I would discourage using the disk-labels, as you might not always be able to
>> set these (consider imported luns from other storage boxes, or some internal
>> regulations in labeling disks...). I would trust the sysadmin to know which
>> mounts go where to get everything in place (he himself can use the labels in
>> his fstab or some clever bootscript), and then use the ceph-metadata to start
>> only "sane" OSDs/MONs/...
> 
> The goal is to make this optional.  I.e., provide tools to use via udev 
> to mount disks in good locations based on labels, but not require them if 
> the sysadmin has some other idea about how it should be done.
> 
> Ideally, the start/stop scripts should be able to look in /var/lib/ceph 
> and start daemons for whatever it sees there that looks sane.

Start/stop scripts should not be that intelligent in my opinion - a start/stop script should just start or stop whatever it is told to start/stop (usually through a simple config file, pointing to the correct folders). If a sysadmin decides to make a backup copy of some data in /var/lib/ceph, it should not result in suddenly spawning new instances... 

Also, a start/stop script should start/stop very clearly a certain osd/mon... you don't want to restart/start/stop each and every daemon every time (and the optional third parameter to start/stop script is non-common).

> 
>> In my opinion, a OSD should be able to figure out himself if he has a "good"
>> dataset to "boot" with - and it is up to the mon to either reject or accept
>> this OSD as a good/valid part of the cluster, or if it needs re-syncing.
> 
> Yes.
> 
>>> TV wrote: > > - FHS says human-editable configuration goes in /etc > > - FHS
>> says machine-editable state goes in /var/lib/ceph > > - use
>> /var/lib/ceph/mon/$id/ for mon.$id > > - use /var/lib/ceph/osd-journal/$id for
>> osd.$id journal; symlink to > > actual location > > - use
>> /var/lib/ceph/osd-data/$id for osd.$id data; may be a symlink to > > actual
>> location? > > I wonder if these should be something like > >
>> /var/lib/ceph/$cluster_uuid/mon/$id >
>> /var/lib/ceph/$cluster_uuid/osd-data/$osd_uuid.$id >
>> /var/lib/ceph/$cluster_uuid/osd-journal/$osd_uuid.$id
>> 
>> The numbering of the MON/OSD's is a bit a hassle now, best would be (in my
>> opinion)
>> 
>> /var/lib/ceph/$cluster_uuid/osd/$osd_uuid/data
>> /var/lib/ceph/$cluster_uuid/osd/$osd_uuid/journal
>> /var/lib/ceph/$cluster_uuid/osd/$mon_uuid/
>> 
>> Journal and data go together for the OSD - so no need to split these on a
>> lower level. One can't have a OSD without both, so seems fair to put them next
>> to each other...
> 
> Currently the ceph-osd it told which id to be on startup; the only real 
> shift here would be to let you specify some uuids instead and have it pull 
> it's rank (id) out of the .../whoami file.
> 
> Monitors have user-friendly names ('foo', `hostname`).  We could add uuids 
> there too, but I'm less sure how useful that'll be.

Consistency would be the word you're looking for... both in ceph and in the storage-field. The storage ops is used to long random strings identifying parts (luns, identifiers, ...). 

Allowing the sysadmin to specify the UUID themselfs would give the best of both worlds: lazy admins use the generated UUIDs, others generate their own (I can image that having the node identified by its hostname, or some other label might be useful in a 10+ node cluster...). 

> 
>>> so that cluster instances don't stomp on one another.  OTOH, that would 
>>> imply that we should do something like
>>> 
>>> /etc/ceph/$cluster_uuid/ceph.conf, keyring, etc.
>> 
>> Ack, although at cluster creation, the cluster_uuid is unknown, which kind of
>> gives a chicken-egg situation.
> 
> Making the mkfs process take the cluster_uuid as input is easy, although 
> it makes it possible for a bad sysadmin to share a uuid across clusters.

Don't care for bad sysadmins :)

> 
> 
>> As I've been constructing some cookbooks to setup a default cluster, this is
>> what I bumped into:
>> 
>> - the numbering (0, 1, ...) of the OSDs and their need to keep the same number
>>  throughout the lifetime of the cluster is a bit a hassle. Each OSD needs to
>>  have a complete view of all the components of the cluster before it can
>>  determine it's own ID. A random, auto-generated UUID would be nice (I
>>  currently solved this by assigning each cluster a global "clustername", and
>>  search the chef server for all nodes, look for the highest indexed OSDs, and
>>  increment this to determine the new OSD's index - there must be a better
>>  way).
> 
> The 'ceph osd create' command will handle the allocation of a new unique 
> id for you.  We could supplement that with a uuid to make it a bit more 
> robust (if we add the osd uuids to the osdmap... probbaly a good idea 
> anyway).

For this to work, you need a connection to the monitor(s), which gives security issues, and make the creation of a OSD a two-node-operation. A OSD should generate a UUID itself, and that is his one and only identifier. Once joined in a cluster for the first time, it might record the cluster uuid in its metadata. If the uuid of the osd clashes with an existing uuid the mon should reject it.

> 
>> - the configfile needs to be the same on all hosts - which is only partially
>>  true. From my point of view, a OSD should only have some way of contacting
>>  one mon, which would inform the OSD of the cluster layout. So, only the
>>  mon-info should be there (together with the info for the OSD itself,
>>  obviously)
> 
> It doesn't, actually; it's only need to bootstrap (to find the monitor(s) 
> on startup) and to set any config values that are non-default.  The 
> current start/stop script wants to see the loca instances there, but that 
> can be replaced by looking for directories in /var/lib/ceph/.
> 
>> - there is a chicken-egg problem in the authentication of a osd to the mon. An
>>  OSD should have permission to join the mon, for which we need to add the OSD
>>  to the mon. As chef works on the node, and can't trigger stuff on other
>>  nodes, the node that will hold the OSD needs some way of authenticating
>>  itself to the mon (I solved this by storing the "client.admin" secret on the
>>  mon-node, and then pulling this from there on the osd node, and using it to
>>  register myself to the mon. It is like putting a copy of your homekey on
>>  your front door...). I see no obvious solution here.
> 
> We've set up a special key that has permission to create new osds only, 
> but again it's pretty bad security.  Chef's model just doesn't work well 
> here.

There will always be some sort of "master key" for the cluster to create/accept new instances (either this, or no security at all). I don't see a way around it (or you will give up parts of the security model).

The more i think about it, all of the security between mons and osds is a bit strange - most of the time your storage cluster will be on a isolated, dedicated network (the private network/public network parameters do this already). Security and rights towards the client nodes is needed,... 

> 
>> - the current (debian) start/stop scripts are a hassle to work with, as chef
>>  doesn't understand the third parameter (/etc/init.d/ceph start mon.0). Each
>>  mon / osd / ... should have its own start/stop script.
>> 
>> - there should be some way to ask a local running OSD/MON for its status,
>>  without having to go through the monitor-nodes. Sort of "ceph-local-daemon
>>  --uuid=xxx --type=mon status", which would inform us if it is running,
>>  healthy, part of the cluster, lost in space...
> 
> Each daemon has a socket in /var/run/ceph to communicate with it; adding a 
> health command would be pretty straightforward.
> 
>> - growing the cluster bit by bit would be ideal, this is how chef works (it
>>  handles node per node, not a bunch of nodes in one go) 
> 
> This works now, with the exception of monitor cluster bootstrap being 
> awkward.

How is the initial amount of pgs determined. If you start with no OSDs, and add them, do the pgs grow?

> 
>> - ideal, there would be a automatic-crushmap-expansion command which would add
>>  a device to an existing crushmap (or remove one). Now, the crushmap needs to
>>  be reconstructed completely, and if your numbering changes somehow, you're
>>  screwed. Ideal would be "take the current crushmap and add OSD with uuid
>>  xxx" - "take the current crushmap and remove OSD xxx"
> 
> You can do this now, too:
> 
> ceph osd crush add <$osdnum> <osd.$osdnum> <weight> host=foo rack=bar [...]
> 
> The crush map has a alphanumeric name that crush ignores (at least for 
> devices), although osd.$num is what we generate by default.  The 
> keys/values are crush types for other levels of the hierarchy, so that you 
> can specify where in the tree the new item should be placed.

Nice, I'll have a look at this later this week.

> 
> The questions for me now are what we should use for default locations and 
> document as best practice.
> 
> - do we want $cluster_uuid all over the place?

In my opinion - no. I don't see a single machine serving two clusters at once. Only in very special test-cases this might be the case. If a OSD knows which cluster it belongs to (and records this in his metadata), that would be fine.

> - should we allow osds to be started by $uuid instead of rank?

Yes, please. Numbering things is a pain, if you don't have/control all the nodes at once. 

> - is it sufficient for init scripts to blindly start everything in 
>   /var/lib/ceph, or do we need equivalent functionality to the 'auto 
>   start = false' in ceph.conf (that Wido is using)?
> - is a single init script still appropriate, or do we want something 
>   better?  (I'm not very familiar with the new best practices for upstart 
>   or systemd for multi-instance services like this.)

Start/stop scripts should be stupid in my opinion - see above. 

> - uuids for monitors?

yes

> - osd uuids in osdmap?

yes, loose the "rank" completely if possible.  

Rgds,
Bernard

> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

