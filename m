From: Sage Weil <sage@inktank.com>
Subject: final mon issues
Date: Fri, 26 Apr 2013 12:43:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304261240460.13630@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33024 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab3DZTnu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 15:43:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: greg@inktank.com, ceph-devel@vger.kernel.org
Cc: mike.dawson@scholarstack.com

I've merged the double-forward fix.  I still have one remaining problem
that I can reproduce with my tests which looks like an overlap of mon 
overload forwarded message priorities; I'm testing two possible fixes to 
see which are necessary to resolve it.

The memory issues with people using the gitbuilder appear to be because 
our gitbuilders weren't linking in tcmalloc.  The latest 'next' build 
*does* link it now, so if you are one of those people, please re-test!

I don't think either of those problems is related to the sync issues Mike 
is seeing, though.  I believe that is the final outstanding issue...?

sage

