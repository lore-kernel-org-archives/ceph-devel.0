From: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: SAS disks for OSD's
Date: Mon, 23 Apr 2012 15:56:24 +0000 (UTC)
Message-ID: <loom.20120423T175101-19@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38583 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab2DWP4g (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Apr 2012 11:56:36 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SMLcv-0004tI-EF
	for ceph-devel@vger.kernel.org; Mon, 23 Apr 2012 17:56:33 +0200
Received: from Static-131.13.96.14.tataidc.co.in ([Static-131.13.96.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 23 Apr 2012 17:56:33 +0200
Received: from madhusudhana.u.acharya by Static-131.13.96.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 23 Apr 2012 17:56:33 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
Is any performance benefit we will get using SAS storage for OSD instead of 
SATA storage ? Is any one using SAS drives which is producing good performance? 

Or I can use SAS drives for journal and SATA storage for OSD? 

Which one in above two scenario would yield a better performance?

I would like to test above scenarios, before i would like to hear if
anyone got good results with SAS drives.

Thanks
__M

