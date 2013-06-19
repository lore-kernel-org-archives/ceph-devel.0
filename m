From: Sage Weil <sage@inktank.com>
Subject: recent osd changes
Date: Wed, 19 Jun 2013 13:04:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306191259430.6742@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54620 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935092Ab3FSUEV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 16:04:21 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 82F79803BB
	for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 13:04:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 59AD5803BB
	for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 13:04:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The OSDs used to only heartbeat on teh cluster interface.  Since they 
actually talk to clients on the public interface this didn't detect 
certain assymetrical network failures; this was fixed in the last release.

We also fixed a long-standing isue where the failure of the backend 
network would cause an OSD to be marked down, but it would mark itself 
back up by talking to the mon on the public interface.  It now verifies 
that the backend network is working (by pinging random other osds) before 
marking itself back up to avoid the problem.

The last change was a more robust writeback model.  We have a general 
problem where we are journaling writes and then applying them to the file 
system, but the two devices/targets may go at different speeds.  We don't 
want to journal to get too far ahead of the fs or else request latency 
become erratic/bursty and the eventual fs commit can take a very long 
time.  Sam put togther a simple model of how much work the fs has pending 
for the next commit (based on dirty bytes, dirty files, dirty inodes) and 
bases throttling decisions on that instead of the very rough limits that 
used to be in place.  This resolves many 'slow request' warnings and even 
OSD failures (due to op_tp timeouts from very deep queues) on certain 
torturous workload (ffsb).

sage
