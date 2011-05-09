From: Mark Nigh <mnigh@netelligent.com>
Subject: Unable to Add Monitor
Date: Mon, 9 May 2011 09:22:40 -0500
Message-ID: <B828A4C02BE12543ACDFCF7EB0C693C67885FC7D23@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.netelligent.com ([199.255.228.141]:12946 "EHLO
	NC-SVR-11.netelligent.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753477Ab1EIOWo convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 May 2011 10:22:44 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have been testing Ceph for several months now but with only 2 mds and 1 mon. I would like to test failover between mon so I am trying to add the first (1st) of two (2) mon on the other mds in the cluster.

I also noticed that the mon naming has been changed from numerics to names so I am trying to change that also.

My Process:

On the first mon, I get an error when issuing this command "ceph mon add beta 10.6.1.91:6789"

I receive the following error as it repeats:

2011-05-09 09:17:05.500353 7f9248ab0700 -- :/28272 >> 10.6.1.91:6789/0 pipe(0x2167010 sd=3 pgs=0 cs=0 l=0).fault first fault

When I try to start the monitor service on beta I get the following error:

=== mon.beta ===
Starting Ceph mon.beta on mds1...
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
unable to read magic from mon data.. did you run mkcephfs?
failed: ' /usr/bin/cmon -i beta -c /etc/ceph/ceph.conf '

I appreciate your help in pointing me in the right direction.

Thank you,

Mark Nigh
Systems Architect
Netelligent Corporation
mnigh@netelligent.com


This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
