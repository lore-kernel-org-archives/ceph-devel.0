From: Sage Weil <sage@inktank.com>
Subject: changing osd capability semantics
Date: Thu, 14 Jun 2012 10:05:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206140958010.23137@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59134 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab2FNRFh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jun 2012 13:05:37 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D9960BC7BD
	for <ceph-devel@vger.kernel.org>; Thu, 14 Jun 2012 10:05:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 31364BC7BD
	for <ceph-devel@vger.kernel.org>; Thu, 14 Jun 2012 10:05:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The current osd capabilities do a few things that, in retrospect, are more 
complex than is necessary or desired.  In particular, the current 
implementation allows

	allow rwx, deny pool blah rwx

The deny stuff is confusing to understand (it's ordering dependent), and 
not used by anything (that we know of).

There is also an idea of 'default permissions' on pools that you own.  For 
example, if you have a blank capability, and create a pool 'foo' owned by 
your auid, then you (by default) get rwx permissions.  Unless the cap says 
otherwise, like

	allow pool foo rw
	allow auid 123 rw

This is also sneaky and confusing.  You can get equivalent functionality 
with an explicit cap like

	allow auid 123 rwx

The current implementation is also awkward to maintain and understand in 
terms of grants. 

So: there's a new implementation in wip-osdcap that removes 'deny' and the 
default caps thing, has a well-defined grammar, and a simpler 
implementation.  See

	https://github.com/ceph/ceph/commits/wip-osdcap

The danger is merging this is that someone out there has dived into the 
old and documented caps code and started using the deny or default cap 
functionality.  This is your fair warning!  If you're using deny, you 
probably shouldn't, and if you're using the default caps, you need to 
adjust them to explicitly allow access to pools you create.

sage
