From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: How will Ceph cope with a failed Journal device?
Date: Fri, 18 May 2012 20:30:58 +0200
Message-ID: <2465580.E9977TXsHv@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:57419 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933030Ab2ERSbF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 May 2012 14:31:05 -0400
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id D972D10C866
	for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 20:31:02 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

We have been having a lot of discussions at my workplace about whether to 
employ a Ceph cluster in production or not, and if yes, how to set up the 
hardware for it. During that discussion, I mentioned that, according to the 
documentation, we should see significant speedups from using dedicated SSDs 
for the OSD's journals. Unfortunately, my colleagues did not like this idea at 
all - many of them had bad experiences with SSDs failing or at least read a 
lot about that on the Internet, and there's a general consensus that SSDs are 
just not quite reliable enough yet for production servers.

This leads me to the question: What exactly can happen if an OSD's journal 
device suddenly fails during operations? Can that lead to data loss or 
corruption, or disruptions of the service?

In my experience with the small three-machine test cluster I have here, a 
single failed node usually would lead to a pretty severe outage of the entire 
cluster on the order of ten minutes or more (probably much more when it's a 
really big node that fails), though so far no data loss or corruption...

Regards,

	Guido
