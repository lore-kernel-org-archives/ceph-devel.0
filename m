From: "Holcombe, Christopher" <cholcomb@cscinfo.com>
Subject: OSD Weights
Date: Mon, 11 Feb 2013 20:43:16 +0000
Message-ID: <C4049E4484F13747B672D64B9C12C31328E13918@PWMAILM01.cscinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.cscinfo.com ([165.160.9.58]:44068 "EHLO mx2.cscinfo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932170Ab3BKUnT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 15:43:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx2.cscinfo.com (Postfix) with ESMTP id 8AED1E4878
	for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 15:43:18 -0500 (EST)
Received: from mx2.cscinfo.com ([127.0.0.1])
	by localhost (plmail02.wil.csc.local [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rv6jpttQfRqP for <ceph-devel@vger.kernel.org>;
	Mon, 11 Feb 2013 15:43:17 -0500 (EST)
Received: from casarray.cscinfo.com (pwmailch03.cscinfo.com [172.20.53.95])
	by mx2.cscinfo.com (Postfix) with ESMTPS id D49C2E3809
	for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 15:43:17 -0500 (EST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Everyone,

I just wanted to confirm my thoughts on the ceph osd weightings.  My understanding is they are a statistical distribution number.  My current setup has 3TB hard drives and they all have the default weight of 1.  I was thinking that if I mixed in 4TB hard drives in the future it would only put 3TB of data on them.  I thought if I changed the weight to 3 for the 3TB hard drives and 4 for the 4TB hard drives it would correctly use the larger storage disks.  Is that correct?

Thanks,
Chris

________________________________

NOTICE: This e-mail and any attachments is intended only for use by the addressee(s) named herein and may contain legally privileged, proprietary or confidential information. If you are not the intended recipient of this e-mail, you are hereby notified that any dissemination, distribution or copying of this email, and any attachments thereto, is strictly prohibited. If you receive this email in error please immediately notify me via reply email or at (800) 927-9800 and permanently delete the original copy and any copy of any e-mail, and any printout.
