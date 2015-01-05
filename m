From: Sage Weil <sweil@redhat.com>
Subject: ceph osd df
Date: Mon, 5 Jan 2015 11:03:40 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501051101010.6168@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42257 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932107AbbAETDl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Jan 2015 14:03:41 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t05J3f5G014002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Mon, 5 Jan 2015 14:03:41 -0500
Received: from redhat.com ([10.3.112.19])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t05J3esn021921
	for <ceph-devel@vger.kernel.org>; Mon, 5 Jan 2015 14:03:40 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We see a fair number of issues and confusion with OSD utilization and 
unfortunately there is easy way to see a summary of the current OSD 
utilization state.  'ceph pg dump' includes raw data but it not very 
friendly.  'ceph osd tree' shows weights but not actual utilization.  
'ceph health detail' tells you the nearfull osds but only when they reach 
the warning threshold.

Opened a ticket for a new command that summarizes just the relevant info:

	http://tracker.ceph.com/issues/10452

Suggestions welcome.  It's a pretty simple implementation (the mon has 
all the info; just need to add the command to present it) so I'm hoping it 
can get into hammer.  If anyone is interested in doing the 
implementation that would be great too!

sage
