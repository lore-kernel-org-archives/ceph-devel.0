From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: ms_crc_data false
Date: Wed, 8 Apr 2015 22:38:14 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9166416855@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0107.outbound.protection.outlook.com ([65.55.169.107]:27199
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754152AbbDHWiS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 18:38:18 -0400
Received: from satlvexedge01.amd.com (satlvexedge01.amd.com [10.177.96.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp01.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2A565CAE7D2
	for <ceph-devel@vger.kernel.org>; Wed,  8 Apr 2015 17:38:13 -0500 (CDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

With 0.93, I tried 
    ceph tell 'osd.*' injectargs '--ms_crc_data=false' '--ms_crc_header=false'

and saw the changes reflected in ceph admin-daemon

But having done that, perf top still shows time being spent in crc32 routines.
Is there some other parameter that needs changing?

-- Tom Deneau

