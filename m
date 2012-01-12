From: Sage Weil <sage@newdream.net>
Subject: Ceph status update
Date: Thu, 12 Jan 2012 12:53:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201121239210.613@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59648 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab2ALUxs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 15:53:48 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 880D0BC60D
	for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 12:53:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 02978BC60D
	for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 12:53:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is just a quick status update to let everyone know where the project 
is at right now.

We had an extended bugfixing sprint over the holidays and v0.40 will be 
out tomorrow.

v0.41 will be two weeks, and the focus now (and for the near future) is 
entirely on rados (osd, monitor) and rgw.  If you have problems with the 
MDS, we'd like to gather all the important information to record in the 
bug tracker, but we don't want to lose focus on the other issues 
just yet.

The main things on our plate right now:

 - finishing the OSD 'backfill' code, which improves OSD recovery 
   efficiency.
 - extending rados with efficient key/value objects
 - better visibility into OSD and client performance
 - plan for better handling future upgrades in non-disruptive fashion
 - getting our huge pile of new QA hardware online and usable!

Next sprint will include

 - new and improved (efficient) osd scrub
 - limit msgr connections (avoid fd starvation)

Notable things we're deferring a bit...

 - rbd layering... :(
 - chef/juju/udev integration, and other improvements in daemon configuration, 
   start, stop, etc.

I'm probably missing something, but those are the highlights.  I'm going 
to start sending these emails out on a more regular basis (every sprint) 
so keep people in the loop!

sage
