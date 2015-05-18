From: Sage Weil <sweil@redhat.com>
Subject: ceph-ci.git?
Date: Sun, 17 May 2015 21:40:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505172130440.8350@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34721 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbbEREky (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 May 2015 00:40:54 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id E3901AC7AB
	for <ceph-devel@vger.kernel.org>; Mon, 18 May 2015 04:40:53 +0000 (UTC)
Received: from redhat.com (ovpn-112-27.phx2.redhat.com [10.3.112.27])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4I4eqUW027213
	for <ceph-devel@vger.kernel.org>; Mon, 18 May 2015 00:40:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

As the number of people contributing code grows, we've added more and more 
people to the github ceph org who have write access to ceph.git.  Those 
people can merge pull requests and can also push branches directly to the 
repo.

We also use ceph.git as a source for the test build infrastrucure 
(gitbuilders) to generate packages for QA or hot fixes and make check 
tests.  This leads to an every-growing body of wip-* branches in the repo 
(which is annoying), and also means that in order to build something to 
test in QA you also get the ability to (say) push directly to master.

How about we instead

 - create a second repo named something like ceph-ci.git (that's the best 
I can come up with at the moment) 
 - add this as a second source for all gitbuilders (they can poll a list)
 - move all wip-* branches here
 - create a new github team with contributing developers who can push to 
this repo and are trusted not to wreak havoc on the builders
 - remove all the cruft from ceph.git, so that it's just master, next, the 
stable branches, release tags, and anything else similarly important.
 - restrict ceph.git write access to core developers

This will improve security somewhat and reduce the risk of an accidental 
push to an important branch.

It may also reduce the risk associated with accidental force pushes 
(something we've hemmed and hawed about recently) by limiting the circle 
of people who can write to ceph.git and also changing workflows so that it 
is almost never used directly...

?
sage

