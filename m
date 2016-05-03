From: Sage Weil <sweil@redhat.com>
Subject: trello backlog
Date: Tue, 3 May 2016 09:29:18 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605030925310.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755546AbcECN3K (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 May 2016 09:29:10 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F8ACC06C9E6
	for <ceph-devel@vger.kernel.org>; Tue,  3 May 2016 13:29:09 +0000 (UTC)
Received: from cpach ([10.3.112.6])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u43DT6Xu012566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Tue, 3 May 2016 09:29:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

We have a zillion tickets in tracker.ceph.com, but the interface is 
frustrating enough and there is enough cruft there that it is no 
particularly useful for keeping track of the important *high-level* 
features we need to work on.  I find myself making ad hoc lists in random 
places for my own personal use instead.

In a similar vein, ages ago we tried to create a "chum bucket" with 
bite-size introductory projects to help get users started contributing 
code.  This fizzled out, I think mainly because the list was in its own 
special place where developers don't look on a day to day basis, which 
meant the list quickly aged and new ideas didn't get added as a matter of 
course.

I'm hoping that we can address both issues by using a more friendly tool.  
To that end, I created a trello board for the upstream ceph backlog.  It's 
publicly readable and available at

        https://trello.com/b/ugTc2QFH/ceph-backlog

If you are an active developer, ping me and I'll send you an invite URL 
to add you to the Ceph org (to get write access to the board).

I'm not sure how helpful this will be, and I'm generally skeptical of tool 
proliferation.  OTOH, trello is super-lightweight, and even if we only use 
this for little stuff (like chum) I suspect it will be a win.

We can also create other boards within the ceph org for other subprojects 
that need more granular tracking (e.g., the transition to cmake, which is 
currently tracked on an etherpad and in Ali's head).

sage
