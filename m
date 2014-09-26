From: Sage Weil <sweil@redhat.com>
Subject: storlets
Date: Fri, 26 Sep 2014 06:43:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409260641260.30637@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47980 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbaIZNnj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Sep 2014 09:43:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: yehuda@inktank.com

http://domino.research.ibm.com/library/cyberdig.nsf/papers/7233ABCCEC84F0BF85257D3100559FD6/$File/H-0320.pdf
http://researchweb.watson.ibm.com/haifa/projects/storage/datastores/papers/StorletEnginePaper_CameraReady.pdf

This is similar in concept to rados classes for the zerovm stuff, done in 
the context of swift.  It would be great to create a model for doing 
this sort of computation with RGW that takes advantage of rados classes 
where possible.  It's tricky because we're striping data...

sage

