From: Sage Weil <sage@inktank.com>
Subject: mon caps
Date: Wed, 19 Jun 2013 13:15:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306191309500.7285@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54742 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756847Ab3FSUP4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 16:15:56 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5E274803BB
	for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 13:15:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 3041B803BB
	for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 13:15:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A huge pile of changes to the mon and CLI has recently landed in master 
and will reach users for the first time in v0.65.  This includes, among 
other things, a complete (!) 'ceph -h' usage dump and (real soon now) 
super-smart bash completion.  All of this is part of changes in the 
admin/mon protocol to support the REST management API endpoint which will 
arrive in dumpling.

Other nice bits of this include:

 ceph daemon osd.0 ...
instead of
 ceph --admin-daemon /var/run/ceph/ceph-osd.0.asok ...

and

 ceph tell mon.\* ...
 ceph tell osd.\* ...
instead of
 ceph mon tell \* ...
 ceph osd tell \* ...

One of the changes that came along with this, though, is that the syntax 
of the mon 'caps' changed.  In short, daemons now have mon caps that look 
like 'allow profile osd' or 'allow profile bootstrap-osd' instead of the 
explicit and more confusing values they had before.  This shouldn't affect 
any normal users (the caps are auto-converted when you upgrade the mons), 
but if you are have written your own custom scripts that have been 
creating keys and auth entries manually (e.g., to do something like 
'allow command foo ...') they may need to be updated.

These changes are all included in v0.65.  Get ready!

sage
