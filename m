From: Zhi Zhang <zhang.david2011@gmail.com>
Subject: Re: CephFS usability
Date: Mon, 25 Jul 2016 13:40:14 +0800
Message-ID: <CAGkCoNJuoEx9OkW9e0UdDdmo=Vp6+RTc7dhSqK+nH6OubDsq+w@mail.gmail.com>
References: <CALe9h7c3Mt958UhVEJdCYgKb4Cz6Gg2Gk4iz5JR9E-jtOnS=Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:32856 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbcGYFkz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jul 2016 01:40:55 -0400
Received: by mail-vk0-f41.google.com with SMTP id x130so230002926vkc.0
        for <ceph-devel@vger.kernel.org>; Sun, 24 Jul 2016 22:40:54 -0700 (PDT)
In-Reply-To: <CALe9h7c3Mt958UhVEJdCYgKb4Cz6Gg2Gk4iz5JR9E-jtOnS=Xw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi John,

Thanks for sharing CephFS to-do list to us. It could make CephFS users
to better know the forward direction of CephFS. We have worked on
kernel CephFS for more than 1 year and already put it on production to
server some user scenarios. We are planning to adopt kernel CephFS to
server more our users.

Here are 3 items from my past experience on kernel CephFS. I think
they could make CephFS more easier and faster to adopt.

1. Backport fixes from higher kernel version to standard linux
distribution's kernel
* Current most of linux distribution's kernel is still 3.10.x. Kernel
CephFS has some functional and stability issues on 3.10.x even on the
latest 3.10.101. And AFAIK, some companies including mine, don't allow
to upgrading kernel to 4.x easily. So I have to backport nearly 3+
years' fixes into 3.10.x gradually and also deal with fixing's
incompatible issue among different kernel. It costs lots of time and
effort to backport, test and verify them, but the benefit is obvious
that kernel CephFS becomes quite stable and well-performed for us. So
I think if we can try to backport each fixing to lower kernel version
when it is committed, it could save lots of effort and make things
much more easier.

2. Differentiate log's level
* Currently ceph's kernel modules have very few log levels. Once we
enable the logs to reproduce some performance or stability bugs, the
whole system might hang because of log flood, so I have to add logs by
myself on critical path. If we can differentiate log's level, I think
it could benefit and help developers.

3. Limited quota support on kernel CephFS
* I know implementing quota support on kernel CephFS like Ceph-fuse is
quite difficult. What I mention here is a sort of idea to see whether
there is any possibility we can work on to limit the file number per
directory at least. We are facing such issue that one directory may
contain millions of files.

Thank you for everything you have done to CephFS.

Regards,
Zhi Zhang (David)
Contact: zhang.david2011@gmail.com
              zhangz.david@outlook.com


On Thu, Jul 21, 2016 at 8:11 PM, John Spray <jspray@redhat.com> wrote:
> Dear list,
>
> I'm collecting ideas for making CephFS easier to use.  This list
> includes some preexisting stuff, as well as some recent ideas from
> people working on the code.  I'm looking for feedback on what's here,
> and any extra ideas people have.
>
> Some of the items here are dependent on ceph-mgr (like the enhanced
> status views, client statistics), some aren't.  The general theme is
> to make things less arcane, and make the state of the system easier to
> understand.
>
> Please share your thoughts.
>
> Cheers,
> John
>
>
> Simpler kernel client setup
>  * allow mount.ceph to use the same keyring file that the FUSE client
> uses, instead of requiring users to strip the secret out of that file
> manually. (http://tracker.ceph.com/issues/16656)
>
> Simpler multi-fs use from ceph-fuse
>  * A nicer syntax than having to pass --client_mds_namespace
>  * A way to specify the chosen filesystem in fstab
>
> Mount-less administrative shell/commands:
>  * A lightweight python shell enabling admins to manipulate their
> filesystem without a full blown client mount
>  * Friendlier commands than current setxattr syntax for layouts and quotas
>  * Enable administrators to inspect the filesystem (ls, cd, stat, etc)
>  * Enable administrators to configure things like directories for
> users with quotas, mapping directories to pools
>
> CephFS daemon/recovery status view:
>  * Currently we see the text status of replay/clientreplay etc in "ceph status"
>  * A more detailed "ceph fs status" view that breaks down each MDS
> daemon's state
>  * What we'd really like to see in these modes is progress (% of
> segments replayed, % of clients replayed, % of clients reconnected)
> and timing information (e.g. in reconnect, something like "waiting for
> 1 client for another 30 seconds")
>  * Maybe also display some other high level perf stats per-MDS like
> client requests per second within this view.
>
> CephFS full system dstat-like view
>  * Currently have "daemonperf mds.<foo>" asok mechanism, which is
> local to one MDS and does not give OSD statistics
>  * Add a "ceph fs perf" command that fuses multi-mds data with OSD
> data to give users a single view of the level of metadata and data IO
> across the system
>
> Client statistics
>  * Implement the "live performance probes" mechanism
> http://tracker.ceph.com/projects/ceph/wiki/Live_Performance_Probes
>  * This is the same infrastructure as would be used for e.g. "rbd top"
> image listing.
>  * Initially could just be a "client top" view with 5-10 key stats per
> client, where we collect data for the busiest 10-20 clients (on modest
> size systems this likely to be all clients in practice)
>  * Full feature would have per-path filtering, so that admin could say
> "which subtree is busy?  OK, which client is busy within that
> subtree?".
>
> Orchestrated backward scrub (aka cephfs-data-scan, #12143):
>  * Wrap it in a central CLI that runs a pool of workers
>  * Those workers could be embedded in standby mgrs, in standby mdss,
> or standalone
>  * Need a work queue type mechanism, probably via RADOS objects.
>  * This is http://tracker.ceph.com/issues/12143
>
> Single command hard client eviction:
>  * Wrap the process of blacklisting a client *and* evicting it from
> all MDS daemons
>  * Similar procedure currently done in CephFSVolumeClient.evict
>  * This is http://tracker.ceph.com/issues/9754
>
> Simplified client auth caps creation:
>  * Wrap the process of creating a client identify that has just the
> right MDS+OSD capabilities for accessing a particular filesystem
> ("ceph fs authorize client.foo" instead of "ceph auth get-or-create
> ... ..."
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
