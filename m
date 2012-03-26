From: Sage Weil <sage@newdream.net>
Subject: osd shutdown notification
Date: Mon, 26 Mar 2012 12:36:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203261228050.19530@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43050 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab2CZTg3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 15:36:29 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 41858BC795
	for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 12:36:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1DC21BC795
	for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 12:36:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently when you shutdown/kill a ceph-osd it is no different from it 
crashing: you have to wait N seconds for its peers to conclude the process 
is down before the OSD is deemed 'failed' and the osd map is updated.

This would be pretty easy to improve on:

 - on a clean shutdown (e.g., due to SIGTERM), we could execv a call to 
   the ceph tool to tell the monitors the osd stopped (maybe with a 
   'reason' and nice log message).

 - on an unclean shutdown (e.g., failed assert, segfault) we can
   do the same, with an appropriate message in the system log

Basically it means that is ceph-osd crashes or shuts down then it 
will normally get instantly marked down without waiting for the normal osd 
timeout to expire.

execv() is kind of ugly, but seems safer in the failure cases, where you 
can't trust the existing MonClient to be operational.  

Alternatively, some external wrapper could watch for the process to 
terminate and notify the cluster, but this would be a bit more difficult 
to implement, because that notification needs to uniquely identify the 
process instance (e.g., via the cluster addr), and we'd need some way for 
it to wait for the osd to join and then extract that id, etc.

Thoughts?

sage


