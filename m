From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: osd suicide timeout
Date: Fri, 10 Jul 2015 21:45:02 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91669B3BFF@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0143.outbound.protection.outlook.com ([157.56.111.143]:60768
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751635AbbGJVpI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jul 2015 17:45:08 -0400
Received: from satlvexedge01.amd.com (satlvexedge01.amd.com [10.177.96.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp01.amd.com (Axway MailGate 5.3.1) with ESMTPS id 25999CAE627
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2015 17:45:03 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have an osd log file from an osd that hit a suicide timeout (with the previous 10000 events logged). 
(On this node I have also seen this suicide timeout happen once before and also a sync_entry timeout.

I can see that 6 minutes or so before that osd died, other osds on the same node were logging
messages such as
    heartbeat_check: no reply from osd.8
so it appears that osd8 stopped responding quite some time before it died.

I'm wondering if there is enough information in the osd8 log file to deduce why osd 8 stopped responding?
I don't know enough to figure it out myself.

Is there any expert who would be willing to take a look at the log file?

-- Tom Deneau, AMD

