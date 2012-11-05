From: Andrew Thrift <andyonfire@gmail.com>
Subject: Large numbers of OSD per node
Date: Mon, 05 Nov 2012 20:14:51 +1300
Message-ID: <5097676B.5020200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cps.hostingdirect.co.nz ([210.79.48.6]:41192 "EHLO
	cps.hd.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060Ab2KEHfL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Nov 2012 02:35:11 -0500
Received: from 222.47.255.123.static.snap.net.nz ([123.255.47.222] helo=[192.168.69.11])
	by cps.hd.net.nz with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <andyonfire@gmail.com>)
	id 1TVGtb-0004GJ-D1
	for ceph-devel@vger.kernel.org; Mon, 05 Nov 2012 20:14:57 +1300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

We are evaluating CEPH for deployment.

I was wondering if there are any current "best practices" around the 
number of OSD's per node ?


e.g. We are looking at deploying 3 nodes, each with 72x SAS disks, and 
2x 10gigabit Ethernet bonded.

Would this best be configured as 72 OSD's per node.

Or would we be better to using raid5 to have 18 OSD's per node ?




Regards,





Andrew
