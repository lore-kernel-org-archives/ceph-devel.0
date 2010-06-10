From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: cmds segfault on pdj-fstest (ceph.git unstable)
Date: Thu, 10 Jun 2010 09:51:57 +0000 (UTC)
Message-ID: <huqcjt$khk$1@dough.gmane.org>
References: <hundgq$ums$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:40405 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703Ab0FJJwL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Jun 2010 05:52:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OMeQk-0007xd-1D
	for ceph-devel@vger.kernel.org; Thu, 10 Jun 2010 11:52:10 +0200
Received: from cust.dyn.95-152-71-88.swisscomdata.ch ([95.152.71.88])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jun 2010 11:52:10 +0200
Received: from thomas by cust.dyn.95-152-71-88.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jun 2010 11:52:10 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Wed, 09 Jun 2010 06:48:58 +0000 schrieb Thomas Mueller:

> hi
> 
> since this morning cmds segfaults on the pdj-fstest. (git rev
> 12798de37169f6561f0dc7643ca626957f7ab37e)
...
> 
> the segfault is reproducable on my machine. yesterday (git rev 
> 58fe4b8d5441982d0103817666a6d1bfdd8e04cd) this error was not present.
> 
> 
> - Thomas

tried to track down where that segfault comes from - with "git bisect" 
(my first git bisect try)

the output after a while:

2a88e2e54ee0b9449e86cec02315e2809b75ca8b is the first bad commit
commit 2a88e2e54ee0b9449e86cec02315e2809b75ca8b
Author: Greg Farnum <gregf@hq.newdream.net>
Date:   Mon Jun 7 10:04:33 2010 -0700

    add checks for being a snapshot root to dir_is_nonempty

:040000 040000 6c45c68b84800b105299133374f0f91d82948659 2c1b290125ae435679ab29d6fbab7f5b8f81e4b9 M	src

