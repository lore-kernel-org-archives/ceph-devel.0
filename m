From: Sage Weil <sweil@redhat.com>
Subject: jewel punch list
Date: Mon, 18 Apr 2016 15:57:28 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604181448220.4803@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49664 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701AbcDRT5c (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Apr 2016 15:57:32 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F15C73B70A
	for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 19:57:26 +0000 (UTC)
Received: from cpach ([10.3.112.6])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3IJvOJd019332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 15:57:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I think we're in good shape.  Assuming the qa/workunit bit is fixed (let's 
do a rados run as soon as master builds), are we good for the 10.2.0 
release?  There is still the rgw leak, so please merge the parts that are 
safe and we'll backport any follow-on fixes.

There is also one selinux issue (http://tracker.ceph.com/issues/15524) 
that we need to take care of before this goes out.  Yuri, are there other 
outstanding issues that we haven't addressed yet?

Those items aside, can the leads and QA please ACK for a release?

Thanks!
sage
