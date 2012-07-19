From: Sage Weil <sage@inktank.com>
Subject: making objdump useful
Date: Thu, 19 Jul 2012 16:22:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207191618520.28682@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38369 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab2GSXWF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 19:22:05 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 775368133E
	for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 16:22:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 503C68133E
	for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 16:22:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I finally figured out how to make objdump interleave the source code in 
the .ko file dumps on our qa machines.  The problem is that the debug info 
refeferences the path where the kernel was compiled (which is non-obvious 
since the info is compressed).  For our environment, this is a quick 
workaround:

 sudo mkdir -p /srv/autobuild-ceph/gitbuilder.git
 sudo ln -s /path/to/your/kernel/tree /srv/autobuild-ceph/gitbuilder.git/build
 objdump -rdS whatever.ko | less

Now, to figure out why kdb freezes on the 'dmesg' command...

sage

