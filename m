From: Sage Weil <sage@inktank.com>
Subject: wip-filestore
Date: Mon, 3 Dec 2012 03:38:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212030336290.6180@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40371 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2LCLiX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 06:38:23 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sam.just@inktank.com
Cc: ceph-devel@vger.kernel.org

While playing with recovery on the plane I saw big latency spikes caused 
by draining the filestore op queue.  This patch makes it only wait for 
dequeued ops (current handed to threads) and not anything else.  Passed 
the rados suite without problems, and some basic testing on my laptop with 
lots of filestore op threads.

I remember you had a patch doing something similar a while back and 
rejected it... but I forget what the issue was?

sage

