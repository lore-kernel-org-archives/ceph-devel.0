From: Sage Weil <sage@inktank.com>
Subject: firefly timing
Date: Mon, 3 Feb 2014 08:21:09 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402030819030.6345@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55043 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbaBCQVJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2014 11:21:09 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: james.page@ubuntu.com

The original firefly freeze date was Jan 17, but I added another sprint 
because there were several things that weren't quite ready yet (the cache 
tier code and erasure coding).  Two weeks later we are much closer, but 
the EC functionality still needs a bit more time.  I would like to push 
out the freeze by one more sprint so that all of the code can land.  In 
particular, I would rather use the next sprint to get EC ready and shift 
other development focus to stability early, instead of pulling last-minute 
stuff in after the freeze date.

This bends/breaks the 'train model' schedule we are aiming for, but my 
assumption is that people are more interested in seeing the new 
functionality in place than in the exact timing.

The only time dependency that I am aware of is the looming 14.04 freeze 
date.  I'm hoping that we can (worst case) put an -rc release in place and 
update as the code stabilizes over the next several weeks.  James, will 
this be problematic?

Does anybody else have questions or concerns about adding in another 
sprint before we freeze for firefly?

Thanks- 
sage

