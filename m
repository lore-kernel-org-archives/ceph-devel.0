From: Sage Weil <sage@inktank.com>
Subject: firefly backports
Date: Fri, 1 Aug 2014 18:00:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408011756300.1270@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44631 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbaHBBAu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 21:00:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sam.just@inktank.com, yehuda@inktank.com, ceph-devel@vger.kernel.org

Sam, Yehuda,

I backported a ton of pending stuff to firefly-next.  A bunch of it was 
the cephtool tests and unwinding it from the mds cli changes.  Also did 
ceph df writeable space (with fix).

I didn't do some of the core OSD stuff, though, namely

 8438 ec objeccts are not cleaned up
 8701 scrub found obsolete rollback object
 7999 pgs share info that isn't persisted
 8733 crash in ECBackend::handle_sub_read

Those are the 'pending backport' bugs at least; I suspect there are other 
OSD fixes that should be included.

I also didn't do any of the rgw patches, or the s3-tests.

Can you take a look at some point and put them in firefly-next?  I'd like 
to get this point going through the firefly suite soon so that it bakes 
there for as long as possible before the next point release.

Thanks!
sage
