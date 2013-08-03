From: James Harper <james.harper@bendigoit.com.au>
Subject: bug in /etc/init.d/ceph debian
Date: Sat, 3 Aug 2013 03:09:46 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B62E7617E@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:41150 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab3HCDbc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Aug 2013 23:31:32 -0400
Received: from bitcom1.int.sbss.com.au ([2001:388:e000:712:a5ca:4fd3:14f:ad5d])
	by smtp2.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1V5SE0-00019k-6X
	for ceph-devel@vger.kernel.org; Sat, 03 Aug 2013 13:09:48 +1000
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm running ceph 0.61.7-1~bpo70+1 and I think there is a bug in /etc/init.d/ceph

The heartbeat RA expects that the init.d script will return 3 for "not running", but if there is no agent (eg mds) defined for that host it will return 0 instead, so pacemaker thinks the agent is running on a node where it isn't even defined and presumably would then start doing stonith when it finds it remains running after a stop command.

Or maybe that is the correct behaviour of the init.d script and the RA needs to be modified?

Thanks

James
