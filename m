From: Sage Weil <sage@inktank.com>
Subject: v0.68 released
Date: Wed, 4 Sep 2013 11:32:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309041131130.2327@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47726 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab3IDScw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Sep 2013 14:32:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

Our first development release after Dumpling has arrived! It includes a 
lot of small cleanups and documentation improvements, as well as the first 
blueprint from the Emperor CDS to land (support for ZFS). There are also 
new sample implementations for RADOS classes (cls_hello) and a sample 
librados application (hello_world) to help developers and users get 
started.

Notable changes since v0.67:

 * ceph-fuse: fix problem with readahead vs truncate race (Yan, Zheng)
 * ceph-post-file: new command to easily share logs or other files with 
   ceph devs
 * ceph: parse CEPH_ARGS env variable
 * librados: fix async aio completion wakeup
 * librados: hello_world example (Greg Farnum)
 * librados: sync calls now return on commit (instead of ack) (Greg 
   Farnum)
 * mds: fix mds rejoin with legacy parent backpointer xattrs (Alexandre 
   Oliva)
 * mds: fix rare restart/failure race during fs creation
 * mds: notify clients about deleted files (so they can release from their 
   cache) (Yan, Zheng)
 * mds: several bug fixes with clustered mds (Yan, Zheng)
 * mon: allow logging level of cluster log (/var/log/ceph/ceph.log) to be 
   adjusted
 * mon: do not expose uncommitted state from 'osd crush {add,set} ...' 
   (Joao Luis)
 * mon: fix byte counts (off by factor of 4) (Dan Mick, Joao Luis)
 * mon: fix paxos corner case
 * mon: modify 'auth add' semantics to make a bit more sense (Joao Luis)
 * mon: new 'osd perf' command to dump recent performance information 
   (Samuel Just)
 * mon: new and improved 'ceph -s' or 'ceph status' command (more info, 
   easier to read)
 * monc: fix small memory leak
 * new wireshark patches pulled into the tree (Kevin Jones)
 * objecter: fix possible hang when cluster is unpaused (Josh Durgin)
 * osd: 'osd recover clone overlap limit' option to limit cloning during 
   recovery (Samuel Just)
 * osd: cls_hello OSD class example
 * osd: experiemental support for ZFS (zfsonlinux.org) (Yan, Zheng)
 * osd: instrument peering states (David Zafman)
 * osd: properly enforce RD/WR flags for rados classes
 * osd: remove old pg log on upgrade (Samuel Just)
 * rgw: complete in-progress requests before shutting down
 * rgw: fix S3 auth with response-* query string params (Sylvain Munaut, 
   Yehuda Sadeh)
 * sysvinit: add condrestart command (Dan van der Ster)

For more information please refer to the complete release notes:

 * http://ceph.com/docs/master/release-notes/#v0-68

Meanwhile, the v0.69 development has just gone into feature freeze and 
includes some preliminary infrastructure and groundwork for the RADOS 
tiering functionality (initially, cache pools).

You can get v0.68 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.68.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
