From: Sage Weil <sweil@redhat.com>
Subject: jewel selinux failures
Date: Sat, 30 Apr 2016 21:32:13 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604302131300.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50619 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbcEABcH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 30 Apr 2016 21:32:07 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 846B83B72E
	for <ceph-devel@vger.kernel.org>; Sun,  1 May 2016 01:32:05 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: branto@redhat.com
Cc: ceph-devel@vger.kernel.org

Hi Boris,

Do you know why these selinux failures are happening on the jewel branch?  
I don't see any obvious differences from master, which doesn't seem to be 
hitting these.

http://pulpito.ceph.com/sage-2016-04-30_16:27:00-rados-jewel---basic-smithi/159724

Thanks!
sage

