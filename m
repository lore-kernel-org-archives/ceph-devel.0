From: Sage Weil <sage@newdream.net>
Subject: defaults paths
Date: Wed, 4 Apr 2012 23:32:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204042320010.28065@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36877 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab2DEGcl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 02:32:41 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2DE9CBCAF5
	for <ceph-devel@vger.kernel.org>; Wed,  4 Apr 2012 23:32:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 08D59BCAF5
	for <ceph-devel@vger.kernel.org>; Wed,  4 Apr 2012 23:32:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We want to standardize the locations for ceph data directories, configs, 
etc.  We'd also like to allow a single host to run OSDs that participate 
in multiple ceph clusters.  We'd like easy to deal with names (i.e., avoid 
UUIDs if we can).

The metavariables are:
 cluster = ceph (by default)
 type = osd, mon, mds
 id = 1, foo, 
 name = $type.$id = osd.0, mds.a, etc.

The $cluster variable will come from the command line (--cluster foo) or, 
in the case of a udev hotplug tool or something, matching the uuid on the 
device with the 'fsid = <uuid>' line in the available config files found 
in /etc/ceph.

The locations could be:

 ceph config file:
  /etc/ceph/$cluster.conf     (default is thus ceph.conf)

 keyring:
  /etc/ceph/$cluster.keyring  (fallback to /etc/ceph/keyring)

 osd_data, mon_data:
  /var/lib/ceph/$cluster.$name
  /var/lib/ceph/$cluster/$name
  /var/lib/ceph/data/$cluster.$name
  /var/lib/ceph/$type-data/$cluster-$id

TV and I talked about this today, and one thing we want is for items of a 
given type to live together in separate directory so that we don't have to 
do any filtering to, say, get all osd data directories.  This suggests the 
last option (/var/lib/ceph/osd-data/ceph-1, 
/var/lib/ceph/mon-data/ceph-foo, etc.), but it's kind of fugly.

Another option would be to make it

 /var/lib/ceph/$type-data/$id

(with no $cluster) and make users override the default with something that 
includes $cluster (or $fsid, or whatever) in their $cluster.conf if/when 
they want multicluster nodes that don't interfere.  Then we'd get 
/var/lib/ceph/osd-data/1 for non-crazy people, which is pretty easy.

Any other suggestions?  Thoughts?
sage
