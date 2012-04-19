From: Sage Weil <sage@newdream.net>
Subject: wip-discard
Date: Thu, 19 Apr 2012 14:10:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204191407140.24981@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58280 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933184Ab2DSVKN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Apr 2012 17:10:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@dreamhost.com
Cc: ceph-devel@vger.kernel.org

Hey Josh-

I pushed a wip-discard branch that updates fsx to the version in xfstests 
(which has discard support).  There's also a bug fix in there that is 
non-trivial.  If you have time in the next day or two to look at that 
that'd be great!  The new discard stuff seems to be tolerating fsx just 
fine both with and without caching.

Thanks!
sage
