From: "Holcombe, Christopher" <cholcomb@cscinfo.com>
Subject: RadosGW Quota
Date: Thu, 7 Feb 2013 19:21:43 +0000
Message-ID: <C4049E4484F13747B672D64B9C12C31328E0F747@PWMAILM01.cscinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.cscinfo.com ([165.160.9.58]:47563 "EHLO mx2.cscinfo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758711Ab3BGTVp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:21:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx2.cscinfo.com (Postfix) with ESMTP id 4019F3A8017
	for <ceph-devel@vger.kernel.org>; Thu,  7 Feb 2013 14:21:45 -0500 (EST)
Received: from mx2.cscinfo.com ([127.0.0.1])
	by localhost (plmail02.wil.csc.local [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lYCRwIigE6cK for <ceph-devel@vger.kernel.org>;
	Thu,  7 Feb 2013 14:21:44 -0500 (EST)
Received: from casarray.cscinfo.com (pwmailch01.cscinfo.com [172.20.53.93])
	by mx2.cscinfo.com (Postfix) with ESMTPS id 96F6CD72C5
	for <ceph-devel@vger.kernel.org>; Thu,  7 Feb 2013 14:21:44 -0500 (EST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Does the RadosGW have the ability to limit how much data clients(users) can upload to it?  I'm looking for a way to implement quotas in case someone decides to upload the world on my cluster and break it

-Chris


________________________________

NOTICE: This e-mail and any attachments is intended only for use by the addressee(s) named herein and may contain legally privileged, proprietary or confidential information. If you are not the intended recipient of this e-mail, you are hereby notified that any dissemination, distribution or copying of this email, and any attachments thereto, is strictly prohibited. If you receive this email in error please immediately notify me via reply email or at (800) 927-9800 and permanently delete the original copy and any copy of any e-mail, and any printout.
