From: Sven Sternberger <sven.sternberger@desy.de>
Subject: General question about a testbed
Date: Thu, 08 Mar 2012 09:37:19 +0100
Message-ID: <1331195839.14554.29.camel@zitpcx6759.desy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp-out-1.desy.de ([131.169.56.84]:36159 "EHLO
	smtp-out-1.desy.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab2CHIt5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 03:49:57 -0500
Received: from smtp-map-1.desy.de (smtp-map-1.desy.de [131.169.56.66])
	by smtp-out-1.desy.de (DESY_OUT_1) with ESMTP id 68A9A175F
	for <ceph-devel@vger.kernel.org>; Thu,  8 Mar 2012 09:37:21 +0100 (MET)
Received: from ZITSWEEP2.win.desy.de (zitsweep2.win.desy.de [131.169.97.96])
	by smtp-map-1.desy.de (DESY_MAP_1) with ESMTP id 2998613E81
	for <ceph-devel@vger.kernel.org>; Thu,  8 Mar 2012 09:37:20 +0100 (MET)
Received: from smtp-intra-1.desy.de (lb-40-26.desy.de) by ZITSWEEP2.win.desy.de
 (Clearswift SMTPRS 5.4.1) with ESMTP id <Ta2fe1438dd83a9616015dc@ZITSWEEP2.win.desy.de> for <ceph-devel@vger.kernel.org>;
 Thu, 8 Mar 2012 09:37:20 +0100
Received: from [131.169.137.189] (zitpcx6759.desy.de [131.169.137.189])
	by smtp-intra-1.desy.de (DESY-INTRA-1) with ESMTP id 0471D3E901
	for <ceph-devel@vger.kernel.org>; Thu,  8 Mar 2012 09:37:20 +0100 (MET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello!

I want to set up a testbed for evaluating
ceph. At this point we want to look at the performance
and the administration of a small cluster (4 machines,
60TB)

So neither ceph nor btrfs are good supported by 
ScientificLinux which we use.

It would be helpful if you could point out which
linux distributions gives an easy starting point.
Should we use an recent kernel, or go with the distribution
default.

best regards!

Sven



