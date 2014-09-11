From: Guang Yang <yguang11@outlook.com>
Subject: RGW threads hung - more logs
Date: Thu, 11 Sep 2014 21:14:30 +0800
Message-ID: <BLU436-SMTP81201D19784D907EF358DDDFCC0@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s20.hotmail.com ([65.55.111.159]:50477 "EHLO
	BLU004-OMC4S20.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756768AbaIKNPv convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Sep 2014 09:15:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, sam.just@inktank.com, Gregory Farnum <greg@inktank.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage, Sam and Greg,
With the radosgw hung issue we discussed this today, I finally got some more logs showing that the reply message has been received by ragosgw, but failed to be dispatched as dispatcher thread was hung. I put all the logs into the tracker - http://tracker.ceph.com/issues/9008

While the logs explain what we observed, I failed to find any clue that why the dispatcher would need to wait for objecter_bytes throttler budget, did I miss anything obvious here?

Tracker link - http://tracker.ceph.com/issues/9008

Thanks,
Guang