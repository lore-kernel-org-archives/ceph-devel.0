From: Sage Weil <sage@newdream.net>
Subject: v0.22.1 released
Date: Sat, 23 Oct 2010 20:35:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010221640190.25786@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43466 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab0JXDcf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Oct 2010 23:32:35 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 99A77BC717
	for <ceph-devel@vger.kernel.org>; Sat, 23 Oct 2010 20:35:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5F4C4BC717
	for <ceph-devel@vger.kernel.org>; Sat, 23 Oct 2010 20:35:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This release fixes a few critical bugs in v0.22:

  * osd: fix hang during mkfs journal creation
  * objecter: fix rare hang during shutdown
  * msgr: fix reconnect/disconnect errors due to timeouts
  * init-ceph: check for correct instance in daemon_is_running()
  * filestore: deliberate crash on ENOSPC or EIO to avoid corruption
  * filestore: split xattrs into chunk (partial workaround for xattr size 
    limitations) 
  * filestore: ignore ENOSPC on xattrs until workaround for extN is 
    implemented
  * radosgw: return 204 on removal of bucket/object

The main issue was the messenger bug, which causes internal cluster 
messages to be dropped and triggered random cosd crashes.  The ENOSPC/EIO 
issue is also a bit strange: previously we silently ignored these errors.  
Now we crash to avoid corrupting our data with partially committing 
transaction, except in the case where we are trying to set a large xattr.  
The problem here is that both btrfs have size limitations we hadn't 
noticed before, btrfs on an individual xattr, and extN on the total size 
of all xattrs.  We will continue to ignore errors on extN (aside from 
logging them) until we implement a workaround.

Relevant URLs:
  * Direct download at: http://ceph.newdream.net/download/ceph-0.22.1.tar.gz
  * For Debian packages, see http://ceph.newdream.net/wiki/Debian

sage
