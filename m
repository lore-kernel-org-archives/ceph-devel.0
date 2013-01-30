From: Sage Weil <sage@inktank.com>
Subject: v0.56.2 released
Date: Wed, 30 Jan 2013 15:46:42 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301301540030.6225@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56237 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756833Ab3A3Xqn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 18:46:43 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2958F80049
	for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 15:46:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 00ACD80049
	for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 15:46:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The next bobtail point release is ready, and it's looking pretty good. 
This is an important update for the 0.56.x backport series that fixes a 
number of bugs and several performance issues. All v0.56.x users are 
encouraged to upgrade. 

Notable changes since v0.56.1:

 * osd: snapshot trimming fixes
 * osd: scrub snapshot metadata
 * osd: fix osdmap trimming
 * osd: misc peering fixes
 * osd: stop heartbeating with peers if internal threads are stuck/hung
 * osd: PG removal is friendlier to other workloads
 * osd: fix recovery start delay (was causing very slow recovery)
 * osd: fix scheduling of explicitly requested scrubs
 * osd: fix scrub interval config options
 * osd: improve recovery vs client io tuning
 * osd: improve 'slow request' warning detail for better diagnosis
 * osd: default CRUSH map now distributes across hosts, not OSDs
 * osd: fix crash on 32-bit hosts triggered by librbd clients
 * librbd: fix error handling when talking to older OSDs
 * mon: fix a few rare crashes
 * ceph command: ability to easily adjust CRUSH tunables
 * radosgw: object copy does not copy source ACLs
 * rados command: fix omap command usage
 * sysvinit script: set ulimit -n properly on remote hosts
 * msgr: fix narrow race with message queuing
 * fixed compilation on some old distros (e.g., RHEL 5.x)

There are a small number of interface changes related to the default CRUSH 
rule and scrub interval configuration options. Please see the full release 
notes.

You can get v0.56.2 in the usual fashion:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.56.2.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm

