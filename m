From: Chris Dunlop <chris@onthe.net.au>
Subject: Improve mount.ceph.8
Date: Wed, 2 Feb 2011 06:02:10 +0000 (UTC)
Message-ID: <slrnikhsr3.4fo.chris@chris.onthe.net.au>
Reply-To: chris@onthe.net.au
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:53588 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377Ab1BBGCc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 2 Feb 2011 01:02:32 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1PkVnP-00020I-4Z
	for ceph-devel@vger.kernel.org; Wed, 02 Feb 2011 07:02:27 +0100
Received: from 180.148.179.26 ([180.148.179.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 02 Feb 2011 07:02:27 +0100
Received: from chris by 180.148.179.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 02 Feb 2011 07:02:27 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Seeing as I was wondering what "rbytes" might be, I guess others might
too...

diff --git a/man/mount.ceph.8 b/man/mount.ceph.8
index d5fe62a..f2cdd86 100644
--- a/man/mount.ceph.8
+++ b/man/mount.ceph.8
@@ -129,12 +129,12 @@ no funky `cat dirname` for stats
 
 rbytes
 .IP
-Report rbytes for st_size on directories.  Default: on
+Report the recursive size of the directory contents for st_size on directories.  Default: on
 .PP
 
 norbytes
 .IP
-Do not report rbytse for st_size.
+Do not report the recursive size of the directory contents for st_size on directories.
 .PP
 
 nocrc

