From: Sage Weil <sweil@redhat.com>
Subject: OSDMap checksums
Date: Tue, 19 Aug 2014 15:43:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408191528070.28247@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36830 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbaHSWny (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Aug 2014 18:43:54 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 466BA8047E
	for <ceph-devel@vger.kernel.org>; Tue, 19 Aug 2014 15:43:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0E3BB8047E
	for <ceph-devel@vger.kernel.org>; Tue, 19 Aug 2014 15:43:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We have had a range of bugs come up in the past because OSDs or mons have 
been running different versions of the code and have encoded different 
variations of the same OSDMap epoch.  When two nodes in the system 
disagree about what the data distribution is, all manner of things can go 
wrong and the effects are very difficult to debug.

Several times we've said that we should be adding a crc or checksum to the 
canonical encoded OSDMap so that we'll know if we're getting the "right" 
version or not.  One could imagine in a less trusted environment this 
would be analogous to a signed version.

I've started a wip-osdmap branch to do this, but have hit a few bumps.

Generally speaking, we want only the mons (and only the leader mon) to 
ever be allowed to encode (and checksum/sign) a new OSDMap or incremental.  
(The only real exception here is that the MOSDMap message reencodes maps 
with older encoding strategies for old clients, but those old clients 
clearly won't support the new crc, so they get a free pass.)

The trouble is that in general we share maps very liberally.  More 
specifically, we share _incremental_ maps.  The incremental map will be 
encoded so that it itself has a crc, and also it has the crc of what the 
final OSDMap will have once the incremental has been applied, so that you 
can verify you got the right answer.

The problem is what to do if you don't.  This can happen for a few 
different reasons, but usually it is just that we added a field to a data 
structure that is included in the OSDMap.

The main entity affected by this is the OSDs: they store a history of 
incremntal maps *and* full maps, and share full and incremental maps with 
clients and peers.  We don't want them to ever share a full map that did 
not match the specified crc as it might different from the canonical 
version in some subtle (but problematic) way.

A simple strategy would be to simply go back to the mons if we ever run 
into this and ask for original (full) copies of the OSDMaps whose 
encodings we got wrong.  This works, but has a few potential problems:

 - The general "upgrade mons first" strategy will mean mons will start 
generating maps that older osds can't replicate, and suddently every will 
be hammering them for full maps.
 - We could ask our peers, but there's no guarantee that they will be any 
better off.

We could:

 - Have users upgrade OSDs before mons.  That way no 'new' osdmaps will 
get generated before the osds are able to reencode them correctly.
 - Make the osd peers smarter about how they share maps with each other so 
that they can also tell when they need full maps and not just 
incrementals.

...or perhaps both.  The former avoids the problem, the latter copes with 
it.  I'm a bit unsure how to do make the latter algorithm simple (mostly 
stateless) and efficient, though.

Any other ideas?

sage
