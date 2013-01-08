From: Sage Weil <sage@inktank.com>
Subject: branches
Date: Tue, 8 Jan 2013 10:39:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301081038580.30467@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52721 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757033Ab3AHSjr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 13:39:47 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5EFDB80068
	for <ceph-devel@vger.kernel.org>; Tue,  8 Jan 2013 10:39:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 388CD80068
	for <ceph-devel@vger.kernel.org>; Tue,  8 Jan 2013 10:39:47 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'd like to adjust the branches we're maintaining in ceph.git.  Currently:

master
 - active development
next
 - frozen for next release
 - bug fixes only
 - regularly merged back into master
testing
 - last development release
 - cherry-pick -x'd critical fixes
 - packages at ceph.com/debian-testing, /rpm-testing
stable
 - argonaut long-term backport series
 - cherry-pick -x'd critical fixes
 - packages at ceph.com/debian-argonaut, /debian

The stable is ambiguous, and testing is a confusing name.  Instead, I 
propose:

master  -- same
next    -- same
last
 - last release (instead of 'testing')
 - packages at /debian-testing and /debian-last, /rpm-testing, /rpm-last
bobtail
 - bobtail backport series 0.56.x
 - packages at /debian-bobtail (and /debian, until cuttlefish), 
   /rpm-bobtail, /rpm
argonaut
 - argonaut backport series 0.48.x
 - packages at /debian-argonaut

We'll need to update the parallel branches in teuthology.git, 
ceph-qa-suite.git, and s3-tests.git to match.

