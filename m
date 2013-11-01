From: Sage Weil <sage@inktank.com>
Subject: REBASED next, master !!!
Date: Fri, 1 Nov 2013 16:29:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1311011625250.23435@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47375 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab3KAX3x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Nov 2013 19:29:53 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7BD818004F
	for <ceph-devel@vger.kernel.org>; Fri,  1 Nov 2013 16:29:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 582958004F
	for <ceph-devel@vger.kernel.org>; Fri,  1 Nov 2013 16:29:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There was a branching snafu a couple days back (the next/emperor branch 
got all of master merged in after -rc1) that was most sanely cleaned up by 
rebuilding the branches from that point.  Fortunately not too much has 
gone in since then, so it wasn't too much.

HOWEVER, if you work based on master or next since then, take a careful 
look at gitk and make sure your work is rebased on top of the *new* master 
and next.  FYI that is usually done with:

 git checkout wip-foo
 git rebase --onto origin/next HEAD^
 git push origin -f wip-foo

where HEAD^ can be replaced with whatever commit your work is 
based off of.  (HEAD^ works for a single-patch branch.)

I updated several branches already.. hopefully all of them in ceph.git.  
Those include

 wip-6699
 wip-crush-location-doc
 wip-perf2
 wip-pipe
 wip-warnings

Also, going forward, be careful to look at the commits and/or diff in pull 
requests before merging to make sure we're not picking bits of the old 
branches.

Thanks!  Sorry for the confusion!
sage
