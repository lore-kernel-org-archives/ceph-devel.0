From: Sage Weil <sweil@redhat.com>
Subject: bluestore coordination
Date: Mon, 23 May 2016 14:14:42 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605231408050.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36119 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbcEWSOX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 May 2016 14:14:23 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6D5685365
	for <ceph-devel@vger.kernel.org>; Mon, 23 May 2016 18:14:22 +0000 (UTC)
Received: from cpach (ovpn-112-33.phx2.redhat.com [10.3.112.33])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4NIEKig017285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 23 May 2016 14:14:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I moved the bluestore-specific tasks from the ceph trello to a separate 
board:

	https://trello.com/b/qn3ixhnI/bluestore#

because there are a lot of little things.  If you're working on 
bluestore at all, please take a look and join the board (email/irc me if 
you need access).

Also, I think it would be helpful to have a daily or regular standup.  
There are ~6 of us now and I'm having trouble keeping track of what 
everyone is working on. Since this is all mostly unrelated to the other 
work going on in core, I suggest we either do

 	- right before core standup, 10:30 ET (14:30 UTC)
	- a bit earlier, 9:45 ET (13:45 UTC)
	- even earlier, 8:30 ET (12:30 UTC)

I think the last is better for both APAC and EMEA, but harder for 
California. I'm not sure what time zones everyone is in, though.  If there 
are US west coast people, maybe the middle one?  That's about when we do 
CephFS and works reasonably well.

sage

