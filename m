From: Sage Weil <sage@inktank.com>
Subject: poll/sendmsg problem with 3.5.0-37-generic #58~precise1-Ubuntu
Date: Mon, 12 Aug 2013 21:34:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308122111030.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36621 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab3HMEe5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Aug 2013 00:34:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kernel-team@lists.ubuntu.com
Cc: ceph-devel@vger.kernel.org

Hi,

A ceph user hit a problem with the 3.5 precise kernel with symptoms 
exactly like an old poll(2) bug[1].  Basically, one end of a socket is 
blocked on sendmsg(2), and the other end is blocked on poll(2) waiting for 
data.  15 minutes later the poll(2) timeout triggers, we reset the 
connection, and ceph recovers and continues.  (For this user, the visible 
ceph symptoms were stuck peering, stuck recovery, or hung requests that 
*eventually* cleared themselves up.)

In this case, it doesn't look like the 3.5.0-37 kernel has the old 
problematic patch (which first appeared in 3.6-rc1 and was fixed before 
3.6 was released), but we see the exact same behavior (blocked writer, 
blocked reader/poller, but netstat showing bytes available on the socket), 
and upgrading the kernel to the current 3.8 precise package resolved the 
problem.  The 3.5 ubuntu kernel does have a few sendmsg patches[2] that 
(under the circumstances) appear suspicious.

The one other detail in this case is that it seemed to only crop up 
connections involving one node in the system.

I'm not sure where to go from here, since the user is happy to now have a 
working system, and I'm not sure if it is worth spending the time to 
reproduce the issue.  It might be simpler to just recommend users move off 
the 3.5 kernel.  In the meantime, though, I wanted to at least make 
everyone aware of the (potential) problem.

sage


[1] http://marc.info/?l=ceph-devel&m=134540224811321&w=2
[2] https://launchpad.net/ubuntu/+source/linux-lts-quantal/3.5.0-37.58~precise1
