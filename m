From: Sage Weil <sage@inktank.com>
Subject: crush create-or-move
Date: Tue, 11 Sep 2012 09:09:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209110831260.1305@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40302 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab2IKQJh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 12:09:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tv@inktank.com
Cc: ceph-devel@vger.kernel.org

Hey Tommi-

I pushed a wip-crush branch that implements 'ceph osd crush create-or-move 
...'.  I don't think it's worth backporting this to argonaut, since the 
user is actually in the deploy scripts, so any chef/juju/whatever won't 
care if they're running against argonaut or bobtail in this case.  
(Right?)  (It also depends on a bunch of option parsing cleanups that I'd 
rather not wade through.)

sage
