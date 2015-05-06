From: Sage Weil <sweil@redhat.com>
Subject: rados semantic changes
Date: Wed, 6 May 2015 10:47:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505061044140.28239@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56413 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbbEFRrO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 May 2015 13:47:14 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id EB836B5E7C
	for <ceph-devel@vger.kernel.org>; Wed,  6 May 2015 17:47:13 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com, ceph-devel@vger.kernel.org

It sounds like we're kicking around two proposed changes:

1) A delete will never -ENOENT; a delete on a non-existent object is a 
success.  This is important for cache tiering, and allowing us to skip 
checking the base tier for certain client requests.

2) Any write will implicitly create the object.  If we want such a 
dependency (so we see ENOENT), the user can put an assert_exists in the op 
vector.

I think what both of these amount to is that the writes have no read-side 
checks and will effectively never fail (except for true failure 
cases).  If the user wants some sort of failure, it will be explicit 
in the form of another read check in the op vector.

Sam, is this what you're thinking?

It's a subtle but real change in the semantics of rados ops, but I 
think now would be the time to make it...

sage
