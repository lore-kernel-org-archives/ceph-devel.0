From: Sage Weil <sage@inktank.com>
Subject: daily stand-ups / weekly meetings
Date: Thu, 2 Jan 2014 12:46:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401021230460.14184@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60958 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbaABUq3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jan 2014 15:46:29 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 352D980049
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jan 2014 12:46:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0C79D80049
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jan 2014 12:46:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

We've been doing daily stand-ups for various ceph components for a while 
now.  These have been historically attended by Inktank engineers, but for 
a while now we've been looping in other developers.  To make this all more 
transparent, the kraken IRC bot in #ceph-devel (irc.oftc.net) is now 
announcing the standups when they start.  If you are interested in 
joining, you can ping the participants on IRC to get the Google hangout 
URL.

The current standups are:

 17:45 UTC /  9:45 PST: RGW and RBD
 18:00 UTC / 10:00 PST: teuthology and build
 18:15 UTC / 10:15 PST: rados/core

We need to schedule a CephFS standup as well; I'll send a separate email 
about that.

If there are any other subjects that deserve a daily or weekly online 
meeting (like the teuthology weeklies that have been happening) we may as 
well schedule those with kraken as well so that they are announced in the 
channel.  For example, we may want a daily or weekly meeting about 
Chef/Puppet/* orchestration activities, cloud stack integrations, or 
whatever else.  Suggestions welcome!

You can get the current schedule from kraken by saying

 kraken reminders list

in #ceph-devel.

sage
