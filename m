From: Sage Weil <sweil@redhat.com>
Subject: ceph-disk vs keyvaluestore
Date: Mon, 29 Sep 2014 16:48:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409291645320.20141@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49943 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbaI2XsT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 19:48:19 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: haomaiwang@gmail.com
Cc: ceph-devel@vger.kernel.org, mark.kirkwood@catalyst.net.nz

Hi Haomai,

Not sure if you saw

	http://tracker.ceph.com/issues/9580

which came from an issue Mark had getting ceph-disk to work with the 
keyvaluestore backend.  I think the answer is to make a command 
like

	ceph-osd -i 123 --check-needs-journal

to query whether the configured backend wants a journal backend.  That 
would let ceph-disk skip the work.  Would need to be careful to 
distinguish between errors and a true/false answer.

Any interest in wiring that up?
sage

