From: Sage Weil <sweil@redhat.com>
Subject: reducing buffer allocations
Date: Thu, 4 Feb 2016 17:33:06 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602041730260.28396@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60776 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757083AbcBDWcv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Feb 2016 17:32:51 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 9974391351
	for <ceph-devel@vger.kernel.org>; Thu,  4 Feb 2016 22:32:50 +0000 (UTC)
Received: from cpach (ovpn-112-45.phx2.redhat.com [10.3.112.45])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u14MWmaI010845
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Thu, 4 Feb 2016 17:32:50 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

https://github.com/ceph/ceph/pull/5534

does two things: (1) combine the buffer::raw reference count and buffer 
into a single allocation (ala make_shared), and (2) convert buffer::list 
into an intrusive_list, while embedding N (=3) buffer::ptr's in the 
buffer::raw so that most buffers require only 1 allocation (provided they 
aren't on more than N lists).

This needs a rebase, and some benchmarking.  But before I pull it up, is 
this the right direction?  I saw little benefit from (2) after doing 
(1), but I was doing a really simple microbenchmark.  Do we want both, or 
just 1, or is there an alternative we should consider?

sage
