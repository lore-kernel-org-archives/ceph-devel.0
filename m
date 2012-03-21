From: Sage Weil <sage@newdream.net>
Subject: v0.44 released
Date: Wed, 21 Mar 2012 06:39:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203210638450.28797@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32891 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab2CUNjw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 09:39:52 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7F3F8BC802
	for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 06:39:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 27979BC802
	for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 06:39:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

v0.44 is ready!  Changes since v0.43 include:

 * osd: key/value objects (objects are now blobs, key/value bundles, and 
   xattrs)
 * osd: cleaned up PG state, stats
 * osd: fixed transaction replay on non-btrfs after ill-timed failures
 * osd: several recovery fixes
 * radosgw: improved PUT performance
 * radosgw: improved list objects performance, filtering
 * radosgw: manifests for large objects
 * radosgw: Swift/S3 ACL interoperability (last set ACL type wins)
 * librados: new key/value object API
 * Ubuntu 12.04 precise packages

The exciting part of this release is that the key/value "object map"  
work has been merged, along with radosgw changes to take advantage of the 
new API.  This allows you to use a key/value interface to manage many 
small records in a single object, in addition of the regular object data 
and attributes.  Keys in the same object are stored together on disk--just 
like object data would be--so there are locality advantages to putting 
related keys in the same object.  However, there are no limits on how many 
keys per object beyond concerns about load and space balancing (all keys 
in an object are stored together on the same set of Ceph OSDs).  This 
provides an interesting alternative to conventional distributed key/value 
stores like Cassandra that distribute all keys in a single namespace 
across all nodes.  For example, radosgw now uses the new object map API to 
manage the index object for each bucket.

For v0.45, we're continuing work on RBD caching, performance and bug 
fixes, and working around xattr size limitations in ext3/4.

You can get v0.44 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.newdream.net/download/ceph-0.44.tar.gz
 * For Debian/Ubuntu packages, see 
   http://ceph.newdream.net/docs/master/ops/install/mkcephfs/#installing-the-packages
 
