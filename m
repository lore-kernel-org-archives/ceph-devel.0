From: Sage Weil <sweil@redhat.com>
Subject: streamlining release notes
Date: Tue, 13 Oct 2015 10:34:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510131026260.6589@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45100 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932388AbbJMRe4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 Oct 2015 13:34:56 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id A529B19F21F
	for <ceph-devel@vger.kernel.org>; Tue, 13 Oct 2015 17:34:56 +0000 (UTC)
Received: from redhat.com ([10.3.112.16])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t9DHYteL016888
	for <ceph-devel@vger.kernel.org>; Tue, 13 Oct 2015 13:34:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The process of walking through commits for each release and writing up the 
notes is tedious and error prone, and used to take 1-2 hours for 
each release.  Since we've not been doing dev releases as frequently this 
cycle, the ~2000 odd commits for the infernalis rc promises to take 
even longer.  This isn't very sustainable...

Simply generating a shortlog from git works for point releases where it's 
important to call out every change.  However, for dev releases, that's way 
to much detail to be useful to anyone.

After chatting a bit with Loic about this, we have an alternative 
proposal: generate the release notes from the git merge commits.  The 
process would be:

 - Review PR, make sure it's tested, etc. (as we do now)
 - Ensure the PR title is meaningful, as this will be what appears as the 
oneliner in the release notes.  For example make sure it is prefixed by 
the subsystem name (rbd, rgw, common, build, etc.), is reasonable concise, 
and says something that makes some sense to a non-developer.
 - Optionally add an extended description in the merge commit that 
provides any further detail.  Like,

 Description: This forces all daemons to be upgraded to hammer v0.94.4 (or 
a later point release) before any daemons can be upgraded to anything 
after hammer.

 - Click 'merge', and add in Reviewed-by: lines, and confirm.

Then, a script can generate the release notes semi-automagically from 
that, adding in links to the PR, any bugs referenced in the commits, and 
the names of the contributors.

What do you think?
sage

