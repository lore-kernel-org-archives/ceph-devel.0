From: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: Huge MDS log crashing the cluster
Date: Tue, 22 May 2012 11:03:37 +0000 (UTC)
Message-ID: <loom.20120522T130047-937@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50836 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758353Ab2EVLDy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 May 2012 07:03:54 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SWmsX-0005Fa-Hl
	for ceph-devel@vger.kernel.org; Tue, 22 May 2012 13:03:49 +0200
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 13:03:49 +0200
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 13:03:49 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I have dedicated 10G space for /var partition. But, MDS log has filled the
entire /var partition and my cluster is not responding. How shall I fix this?
and what I need to make so that /var partition won't fill up again.

Appreciate any solution/suggestion on this. My entire ceph cluster became
unresponsive.

Thanks
__M

