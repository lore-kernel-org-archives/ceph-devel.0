From: Sage Weil <sage@newdream.net>
Subject: RE: Adding a proprietary key value store to CEPH
Date: Mon, 23 Mar 2015 14:07:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503231258050.31431@cobra.newdream.net>
References: <C226B0AB34511445928D9882AA519F600A56972E@SACMBXIP03.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1502240819320.25838@cobra.newdream.net> <C226B0AB34511445928D9882AA519F600A5902F9@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42786 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbbCWVHr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 17:07:47 -0400
In-Reply-To: <C226B0AB34511445928D9882AA519F600A5902F9@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Varada Kari <Varada.Kari@sandisk.com>

Hi everyone,

I think there are good technical reasons to have a generic plugin loading 
framework.  New, experimental, or out of tree ObjectStore backends are 
one.  Another is Messenger, where it was recently noted that there is a 
compatibility issue between distro and OFED packages for IB verbs (used by 
the new XioMessenger).

My preferred approach here is a simple structure around the existing C++ 
abstract API and factory function pattern we're using for ObjectStore, 
KeyValueDB, and Messenger.  C++ ABI compatibility is fragile, so plugins 
will need to take care to use compatible build environments, but IMO that 
is a small price to pay for the minimal effort required (versus revamping 
all of these interfaces using dumbed-down C APIs).

This was discussed in some detail during the last CDS, but I admit I 
wasn't able to follow all of the points.  If I'm missing something 
important, please chime in!

Varada, I'm happy to go over in detail what I have in mind.  (I *think* it 
will be quite simple; hopefully I'm not missing any gotchas.)


As for the specific question of linking to a proprietary plugin using this 
mechanism, I am not a lawyer and in any case don't have any legal opinion 
to express.

I can say that my intention and expectation when originally choosing LGPL 
was that non-GPL code could exist both above and below Ceph in the stack.

It is also my opinion now, given everything I have seen over the last ten 
years, is that any closed source or out of tree backend is likely to be 
technically crippled by that decision and will prove to be more difficult 
to support.  Solutions are easier to develop, test, and support when they 
are open source, and I challenge organizations who feel they need to 
protect their secret sauce to get over themselves and focus on making the 
best possible solution for their customers.  For example, supporting an 
OSD backend based on f2fs (which is upstream in Linux) would make any 
testing and bug discussions with Ceph engineers--whomever they are 
employed by--much easier than with a closed library.  For what it's worth, 
given what I've seen so far from SanDisk in terms of their expertise and 
open approach to date with Ceph, the protection of IP around a key/value 
interfaces for their flash does not strike me as critical to success.  :)

Thanks!
sage
