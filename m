From: Sage Weil <sage@inktank.com>
Subject: crush changes for firefly
Date: Tue, 3 Dec 2013 15:25:59 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312031505380.32346@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46737 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab3LCXZ7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Dec 2013 18:25:59 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9E27980079
	for <ceph-devel@vger.kernel.org>; Tue,  3 Dec 2013 15:25:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7519D80079
	for <ceph-devel@vger.kernel.org>; Tue,  3 Dec 2013 15:25:59 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

https://github.com/ceph/ceph/pull/869

has a bunch of pending changes to CRUSH to support the erasure coding 
work in firefly.

The main item is that the behavior of 'choose indep' has changed 
significantly.  This is strictly speaking a change in behavior, but nobody 
should be using indep mode in a normal ceph cluster (unless they went 
manually fiddling with their crush map).

The new and improved indep does a breadth-first mapping instead of 
depth-first, which means few items shifting around when there are 
failures.  It also drops some of the cruft that fell out of the combined 
code from before.  As a bonus, the old method is now firstn-only and I was 
able to strip out a bunch of crap in the process.  Yay!

There are a few other things:

- The 'osd crush rule create-simple ..' command now takes an optional mode 
  (firstn or indep) so that it can be used for erasure pools.

- There is an 'erasure' pg pool type (existing types were 'rep' (default) 
and 'raid4' (never used or implemented)).

- New rule commands:

 step set_choose_tries N

This overrides the tunable total_tries (default is 50) for the current 
rule only.

 step set_chooseleaf_tries M

This overrides the recursive behavior when using chooseleaf.  By default, 
for indep mode, we try exactly once with the recursive call, as this 
maintains the same bound on computational complexity.  However, increasing 
this a bit (say, to 5) improves stability of the mapping a bit when 
there are devices marked out.  This lets you set it for *just* the current 
rule.

Note that for the 'firstn' mode, the default (legacy) behavior is to try 
total_tries in the recursive call, which makes the computational 
complexity proprotional to total_tries^2 (in the extreme).  If the 
'descend_once' tunable is set (now the default), then we do one attempt.. 
if we hit a reject.  Unfortunately not in the case of a collision (dup).  
But, we can't change that without breaking compatibility for existing 
rules.  To "fix" that, we can add a set_chooseleaf_tries 1 command to 
firstn rules.  It's a bit muddled, though.  :(

- CrushWrapper has a helper to detect if any of these rule commands are in 
use, and OSDMap sets the required features accordingly.

- There is a small fix for OSDMap CACHEPOOL feature detection.

Long story short: if any of this new stuff is used (and it will be 
needed for erasure pools), the new feature bit will be required and old 
clients won't be able to connect.  I think the new behavior is good.  My 
main concern is the weird interplay of the 'descend_once' tunable, which 
unfortunately wasn't implemented to mean the same as chooseleaf_tries = 1.  
I'm not sure if it's worth fixing that via _another_ tunable or not; if 
so, we could (yay) end up where set_chooseleaf_tries actually works for 
firstn the same way it does for indep, and the tunable just makes it 
default to 1 (as it does with indep).

sage
