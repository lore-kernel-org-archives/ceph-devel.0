From: Sage Weil <sweil@redhat.com>
Subject: possible async msgr encoding issue?
Date: Tue, 1 Sep 2015 11:48:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509011145500.13116@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60586 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771AbbIASs2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Sep 2015 14:48:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: haomaiwang@gmail.com
Cc: ceph-devel@vger.kernel.org

Hi Haomai,

I'm looking at http://tracker.ceph.com/issues/12908 which has popped up a 
couple times in the last couple days.  I really looks like the 
pg_query_t::sent_epoch is filled with a bogus value... causing it to try 
to generate history from before the pg was created.  My guess is that the 
encode_payload() call is getting passed no features, triggering the legacy 
encoding.. but the msg header.version is still getting filled in with 3?  
Is that possible?

Thanks!
sage
