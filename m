From: Sage Weil <sweil@redhat.com>
Subject: hardening ceph build
Date: Wed, 6 May 2015 13:25:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505061321310.31339@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42783 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbbEFUZE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 May 2015 16:25:04 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 734AC8E78A
	for <ceph-devel@vger.kernel.org>; Wed,  6 May 2015 20:25:04 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: siddharth@redhat.com
Cc: ceph-devel@vger.kernel.org, mbroz@redhat.com, branto@redhat.com

Is something like this what we should be doing?

 http://mainisusuallyafunction.blogspot.com/2012/05/automatic-binary-hardening-with.html

Or just -fPIE?  Or ...

I suspect we also wan to do something like --disable-static to halve the 
libtool build times.  Is -fPIC still needed if -fPIE is specified?

Thanks!
sage
