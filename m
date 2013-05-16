From: Sage Weil <sage@inktank.com>
Subject: teuthology yaml change (read this!)
Date: Thu, 16 May 2013 11:33:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305161132100.28450@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60222 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241Ab3EPSd0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 May 2013 14:33:26 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A6B788004F
	for <ceph-devel@vger.kernel.org>; Thu, 16 May 2013 11:33:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 875448004F
	for <ceph-devel@vger.kernel.org>; Thu, 16 May 2013 11:33:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

You used to specify the branch to test in the ceph overrides, like so:

overrides:
  ceph:
    branch: wip-foo

No more!  Now, you need to do

overrides:
  install:
    branch: wip-foo

The schedule_suite.sh script puts it in both places so that you can still 
schedule old teuthology branches properly (cuttlefish and older).

FYI!
sage
