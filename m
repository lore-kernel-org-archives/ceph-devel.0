From: Sage Weil <sage@newdream.net>
Subject: this week
Date: Mon, 2 May 2011 10:05:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105020958020.27932@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54975 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab1EBRF3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 May 2011 13:05:29 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E8F6DBC69C
	for <ceph-devel@vger.kernel.org>; Mon,  2 May 2011 10:05:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id BD6C4BC69C
	for <ceph-devel@vger.kernel.org>; Mon,  2 May 2011 10:05:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I won't make the meeting this morning.  I did take a look at the tracker 
though and adjusted a few priorities, which should really dictate what 
we're working on.  They are:

- osd refactor.  need to get this pushed to a branch in some form or 
another soon so we can start reviewing it.

- osd failure tests in autotest.  we need to establish a baseline and have 
this ready so we can start hammering the new peering code immediately.

- obsync.  other teams  will soon be blocking on it.

That's it!  I'll be available after lunch through most of the afternoon.

sage
