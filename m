From: Sage Weil <sage@inktank.com>
Subject: wip-hint
Date: Sun, 23 Feb 2014 07:45:07 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402230742470.17508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54929 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaBWPpI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Feb 2014 10:45:08 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sam.just@inktank.com, yehuda@inktank.com
Cc: ceph-devel@vger.kernel.org

Hey Sam, Yehuda,

Can you take a final look at https://github.com/ceph/ceph/pull/1284?

Yehuda, you mentioned wanting to make the hint op as general as possible.  
This bit is only addressing the allocation piece, and there is room in the 
args struct to add additional fields (so far 0 means 'not 
specified/undefined'), but I'm not sure if that captures your concerns.

Thanks!
sage


