From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Re: mount via ceph-fuse is failing
Date: Wed, 14 Mar 2012 17:20:38 +0000 (UTC)
Message-ID: <loom.20120314T181855-258@post.gmane.org>
References: <loom.20120309T081725-352@post.gmane.org> <Pine.LNX.4.64.1203090819310.11669@cobra.newdream.net> <loom.20120309T173712-992@post.gmane.org> <loom.20120314T060720-796@post.gmane.org> <Pine.LNX.4.64.1203140932510.7068@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50536 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030435Ab2CNRU7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Mar 2012 13:20:59 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S7rsc-000491-Ra
	for ceph-devel@vger.kernel.org; Wed, 14 Mar 2012 18:20:54 +0100
Received: from Static-152.106.96.14.tataidc.co.in ([Static-152.106.96.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 14 Mar 2012 18:20:54 +0100
Received: from madhusudhana.u.acharya by Static-152.106.96.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 14 Mar 2012 18:20:54 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


> > Sage
> > any issue with the fuse client ? any solution for me for resolving
> > above error ?
> 
> I just pushed something to the 'next' branch that lets you disable this 
> option with --no-fuse-big-writes.  That should resolve your problem.
> 
> sage
Thank you sage. I will give that a try and will report if there is any issue
I also would like to know what the best way to upgrade ceph cluster from 0.39 to 
0.43 ?

 




