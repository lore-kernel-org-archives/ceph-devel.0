From: Sage Weil <sage@inktank.com>
Subject: auth settings
Date: Wed, 13 Jun 2012 08:54:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206130839450.25437@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36374 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab2FMPyl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jun 2012 11:54:41 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 55685BC670
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jun 2012 08:54:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 30691BC670
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jun 2012 08:54:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The wip-auth branch has a revamp of the authentication settings. 
Currently, there is a single option, 'auth supported', which is an ordered 
list of authentication methods (cephx or none) to use.  This is somewhat 
limiting

This branch replaces that with 3 new settings:

 auth cluster required -- authentication method(s) required between ceph
    cluster daemons (e.g., mds to mds, mds to mon, etc.)
 auth service required -- auth method(s) required by daemons of clients
 auth client required  -- what clients require of daemons

This lets you do a few things:

 - Require the cluster to internally use authentication, so that nobody can
   impersonate an osd or monitor.  You could still leave auth off for clients
   if you don't want to deal with distributing keys to users.
 - Make the cluster require that clients authentication, but let the clients  
   connect to whatever.

For compatibility, the idea is that these are all blank by default, and in 
that case default to the deprecated 'auth supported' option that many are 
already using to enable cephx across the board.  

There's also some preliminary docs on what cephx gets you and what it 
doesn't, and on how to enable authentication on a cluster without it.

This gets us one step closer to enabling auth by default...

sage
