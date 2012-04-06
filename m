From: Bernard Grymonpon <bernard@openminds.be>
Subject: Re: defaults paths #2
Date: Fri, 6 Apr 2012 21:45:34 +0200
Message-ID: <720D7ADB-C3E4-4C5E-B308-216D941FDC83@openminds.be>
References: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com> <9B9005B1-9397-4171-8726-A52903B8B8F1@openminds.be> <CAORUGqD_Oe2F-yTS87h5P8oB=OrUTcuZo7BsWo3bqy66VJ1YfA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from november.openminds.be ([195.47.215.47]:46943 "EHLO
	november.openminds.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605Ab2DFTpg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 15:45:36 -0400
In-Reply-To: <CAORUGqD_Oe2F-yTS87h5P8oB=OrUTcuZo7BsWo3bqy66VJ1YfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


On 06 Apr 2012, at 19:57, Tommi Virtanen wrote:

> On Fri, Apr 6, 2012 at 00:37, Bernard Grymonpon <bernard@openminds.be> wrote:
>> Storage lives by UUID's, I would suggest to move the programming in the direction to get rid of all the own naming and labeling, and just stick to uuids. I could not care less if the data on that disk is internally named "23" or "678", it is just a part of my cluster, and it is up to ceph to figure out which part of the puzzle it holds.
> 
> Ceph storage does not live by UUIDs. Each object is stored in specific
> osds, which are identified by a sequential, dense, unique, integer.
> These integers exist, are allocated and freed, and are the very
> *definition* of an osd.
> 
> UUIDs are useful for ensuring 1. that osd.42 from cluster A is not
> confused with a osd.42 from cluster B (cluster-wide fsid)  2. for
> ensuring we use the right journal for an osd (per-osd uuid, stored in
> both osd data and journal).
> 
> UUIDs are not human friendly, and are not a native identifier in Ceph.
> 
> Here's what running multiple osds looks like with the new upstart stuff:
> 
> ubuntu@inst01:~$ sudo initctl list|grep ceph
> ceph-osd-all stop/waiting
> ceph-mon-all stop/waiting
> ceph-mon (ceph/single) start/running, process 2527
> ceph-osd (ceph/0) start/running, process 2576
> ceph-osd (ceph/1) start/running, process 2580
> ceph-osd (ceph/2) start/running, process 2592
> ceph-osd (ceph/3) start/running, process 3053
> 
> Doing the same with UUIDs would make that output have lines like
> 
> ceph-osd (ceph/1bbb1f49-c574-45b0-b4cc-43dbe7bacc0d) start/running, process 2576
> 
> and I really, really don't want for no gain.
> 
> UUIDs make a lot of sense when you don't have central coordination of
> identifiers. But Ceph *has* that. (It *needs* that, because we don't
> do lookup tables.)

Agreed, it looks nicer, but I would like to get some report about a UUID not being found, which I then can track down to a serial number of a drive/lun/partition/lvm part/... or some other thing. I don't know that ceph/536 is stored on device xyz, without loading ceph magic and checking the effective content of the disk.

Lets go wild, and say, if you have hunderds of machines, summing up to thousands of of disks, all already migrated/moved to other machines/... , and it reports that OSD 536 is offline, how will you find what disk is failing/corrupt/... in which machine? Will you keep track which OSD ran on which node last?

I think of my storage (in ceph) of a stash of harddisks, in random order. If my cluster is made up of 5, then I need 5 disks. 

I was thinking of adding a custom label next to the UUID of a partition/disk/... like "ceph.$clusterid.$id" (or even "ceph.$clusterid.$osd.$id, which might help solve this problem. As such, you would know, without mounting the data, which data you're dealing with.

And I do understand that ceph needs the ids, and it is an cornerstone of the inter workings, but as a sysadmin, that is not my problem. I do drives, each of them holding data. 

> 
>>> I think many people with that hardware setup will choose to just GPT
>>> partition the SSD, and have a lot less code in the way of the IO.
>> A single file, sitting on some partition somewhere, will be very hard to auto-find, unless you'll keep some info in OSD that tracks the UUID of the disk + the path inside the filesystem where it previously was.
> 
> For example: "All the journals that are just files are inside
> /var/lib/ceph/journal, or are symlinked there." And that can even be a
> configurable search path with multiple entries. Not that hard.
> 
> OSD data will not contain a path name to the journal, that is too transient.
> 
>>> I think we agree on intents, but I disagree strongly with the words
>>> you chose. The sysadmin should not need to symlink anything. We will
>>> bring up a whole cluster, and enable you to manage that easily.
>>> Anything less is a failure. You may choose to opt out of some of that
>>> higher smarts, if you want to do it differently, but we will need to
>>> provide that. Managing a big cluster without automation is painful,
>>> and people shouldn't need to reinvent the wheel.
>> 
>> Actually, it will bring up one node of a cluster, regardless of the state of the other parts of the cluster. Question is how automated everything should be detected and started.
>> 
>> Hotplugging and auto-mounting is there already - it is up to the sysadmin to use it if needed.
> 
> The automation I'm working is intended to bring up and manage a *whole
> cluster*. Not a single machine.
> 
> Hotplugging is *not* there already. There is no turn-key
> installs-in-under-60-minutes solution that gives you that.

Yet, chef manages on each run, exactly one node. Either chef will need to have some basic knowledge about the layout (like, where are the monitors, and what is the key), or there needs to be magic on the nodes themself to share this info between good and new nodes.

> 
>> Same goes the other way - if someone like to start everything automagically, there is nothing that stops others from using the normal hotplug tools available, just write some rules to act on the presence of certain disklabels.
> 
> I am writing that logic, right now. For everyone to use. So that
> everyone doesn't need to reinvent the wheel.
> 
>> Ceph can provide scripts to do this, but I would keep this logic out of the default behavior of ceph-osd. In my opinion, this is a storage daemon - not a storage-node-management-daemon.
>> 
>> If you want to keep this outside ceph-osd, and provide this as some helper to the /etc/init.d scripts, then I'm all the way with you, as long as the magic .
> 
> It will all be optional, though you will be encouraged to use the automation.

... and this is where I think I misunderstood you - I assumed this fancy voodoo would go in ceph-osd. 

> 
>> In my opinion the config file for ceph should contain only UUIDs for the devices which hold the data, like:
>> 
>> ...
>> [osd]
>>  uuid=abc-123-123-123
>>  uuid=def-456-456-456
>>  uuid=ghi-789-789-789
>> ...
> 
> We are talking about hundreds of machines and thousands of disks.
> Nobody I've talked to wants to edit a config file to add/replace a
> disk on a system that big, that's just not the way to go.

Editting a json controlled file on a central provisioning server isn't really a daunting task. If you have a cluster of thousands of disks, I hope someone took the time to create a simple script to prepare and add a new drive in the cluster, or replace a failed drive. We would do this with specific recipes in chef. 

Each chef run would pick up the drives available to the system, check their uuid/label if they are known to belong to the cluster (should the mon know this? It knows there was a osd with id 456, part of the cluster...), and write out the configs and start the osds.

Kind regards,
Bernard

> 
>> If someone removes or pops in a disk, what should happen then is up to me. If it starts everything automatically, or if a certain node isn't set to auto-boot, is up to me (and should result in changes in the config in my chef-server, which controls all my nodes). If I want all these UUIDs to auto-start a OSD when inserted, then I would let chef write a rules file in udev to do exactly that.
> 
> It seems you have different enough opinions about how to manage your
> systems that you might choose to not to use the automation I've been
> working on. That's fine, just do it. The core ceph daemons will not
> assume things either way.
> 
> I would recommend you come back in a few months and see what come out
> of the work, you might find it more acceptable than you currently
> think.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

