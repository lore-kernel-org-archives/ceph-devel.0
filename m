From: John Spray <jspray@redhat.com>
Subject: Re: CephFS usability
Date: Thu, 21 Jul 2016 16:03:41 +0100
Message-ID: <CALe9h7fsfS44PWUpXut5aF9HBN2Jd9dbpA7UvUJN0w872HqJzg@mail.gmail.com>
References: <CALe9h7c3Mt958UhVEJdCYgKb4Cz6Gg2Gk4iz5JR9E-jtOnS=Xw@mail.gmail.com>
 <CA+9C14bCjV+c7iM3ZjiZffQ8D211qHgAQ0cCadxQs49JWXHg3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32867 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbcGUPED (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 11:04:03 -0400
Received: by mail-qk0-f180.google.com with SMTP id p74so76184712qka.0
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2016 08:04:01 -0700 (PDT)
In-Reply-To: <CA+9C14bCjV+c7iM3ZjiZffQ8D211qHgAQ0cCadxQs49JWXHg3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Eastman <eric.eastman@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jul 21, 2016 at 3:33 PM, Eric Eastman
<eric.eastman@keepertech.com> wrote:
> I have been playing with CephFS since before Firefly and I am now
> trying to put it into production. You listed a lot of good ideas, but
> many of them would seem to help developers and those trying to get the
> absolute best performance out of CephFS, more then helping day to day
> administration or using CephFS in a typical environment.  The three
> things I really need are:
>
> 1. Documentation.  The documents for administrating CephFS on the Ceph
> site and the man pages are incomplete.  As an example, having to open
> a ticket to find the magic options to get ACL support on a FUSE mount
> (see ticket #15783) is very inefficient for both the end user and the
> Ceph engineers. There are a huge number of mount options between
> kernel and FUSE mounts with very little explanation of what they do
> and what are the performance costs of using them.  The new CAP
> protections are great, if you can figure them out.  Same goes for the
> new recovery tools.
>
> 2. Snapshots.  Without snapshots I cannot put the file system it into
> production in all my use cases.
>
> 3. Full support for the SAMBA and Ganesha CephFS modules, including
> HA.  Although these modules are not owned by the Ceph team, they need
> to be solid to use CephFS at a lot of sites. The GlusterFS team seems
> to be doing a lot of work on these interfaces, and it would be nice if
> that work was also being done for Ceph.
>
> To make CephFS easier to use in the field, I would really like to see
> the base functionality well supported and documented before focusing
> on new things. Thank you for everything you are doing.

Let me clarify a bit: this isn't about prioritising usability work vs.
anything else, it's about gathering a list of tasks so that we have a
good to-do list when folks are working in that area.  There
increasingly many people working on CephFS (hooray!), so it has become
more important to have a nicely primed queue of work on lots of
different fronts so that we can work on these parallel.

Documentation is an ongoing issue in most projects (especially open
source).  The challenge in getting a big overhaul of the docs is that
most vendors have their own downstream/product documentation, which
can leave the upstream documentation a bit less loved than we would
like.  I steer people towards contributing to the upstream
documentation wherever possible.

Snapshots and Samba/NFS are of course full blown features rather than
usability items.  There is work going on on all of these (Zheng
recently made lots of snapshot fixes, a ganesha engineer is currently
working on building NFS-ganesha into our continuous integration).

John







> Eric Eastman
>
> On Thu, Jul 21, 2016 at 6:11 AM, John Spray <jspray@redhat.com> wrote:
>> Dear list,
>>
>> I'm collecting ideas for making CephFS easier to use.  This list
>> includes some preexisting stuff, as well as some recent ideas from
>> people working on the code.  I'm looking for feedback on what's here,
>> and any extra ideas people have.
>>
>> Some of the items here are dependent on ceph-mgr (like the enhanced
>> status views, client statistics), some aren't.  The general theme is
>> to make things less arcane, and make the state of the system easier to
>> understand.
>>
>> Please share your thoughts.
>>
>> Cheers,
>> John
>>
>>
>> Simpler kernel client setup
>>  * allow mount.ceph to use the same keyring file that the FUSE client
>> uses, instead of requiring users to strip the secret out of that file
>> manually. (http://tracker.ceph.com/issues/16656)
>>
>> Simpler multi-fs use from ceph-fuse
>>  * A nicer syntax than having to pass --client_mds_namespace
>>  * A way to specify the chosen filesystem in fstab
>>
>> Mount-less administrative shell/commands:
>>  * A lightweight python shell enabling admins to manipulate their
>> filesystem without a full blown client mount
>>  * Friendlier commands than current setxattr syntax for layouts and quotas
>>  * Enable administrators to inspect the filesystem (ls, cd, stat, etc)
>>  * Enable administrators to configure things like directories for
>> users with quotas, mapping directories to pools
>>
>> CephFS daemon/recovery status view:
>>  * Currently we see the text status of replay/clientreplay etc in "ceph status"
>>  * A more detailed "ceph fs status" view that breaks down each MDS
>> daemon's state
>>  * What we'd really like to see in these modes is progress (% of
>> segments replayed, % of clients replayed, % of clients reconnected)
>> and timing information (e.g. in reconnect, something like "waiting for
>> 1 client for another 30 seconds")
>>  * Maybe also display some other high level perf stats per-MDS like
>> client requests per second within this view.
>>
>> CephFS full system dstat-like view
>>  * Currently have "daemonperf mds.<foo>" asok mechanism, which is
>> local to one MDS and does not give OSD statistics
>>  * Add a "ceph fs perf" command that fuses multi-mds data with OSD
>> data to give users a single view of the level of metadata and data IO
>> across the system
>>
>> Client statistics
>>  * Implement the "live performance probes" mechanism
>> http://tracker.ceph.com/projects/ceph/wiki/Live_Performance_Probes
>>  * This is the same infrastructure as would be used for e.g. "rbd top"
>> image listing.
>>  * Initially could just be a "client top" view with 5-10 key stats per
>> client, where we collect data for the busiest 10-20 clients (on modest
>> size systems this likely to be all clients in practice)
>>  * Full feature would have per-path filtering, so that admin could say
>> "which subtree is busy?  OK, which client is busy within that
>> subtree?".
>>
>> Orchestrated backward scrub (aka cephfs-data-scan, #12143):
>>  * Wrap it in a central CLI that runs a pool of workers
>>  * Those workers could be embedded in standby mgrs, in standby mdss,
>> or standalone
>>  * Need a work queue type mechanism, probably via RADOS objects.
>>  * This is http://tracker.ceph.com/issues/12143
>>
>> Single command hard client eviction:
>>  * Wrap the process of blacklisting a client *and* evicting it from
>> all MDS daemons
>>  * Similar procedure currently done in CephFSVolumeClient.evict
>>  * This is http://tracker.ceph.com/issues/9754
>>
>> Simplified client auth caps creation:
>>  * Wrap the process of creating a client identify that has just the
>> right MDS+OSD capabilities for accessing a particular filesystem
>> ("ceph fs authorize client.foo" instead of "ceph auth get-or-create
>> ... ..."
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
