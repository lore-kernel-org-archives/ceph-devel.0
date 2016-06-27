From: Sage Weil <sweil@redhat.com>
Subject: libradosstriper
Date: Mon, 27 Jun 2016 22:18:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606272216370.7088@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35420 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbcF0WTA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Jun 2016 18:19:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sebastien.ponce@cern.ch
Cc: ceph-devel@vger.kernel.org

Hi Sebastien,

Do you mind updating us on the current status of libradosstriper?  Where 
does it stand feature-wise with what you need, how are you currently using 
it or how do you plan to use it, and what is still missing?

Also, one thing we really want to see is test coverage for the code so 
that we can comfortably point users toward it.  This ideally would look 
something like the ceph_test_rados_api_* tests that verify individual 
operations behave as expected, and/or something like ceph_test_rados that 
throws random operations at is and verifies it returns correct results 
that match its in-memory model.

Thanks!
sage
