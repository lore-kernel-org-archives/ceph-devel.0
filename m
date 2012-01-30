From: Sage Weil <sage@newdream.net>
Subject: idempotent mon commands
Date: Mon, 30 Jan 2012 10:42:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201301039050.23054@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42580 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab2A3SmX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jan 2012 13:42:23 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A18BFBC7CF
	for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2012 10:42:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5136BBC7CF
	for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2012 10:42:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

One of the failure we see in qa during osd thrashing is failure from 
commands like 'ceph osd out 2'.  A transient (say, network) error can 
prevent the ceph command from getting the reply, and when it is resent we 
get EINVAL 'already marked down' or similar.

In general, should we make these commands return success in those cases?  
Or should callers be prepared to tolerate those sorts of errors?

The in/out/down ones seem pretty straightward to me.  A tricker one is 
'ceph osd create 123', which currently fails if 123 already exists (and 
you thus do not get to use that id).  Not that we do that; the chef stuff 
will do 'ceph osd create' and a newly allocated id will be part of the 
reply.

Thoughts?
sage

