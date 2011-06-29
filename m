From: "Hemingway, Graham Stuart" <graham.hemingway@Vanderbilt.Edu>
Subject: Add OSD and hard drives
Date: Wed, 29 Jun 2011 14:23:16 -0500
Message-ID: <ED302AD9DFBE5045BC354B53A8AD5FB10332831071@its-hcwnem05.ds.Vanderbilt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgate.vanderbilt.edu ([129.59.15.72]:42038 "EHLO
	mailgate.vanderbilt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617Ab1F2TX7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2011 15:23:59 -0400
Received: from hub.vanderbilt.edu ([10.1.137.28])
	by mailgate02.its.vanderbilt.edu (8.14.3/8.14.3) with ESMTP id p5TJNvNx029307
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 29 Jun 2011 14:23:58 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

I have a simple ceph installation working.  My cluster has 7 hardware nodes.  5 OSDs (1 2TB drive each) and two MDSs.  I have one monitor which is on the same machine as one of the MDSs.  Running on Ubuntu 10.10 and v0.30 I have things working.  Yeah.
So, my questions are:

1) Would you recommend adding a second monitor on the same machine as the other MDS?  Therefore two nodes each with MON and MDS.  Does ceph still want monitors in odd numbers?
2) What is the procedure for adding an additional hard drive to each OSD?  I have a second 2TB drive physically on each OSD node that I would like to bring up and I did not find ready documentation on just adding drives.

Thanks,
   Graham