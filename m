From: Sage Weil <sweil@redhat.com>
Subject: merge commits reminder
Date: Wed, 11 Nov 2015 06:04:07 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511110602291.7964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44072 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbbKKOEJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Nov 2015 09:04:09 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id E3A2A3B71E
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2015 14:04:09 +0000 (UTC)
Received: from redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tABE488J029825
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2015 09:04:09 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Just a reminder: we'd like to generate the release changelog from the 
merge commits.  Whenever merging a pull request, please remember to:

 - edit the first line to be what will will appear in the changelog.  
Prefix it with the subsystem and give it a short, meaningful description.  
 - if the bug isn't mentioned in any of commits (Fixes: #1234), add it to 
the merge commit.

Thanks!
sage
