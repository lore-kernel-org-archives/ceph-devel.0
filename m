From: Sage Weil <sage@inktank.com>
Subject: github pull requests
Date: Tue, 19 Mar 2013 15:54:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303191550140.4850@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54098 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229Ab3CSWyf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 18:54:35 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AA23880069
	for <ceph-devel@vger.kernel.org>; Tue, 19 Mar 2013 15:54:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7090E80069
	for <ceph-devel@vger.kernel.org>; Tue, 19 Mar 2013 15:54:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've been doing reviews and merged in a somewhat ad hoc fashion:

 - push wip-something to ceph.git
 - verify it builds, etc.
 - poke some other developer to review it
 - run some tests
 - repeat ...
 - merge locally and then push to ceph.git master

Finding old review comments once the branch goes away is difficult 
(impossible?), though, which is annoying (although not a deal-killer).

Having played with the pull request stuff a bit now, though, the workflow 
is much nicer!

 - all review comments roll up on the pull request page, even after it is 
   merged
 - you can re-push the same branch name and the existing pull request 
   sticks around (with a note in the history about the change)
 - merging is one click (vs several commands worth of git-fu)

The only thing it doesn't do for you is zap the old branch.

Anyway, I think we should start using this for all of our merges and 
review requests now.  It'll keep everything visible in one easy to find 
spot and preserve history better.

sage
