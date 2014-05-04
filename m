From: Sage Weil <sage@inktank.com>
Subject: wip-objecter
Date: Sat, 3 May 2014 21:00:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405032057260.30728@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50527 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbaEDEAd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 May 2014 00:00:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yehuda@inktank.com
Cc: ceph-devel@vger.kernel.org

Hey Yehuda,

I merged the objecter branch into master and then reassembled the patch 
series so that all of the support bits are separate patches and there is 
just one commit that has all of the actual objecter changes.  See 
wip-objecter.  Hopefully this will make it easier to work with.

IIRC the remaining piece, besides general testing/reivew, is op 
cancellation?  And understanding what is causing Sushma's performance 
discrepancy...

sage

