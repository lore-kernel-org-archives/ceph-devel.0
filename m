From: Sage Weil <sage@inktank.com>
Subject: ceph and systemd
Date: Wed, 7 May 2014 21:36:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405072119170.25032@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55126 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbaEHEgH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 May 2014 00:36:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: rwheeler@redhat.com

Now that the world seems to be converging on systemd, we need to sort out 
a proper strategy for Ceph.  Right now we have both sysvinit (old and 
crufty but functional) and upstart, but neither are especially nice to 
work with.

The first order of business is to identify someone who knows (or is 
motivated to learn) how systemd does things and who can figure out how to 
integrate things nicely.

Here's a quick brain dump:

The main challenge is that, unlike most basic services, we start lots of 
daemons on the same host.  The "new" way we handle that is by enumerating 
them in with directories in /var/lib/ceph.  E.g.,

/var/lib/ceph
	osd/
		ceph-530/
		ceph-14/
		bigcluster-121/
	mon/
		ceph-foo/
	mds/
		bigcluster-foo/

That is, /var/lib/ceph/$type/$cluster-$id/, where $cluster is normally 
'ceph' (and that is all that is supported with sysvinit at the moment).  
The config file is then /etc/ceph/$cluster.conf, logs are 
/var/log/ceph/$cluster-$type.log, and so on.

In each daemon directory, you touch either 'sysvinit' or 'upstart' to 
indicate which init system is responsible for stopping/starting.  Here, 
we'd presumably add 'systemd' to indicate that the new hotness is now 
responsible for managing the daemon.

In the upstart world, which I'm guessing is most like systemd, there are a 
few meta-jobs for ceph-osd-all, ceph-mon-all, ceph-mds-all, and a ceph-all 
meta-job for those, so that everything can be started/stopped together.  
Or, you can start/stop individual daemons with something like

 sudo start ceph-osd id=123 cluster=ceph

For OSDs, things are a bit more complicated because we are wired into udev 
to automatically mount the file systems and to make things more plug and 
play.  The basic strategy is this:

 - we partition disks with GPT
 - we use fixed GPT partition types UUIDs to mark osd data volumes and osd 
   journals.
 - udev rules trigger 'ceph-disk activate $device' for osd data or 
   'ceph-disk activate-journal $device' for osd journals.
 - ceph-disk mounts the device at /var/lib/ceph/tmp/something, identifies 
   what cluster and osd id it belongs to, bind-mounts that to the correct 
   /var/lib/ceph/osd/* location, and then starts the daemon with whatever 
   init system is indicated.  There's a bunch of other logic to make sure 
   that journals are also mounted, or to start up dm-crypt if enabled, and 
   so on.

At the end of the day, it means that there's no configuration needed in 
fstab or ceph.conf.  You can simply plug (marked) drives into a machine 
and they will get formatted, provisioned, and added into the cluster in 
the correct location in the CRUSH map.  Or, you can pull a disk from one 
box and plug it into another and it will join back into the cluster 
(provided both the data and journal are present).

Anyway, the first order of business is to find someone who is 
systemd-savvy...

sage
