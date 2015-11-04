From: Sage Weil <sweil@redhat.com>
Subject: dm-clock queue
Date: Wed, 4 Nov 2015 14:35:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511021051450.24297@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35552 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030434AbbKDWfv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 Nov 2015 17:35:51 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: g.marripudi@ssi.samsung.com, ivancich@redhat.com
Cc: mbenjami@redhat.com, sjust@redhat.com, ceph-devel@vger.kernel.org

Hi Gunna, Eric-

I wanted to make sure you were connected as we've talked to both of you 
independently about the new request queue in the OSD to support dm-clock 
and I want to make sure our efforts are coordinated.  I thnk the first 
goal is probably to implement something that works and performs well for 
just a few request classes (clients, recovery, scrub, snaptrim).  
Eventually we'll also need to determine if/how to do so for a large client 
count so that we can do client qos.  Just solving the first problem alone 
may be a big win, though: we hear lots of complaints about the effect of 
recovery on client io.

Anyway, just wanted to make sure you two were connected and kick off the 
conversation.

sage
