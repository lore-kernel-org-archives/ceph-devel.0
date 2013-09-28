From: Sage Weil <sage@inktank.com>
Subject: wip-cache-crc
Date: Fri, 27 Sep 2013 21:14:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309272112270.12714@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58611 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab3I1EOQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Sep 2013 00:14:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sam.just@inktank.com, mark.nelson@inktank.com
Cc: ceph-devel@vger.kernel.org

It's working well on my box.  I modified the crc32c methods to optionally 
take a null data pointer, in which case they behave as if it were 
zero-filled.  For the sctp code this speeds it up by almost 2x.  Overall, 
it's looking pretty good!

The one missing piece is that the intel optimized assembler code needs to 
be modified to handle the null buffer case before this can be merged.  (As 
is it will just crash if sse4.2 is there.)

sage

