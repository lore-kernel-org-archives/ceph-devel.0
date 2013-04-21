From: James Harper <james.harper@bendigoit.com.au>
Subject: clean shutdown and failover of osd
Date: Sun, 21 Apr 2013 05:15:18 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B4F360D32@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.bendigoit.com.au ([203.16.207.99]:36446 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab3DUFP2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 01:15:28 -0400
Received: from [2001:388:e000:712:a5ca:4fd3:14f:ad5d] (helo=BITCOM1.int.sbss.com.au)
	by smtp2.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1UTmcV-0004Qh-Rg
	for ceph-devel@vger.kernel.org; Sun, 21 Apr 2013 15:15:24 +1000
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm doing some testing with ceph trying to figure out why my performance is so bad, and have noticed that there doesn't seem to be a way to cleanly stop an osd, or at least under debian /etc/init.d/ceph stop seems to just kill the OSD resulting in the client also stopping io until it figures out why the node isn't responding.

Is this how it is supposed to work? I would have thought it would be possible to shut down an osd cleanly such that failover is immediate. I understand that an abrupt failure like a node crashing would result in a freeze for a bit.

Thanks

James

