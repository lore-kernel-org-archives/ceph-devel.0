From: Sage Weil <sage@inktank.com>
Subject: v0.52 released
Date: Thu, 27 Sep 2012 13:07:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209271306120.13352@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43056 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320Ab2I0UHI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 16:07:08 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B86EC81355
	for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 13:07:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 8A36880439
	for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 13:07:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

After several weeks of testing v0.52 is ready! This is a big release for 
RBD and radosgw users. Highlights include:

 * librbd: fully functional and documented image cloning
 * librbd: image (advisory) locking
 * librbd: 'protect'/'unprotect' commands to prevent clone parent from 
   being deleted
 * librbd: 'flatten' command to sever clone parent relationship
 * librbd: a few fixes to 'discard' support
 * osd: several out of order reply bug fixes
 * msgr: improved failure handling code
 * auth: expanded authentication settings for greater flexibility
 * mon: 'report' command for dumping detailed cluster status
 * mon: throttle client messages (limit memory consumption)
 * mon: more informative info about stuck PGs in 'health detail'
 * osd, mon: use feature bits to lock out clients lacking CRUSH tunables 
   when they are in use
 * radosgw: support for swift manifest objects
 * radosgw: support for multi-object deletes
 * radosgw: improved garbage collection framework
 * rados: bench command now cleans up after itself
 * ceph.spec: misc packaging fixes

The big news in this release is that the new RBD cloning functionality is 
fully in place. This includes the ability to take a base image (snapshot) 
and instantly 'clone' it to other images. The typical use case is cloning 
a base OS install image for each VM, allowing you to immediately boot them 
up without waiting for any data to copy. RBD also got advisory locking 
support, which allows users to (cooperatively) control who is using each 
image and avoid situations where multiple hosts write to the same image 
and corrupt the file system. There is additional integration work on the 
roadmap that will make this easier to use, but all of the pieces are in 
place for users to starting taking advantage of it now.

This release also includes several improvements to the radosgw. On the 
user-facing API side this includes support for Swift 'manifest' objects 
(large objects uploaded in pieces) and support for multi-object delete. On 
the administrative side, there is a new garbage collection framework that 
makes the cleanup of deleted objects transparent, automatic, and 
efficient. (Currently a radosgw-admin command run from something like cron 
is necessary to clear out old data.)

On the release side, this is also the first release for which we are 
building RPMs. Hooray! We're starting with just CentOS6/RHEL6 and Fedora 
17 on x86_64, but will be adding additional distributions for v0.53, 
including OpenSUSE and Fedora 18. If there is a particular RPM-based 
distro that you'd like to see us build packages for, please let us know!

You can get v0.52 from:
 * Git at git://github.com/ceph/ceph.git
 * Tarball athttp://ceph.com/download/ceph-0.52.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
