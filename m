From: Sage Weil <sweil@redhat.com>
Subject: "1 hosts down" health warning?
Date: Mon, 9 May 2016 12:36:52 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605091232040.1841@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38564 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbcEIQgk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 May 2016 12:36:40 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C0D12637
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2016 16:36:39 +0000 (UTC)
Received: from cpach ([10.3.112.6])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u49Gaba1007685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 9 May 2016 12:36:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We have a feature (mon_osd_reporter_subtree_level = host) that makes it so 
that if an entire host is down (or whatever the configured hierarchy 
level is) the osds aren't automatically marked out after 5 minutes.

This is confusing on an actual cluster because you see something like

            48/5661 in osds are down

bit it never clears.  It's not until you look at the ceph osd tree output 
that you can see why they aren't getting marked out.

It would be great if the health warning said something like

            48/5661 in osds are down
            1/142 hosts are down (accounting for 48/48 down osds)

and the health detail said something like

  host foo is down with 48 OSDs

I think this would be pretty easy to implement given the mon is 
already doing the subtree-based checks.

Thoughts? Any takers?

sage
