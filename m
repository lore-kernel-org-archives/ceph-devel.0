From: Sage Weil <sage@inktank.com>
Subject: parent xattrs on file objects
Date: Tue, 16 Oct 2012 14:17:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210161410490.5344@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60296 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab2JPVRD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Oct 2012 17:17:03 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C0C378044B
	for <ceph-devel@vger.kernel.org>; Tue, 16 Oct 2012 14:17:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9A84E8044B
	for <ceph-devel@vger.kernel.org>; Tue, 16 Oct 2012 14:17:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey-

One of the design goals of the ceph fs was to keep metadata separate from 
data.  This means, among other things, that when a client is creating a 
bunch of files, it creates the inode via the mds and writes the file data 
to the OSD, but no mds->osd interaction is necessary.

One of the challenges we currently have is that it is difficult to lookup 
an inode by ino.  Normally clients traverse the hierarchy to get there, so 
things are fine for native ceph clients, but when reexporting via NFS we 
can get ESTALE because we an ancient nfs file handle can be presented and 
the ceph MDS won't know where to find it.  We have a similar problem with 
the fsck design in that it is not always possible to discover orphaned 
children of directory that was somehow lost.

One option is to put an ancestor xattr on the first object for each file, 
similar to what we do for directories.  This basically means that each 
file creation will be followed (eventually) by a setxattr osd operation.  
This used to scare me, but now it's seeming like a pretty small price to 
pay for robust NFS reexport and additional information for fsck to 
utilize.

It's also nice because it means we could get rid of the anchor table (used 
for locating files with multiple hard links) entirely and use the 
ancestore xattrs instead.  That means one less thing to fsck, and avoids 
having to invest any time in making the anchor table effectively scale (it 
currently doesn't).

Anyone feel like we shouldn't go ahead and do this?

sage
