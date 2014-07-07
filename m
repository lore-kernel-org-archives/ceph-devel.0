From: Guang Yang <yguang11@outlook.com>
Subject: radosgw - bucket index sharding merge back
Date: Mon, 7 Jul 2014 20:45:23 +0800
Message-ID: <BLU436-SMTP92AD28802F9D235064A259DF0D0@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s14.hotmail.com ([65.55.111.153]:64910 "EHLO
	BLU004-OMC4S14.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752709AbaGGMpe convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Jul 2014 08:45:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <josh.durgin@inktank.com>

Hi Yehuda,
I am trying to find a way to merge back the bucket index sharding effort, and with more experience working at Ceph, I realized that the original commit was too huge which introduced trouble for review. I am thinking to break it down into multiple small commits and commit back with a number of patches. I have two questions here:

1) Have you looked at the patch and any suggestion I should pay attention to when doing the split?
2) Can we merge back with a series of patches (e.g. several commits one patch)?

Any suggestion that I should pay attention to so as to drive this effort into completion?

Thanks,
Guang