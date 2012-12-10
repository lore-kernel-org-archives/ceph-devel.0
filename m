From: Sage Weil <sage@inktank.com>
Subject: mounting fuse from fstab
Date: Mon, 10 Dec 2012 12:33:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212101229540.28411@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38593 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab2LJUdT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 15:33:19 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A9947800BA
	for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 12:33:18 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7CB85800BA
	for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 12:33:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We put together a simple helper script for mounting ceph-fuse via fstab 
(below).  Some of man pages indicate that the # syntax is deprecated, 
however, and it's not clear to me that whatever replaces it (mount.fuse) 
will let us accomplish the same thing (pass something along the mount, 
control command line options).  Also, it's unclear *when* it was 
deprecated; if we want this to work on, say, RHEL, the replacement 
might not be there.

Anybody know if doing something like the below is a bad idea?

Thanks!
sage

---

#!/bin/sh
#
# Helper to mount ceph-fuse from /etc/fstab.  To use, add an entry
# like:
#
# # DEVICE                     PATH         TYPE   OPTIONS
# /sbin/ceph-fuse-mount#admin  /mnt/ceph    ceph   defaults   0 0
#
# where 'admin' can be replaced with the client id to use when
# authenticating (if it is not client.admin).  This will also control
# which section of ceph.conf will be applied to the ceph-fuse process.

set -e
id="$1"
shift
exec ceph-fuse -i $id $@


