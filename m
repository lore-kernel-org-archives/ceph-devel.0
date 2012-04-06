From: Bernard Grymonpon <bernard@openminds.be>
Subject: Re: defaults paths #2
Date: Fri, 6 Apr 2012 09:37:01 +0200
Message-ID: <9B9005B1-9397-4171-8726-A52903B8B8F1@openminds.be>
References: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from november.openminds.be ([195.47.215.47]:41066 "EHLO
	november.openminds.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab2DFHhE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 03:37:04 -0400
In-Reply-To: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


On 06 Apr 2012, at 01:36, Tommi Virtanen wrote:

> [Apologies for starting a new thread, vger unsubscribed me without
> warning, I'm reading the previous thread via web]
> 
> In response to the thread at http://marc.info/?t=133360781700001&r=1&w=2
> 
> 
> Sage:
>> The locations could be:
>> keyring:
>>  /etc/ceph/$cluster.keyring  (fallback to /etc/ceph/keyring)
> 
> I think all the osds and mons will have their secrets inside their
> data dir. This, if used, will be just for the command line tools.
> 
>> osd_data, mon_data:
>>  /var/lib/ceph/$cluster.$name
>>  /var/lib/ceph/$cluster/$name
>>  /var/lib/ceph/data/$cluster.$name
>>  /var/lib/ceph/$type-data/$cluster-$id
> 
> I'm thinking.. /var/lib/ceph/$type/$cluster-$id, where $type is osd or mon.
> And this is what is in the wip-defaults branch now, it seems.

That seems a good solution. 

> 
> 
> 
> Bernard Grymonpon <bernard@openminds.be>:
>> As a osd consists of data and the journal, it should stay together, with all info for \
>> that one osd in one place:
>> 
>> I would suggest
>> 
>> /var/lib/ceph/osd/$id/data
>> and
>> /var/lib/ceph/osd/$id/journal
> 
> Journal can live inside .../data (when just a file on the same spindle
> is ok), we don't need to use a directory tree level just for that.
> 
>> ($id could be replaced by $uuid or $name, for which I would prefer $uuid)
> 
> In some ways $uuid is cleaner, but this is something that is too
> visible for admins, and the $id space still exists and cannot tolerate
> collisions, so we might as well use those.

Storage lives by UUID's, I would suggest to move the programming in the direction to get rid of all the own naming and labeling, and just stick to uuids. I could not care less if the data on that disk is internally named "23" or "678", it is just a part of my cluster, and it is up to ceph to figure out which part of the puzzle it holds.

(So, the above would then change to /var/lib/ceph/$type/$cluster/$uuid in my ideal scenario, or some variant on it) 

> 
> 
> Andrey Korolyov <andrey@xdel.ru>:
>> Right, but probably we need journal separation at the directory level
>> by default, because there is a very small amount of cases when speed
>> of main storage is sufficient for journal or when resulting speed
>> decrease is not significant, so journal by default may go into
>> /var/lib/ceph/osd/journals/$i/journal where osd/journals mounted on
>> the fast disk.
> 
> Journals as files in a single, separate, dedicated filesystem (most
> likely on SSD) is on my list of use cases to be supported. I don't
> think we need to always use /var/lib/ceph/osd/journals just to support
> that; I think I can arrange the support without that clumsiness.
> Details are still pending.
> 
> I think many people with that hardware setup will choose to just GPT
> partition the SSD, and have a lot less code in the way of the IO.

A single file, sitting on some partition somewhere, will be very hard to auto-find, unless you'll keep some info in OSD that tracks the UUID of the disk + the path inside the filesystem where it previously was. 

> 
> 
> Bernard Grymonpon <bernard@openminds.be>:
>> I feel it's up to the sysadmin to mount / symlink the correct storage devices on the \
>> correct paths - ceph should not be concerned that some volumes might need to sit \
>> together.
> 
> I think we agree on intents, but I disagree strongly with the words
> you chose. The sysadmin should not need to symlink anything. We will
> bring up a whole cluster, and enable you to manage that easily.
> Anything less is a failure. You may choose to opt out of some of that
> higher smarts, if you want to do it differently, but we will need to
> provide that. Managing a big cluster without automation is painful,
> and people shouldn't need to reinvent the wheel.

Actually, it will bring up one node of a cluster, regardless of the state of the other parts of the cluster. Question is how automated everything should be detected and started.

Hotplugging and auto-mounting is there already - it is up to the sysadmin to use it if needed.

> 
> Now, whether that automation uses symlinks to point things to the
> right places or not, that's almost an implementation detail.
> 
> 
> 
> Bernard Grymonpon <bernard@openminds.be>:
>> I assume most OSD nodes will normally run a single OSD, so this would not apply to \
>> most nodes.
> 
> Expected use right now is 1 OSD per hard drive, 8-12 hard drives per
> server. That's what we'll be benchmarking on, primarily.
> 
> 
> 
> Wido den Hollander <wido@widodh.nl>:
>> I think that's a wrong assumption. On most systems I think multiple OSDs
>> will exist, it's debatable if one would run OSDs from different clusters
>> very often.
> 
> I expect mixing clusters to be rare, but that use case has been made
> strongly enough that it seems we will support it as a first-class
> feature.
> 
>> I'm currently using: osd data = /var/lib/ceph/$name
>> 
>> To get back to what sage mentioned, why add the "-data" suffix to a
>> directory name? Isn't it obvious that a directory will contain data?
> 
> He was separating osd-data from osd-journal. Since that we've
> simplified that to /var/lib/ceph/$type/$cluster-$id, which is close to
> what you have, but 1) separating osd data dirs from rest of
> /var/lib/ceph, for future expansion room 2) adding the cluster name.
> 
>> As I think it is a very specific scenario where a machine would be
>> participating in multiple Ceph clusters I'd vote for:
>> 
>>  /var/lib/ceph/$type/$id
> 
> I really want to avoid having two different cases, two different code
> paths to test, a more rare variant that can break without being
> noticed. I want everything to always look the same. "ceph-" seems a
> small enough price to pay for that.
> 
> 
> 
> Bernard Grymonpon <bernard@openminds.be>:
>> If it is recommended setup to have multiple OSDs per node (like, one OSD per physical \
>> drive), then we need to take that in account - but don't assume that one node only \
>> has one SSD disk for journals, which would be shared between all OSDs...
> 
> As I tried to explain in an earlier "braindump" email, we'll support journals
> 
> 1. inside osd data
> 2. on shared ssd as file
> 3. separate block dev (e.g. ssd or raid 2nd lun with different config)
> 
> and find the right journal automagically, by matching uuids. This is
> what I'm working on right now.

See above - finding the journal as a file on a filesystem somewhere might give some problems to auto-detect this specific file.

> 
> 
> 
> Bernard Grymonpon <bernard@openminds.be>:
>> I would suggest you fail the startup of the daemon, as it doesn't have all the needed \
>> parts - I personally don't like these "autodiscover" thingies, you never know why \
>> they are waiting/searching for,...
> 
> If you don't like hotplug, you can disable it.

Same goes the other way - if someone like to start everything automagically, there is nothing that stops others from using the normal hotplug tools available, just write some rules to act on the presence of certain disklabels. 

Ceph can provide scripts to do this, but I would keep this logic out of the default behavior of ceph-osd. In my opinion, this is a storage daemon - not a storage-node-management-daemon.

If you want to keep this outside ceph-osd, and provide this as some helper to the /etc/init.d scripts, then I'm all the way with you, as long as the magic .

In my opinion the config file for ceph should contain only UUIDs for the devices which hold the data, like:

...
[osd]
  uuid=abc-123-123-123
  uuid=def-456-456-456
  uuid=ghi-789-789-789
...

The init.d script helper scans this file, mounts each device, does a consistency check of the data on it (and finds its auth info, internal id, etc...), and starts a osd for this uuid (how the journal is found, is still a mystery ;-)).

If there happens to be another disk with valid ceph data on it, but which should be left alone, simply not specifying the uuid in the config file would prevent it from being started (for all we know, it belongs to a different cluster, in another network/setup/...) on a normal boot. If you plug in a disk with an old dataset on it, you would not want this to happen...

> 
> Having hundreds of machines with ~10 disks each and the data center
> being remote and managed by people you've never seen will probably
> make you like the automation more. Having failed disks turn on an LED,
> ops swapping in a new drive from a dedicated pile of pre-prepared
> spares, and things just.. working.. is the goal.

I would like to know when something happens, and that it happens by my rules and wishes, not what Ceph thinks it should do. (and yes, me and my colleagues manage multiple machines, sitting in a datacenter far-far away). If some part of a setup fails, and needs replacing/maintenance, it is done on my terms, not by random magic.

In my ideal world, I would want my chef (chef, not ceph!) server to have knowledge of all the UUIDs that (might) be used in a certain ceph cluster, and then apply the correct roles to the nodes holding these disks. If the disk is empty, it would be formatted/initialized and added to the cluster. If some other disk is popped in, it should be left alone. On the node itself, that would result in a config file with all the uuids (and some info about the mons).

If someone removes or pops in a disk, what should happen then is up to me. If it starts everything automatically, or if a certain node isn't set to auto-boot, is up to me (and should result in changes in the config in my chef-server, which controls all my nodes). If I want all these UUIDs to auto-start a OSD when inserted, then I would let chef write a rules file in udev to do exactly that.

Rgds,
Bernard

> 
>> Say that we duplicate a node, for some testing/failover/... I would not
>> want to daemon to automatically start, just because the data is there...
> 
> If you do that, just turn hotplug off before you plug the disks in to
> the replica. There's not much you can do with it, though -- starting
> the osds is a no-no, in this case.
> 
> I would argue that random copying of osd data disks or journals is an
> accident waiting to happen. But there's nothing inherent in the design
> to say you can't do that. Just don't do hotplug.
> 
> We can't rely on hotplug working anyway. There will *always* be a
> change for the admin to manually say "hey, here's a new block device
> for you, see if there's something to run there".
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

