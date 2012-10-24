From: Sage Weil <sage@inktank.com>
Subject: libcephfs ceph_shutdown()
Date: Wed, 24 Oct 2012 16:17:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210241614190.13619@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53570 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2JXXRG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 19:17:06 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: noah.watkins@inktank.com, joe.buck@inktank.com
Cc: ceph-devel@vger.kernel.org

I'm annoyed that ceph_shutdown() both unmounts and releases the resource, 
but there is a separate _create() and _mount() method.  I wonder if it 
makes sense to introduce ceph_umount() and ceph_release() and make 
ceph_shutdown() call them (for compatibility).

I thought librados was a bit cleaner, but it appears to be doing the same 
thing.. meh.  (Also, the docs for _shutdown() incorrectly state that 
shutdown isn't needed if rados_connect() fails.. but presumably the 
resource still needs to be freed?)

Is this worth fixing?

sage
