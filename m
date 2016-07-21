From: John Spray <jspray@redhat.com>
Subject: CephFS usability
Date: Thu, 21 Jul 2016 13:11:17 +0100
Message-ID: <CALe9h7c3Mt958UhVEJdCYgKb4Cz6Gg2Gk4iz5JR9E-jtOnS=Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33872 "EHLO
	mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbcGUMLi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 08:11:38 -0400
Received: by mail-qt0-f182.google.com with SMTP id u25so42454491qtb.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2016 05:11:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Dear list,

I'm collecting ideas for making CephFS easier to use.  This list
includes some preexisting stuff, as well as some recent ideas from
people working on the code.  I'm looking for feedback on what's here,
and any extra ideas people have.

Some of the items here are dependent on ceph-mgr (like the enhanced
status views, client statistics), some aren't.  The general theme is
to make things less arcane, and make the state of the system easier to
understand.

Please share your thoughts.

Cheers,
John


Simpler kernel client setup
 * allow mount.ceph to use the same keyring file that the FUSE client
uses, instead of requiring users to strip the secret out of that file
manually. (http://tracker.ceph.com/issues/16656)

Simpler multi-fs use from ceph-fuse
 * A nicer syntax than having to pass --client_mds_namespace
 * A way to specify the chosen filesystem in fstab

Mount-less administrative shell/commands:
 * A lightweight python shell enabling admins to manipulate their
filesystem without a full blown client mount
 * Friendlier commands than current setxattr syntax for layouts and quotas
 * Enable administrators to inspect the filesystem (ls, cd, stat, etc)
 * Enable administrators to configure things like directories for
users with quotas, mapping directories to pools

CephFS daemon/recovery status view:
 * Currently we see the text status of replay/clientreplay etc in "ceph status"
 * A more detailed "ceph fs status" view that breaks down each MDS
daemon's state
 * What we'd really like to see in these modes is progress (% of
segments replayed, % of clients replayed, % of clients reconnected)
and timing information (e.g. in reconnect, something like "waiting for
1 client for another 30 seconds")
 * Maybe also display some other high level perf stats per-MDS like
client requests per second within this view.

CephFS full system dstat-like view
 * Currently have "daemonperf mds.<foo>" asok mechanism, which is
local to one MDS and does not give OSD statistics
 * Add a "ceph fs perf" command that fuses multi-mds data with OSD
data to give users a single view of the level of metadata and data IO
across the system

Client statistics
 * Implement the "live performance probes" mechanism
http://tracker.ceph.com/projects/ceph/wiki/Live_Performance_Probes
 * This is the same infrastructure as would be used for e.g. "rbd top"
image listing.
 * Initially could just be a "client top" view with 5-10 key stats per
client, where we collect data for the busiest 10-20 clients (on modest
size systems this likely to be all clients in practice)
 * Full feature would have per-path filtering, so that admin could say
"which subtree is busy?  OK, which client is busy within that
subtree?".

Orchestrated backward scrub (aka cephfs-data-scan, #12143):
 * Wrap it in a central CLI that runs a pool of workers
 * Those workers could be embedded in standby mgrs, in standby mdss,
or standalone
 * Need a work queue type mechanism, probably via RADOS objects.
 * This is http://tracker.ceph.com/issues/12143

Single command hard client eviction:
 * Wrap the process of blacklisting a client *and* evicting it from
all MDS daemons
 * Similar procedure currently done in CephFSVolumeClient.evict
 * This is http://tracker.ceph.com/issues/9754

Simplified client auth caps creation:
 * Wrap the process of creating a client identify that has just the
right MDS+OSD capabilities for accessing a particular filesystem
("ceph fs authorize client.foo" instead of "ceph auth get-or-create
... ..."
