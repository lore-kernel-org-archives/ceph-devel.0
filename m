From: Sage Weil <sage@inktank.com>
Subject: v0.48.3 argonaut update released
Date: Tue, 8 Jan 2013 19:30:08 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301081927450.32282@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58765 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787Ab3AIDaI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 22:30:08 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 8F1B88044E
	for <ceph-devel@vger.kernel.org>; Tue,  8 Jan 2013 19:30:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 6AEB18044E
	for <ceph-devel@vger.kernel.org>; Tue,  8 Jan 2013 19:30:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

After several months, we have an important update for the argonaut v0.48.x 
series. This release contains a critical fix that can prevent data loss or 
corruption in a power loss or kernel panic situation. There are also 
several fixes for the OSDs and for the radosgw. We recommend all v0.48.x 
users upgrade.

Notes on upgrading:

 * If you are using the undocumented ceph-disk-prepare and 
   ceph-disk-activate tools, they have several new features and some 
   additional functionality. Please review the changes in behavior 
   carefully before upgrading.
 * The .deb packages now require xfsprogs.

Notable changes since v0.48.2:

 * filestore: fix op_seq write order (fixes journal replay after power 
   loss)
 * osd: fix occasional indefinitely hung slow request
 * osd: fix encoding for pool_snap_info_t when talking to pre-v0.48 
   clients
 * osd: fix heartbeat check
 * osd: reduce log noise about rbd watch
 * log: fixes for deadlocks in the internal logging code
 * log: make log buffer size adjustable
 * init script: fix for ceph status across machines
 * radosgw: fix swift error handling
 * radosgw: fix swift authentication concurrency bug
 * radosgw: dont cache large objects
 * radosgw: fix some memory leaks
 * radosgw: fix timezone conversion on read
 * radosgw: relax date format restrictions
 * radosgw: fix multipart overwrite
 * radosgw: stop processing requests on client disconnect
 * radosgw: avoid adding port to url that already has a port
 * radosgw: fix copy to not override ETAG
 * common: make parsing of ip address lists more forgiving
 * common: fix admin socket compatibility with old protocol (for collectd 
   plugin)
 * mon: drop dup commands on paxos reset
 * mds: fix loner selection for multiclient workloads
 * mds: fix compat bit checks
 * ceph-fuse: fix segfault on startup when keyring is missing
 * ceph-authtool: fix usage
 * ceph-disk-activate: misc backports
 * ceph-disk-prepare: misc backports
 * debian: depend on xfsprogs (we use xfs by default)
 * rpm: build rpms, some related Makefile changes

For more detailed information, see the complete changelog at

	http://ceph.com/docs/master/_downloads/v0.48.3argonaut.txt

You can get v0.48.3 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.48.3argonaut.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian

