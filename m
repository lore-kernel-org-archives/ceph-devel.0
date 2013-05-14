From: Sage Weil <sage@inktank.com>
Subject: zero-copy bufferlists
Date: Tue, 14 May 2013 09:25:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305140922380.26786@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59599 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab3ENQZV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 12:25:21 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 44F45800BA
	for <ceph-devel@vger.kernel.org>; Tue, 14 May 2013 09:25:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 14A1F800BA
	for <ceph-devel@vger.kernel.org>; Tue, 14 May 2013 09:25:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I wrote up a quick blueprint

  http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/zero-copy_bufferlists

on extending bufferlists to do zero-copy between kernel/userspace using 
splice(2) and friends.  This should be a fun piece of work that is 
relatively self-contained and has potentially significant performance 
payout.

There is also the possibility of taking the result and building a 
shared library out of it that other projects can consume.  Ceph's 
bufferlists are pretty cool IMHO, and having working zero-copy support 
on Linux would make them even cooler.

sage
