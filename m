From: Sage Weil <sweil@redhat.com>
Subject: BlueStore deep-dive over bluejeans
Date: Wed, 24 Feb 2016 14:51:39 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602241447430.7555@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52753 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756448AbcBXTwI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 24 Feb 2016 14:52:08 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 990D08F4FF
	for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 19:52:08 +0000 (UTC)
Received: from cpach (ovpn-112-87.phx2.redhat.com [10.3.112.87])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1OJq6Wk018708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 14:52:07 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey all,

I'm planning on doing an hour-ish deep-dive into the inner workings of 
BlueStore next Monday, 2/29, 5pm-6pm ET / 2pm-3pm PT.  It'll be a 
mostly-informal brain dump and walk-through of the code over bluejeans, 
and we'll record it.  Anyone who is or is planning to be involved in 
bluestore development, please join and ask questions etc!  I'll send out 
the bluejeans link shortly before we start.

sage
