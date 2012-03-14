From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Re: mount via ceph-fuse is failing
Date: Wed, 14 Mar 2012 05:07:55 +0000 (UTC)
Message-ID: <loom.20120314T060720-796@post.gmane.org>
References: <loom.20120309T081725-352@post.gmane.org> <Pine.LNX.4.64.1203090819310.11669@cobra.newdream.net> <loom.20120309T173712-992@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51107 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208Ab2CNFIL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Mar 2012 01:08:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S7gRU-0003BM-9y
	for ceph-devel@vger.kernel.org; Wed, 14 Mar 2012 06:08:08 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 14 Mar 2012 06:08:08 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 14 Mar 2012 06:08:08 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> > 
> I sm running CentOS 5.6 with 3.0.9 version
> 
> [root <at> ceph-node-5 ~]# uname -a
> Linux ceph-node-5 3.0.9 #3 SMP Tue Feb 21 16:59:41 IST 2012 x86_64 x86_
64 x86_64 
> GNU/Linux
> 
> Below is fuse version
> [root <at> ceph-node-5 ~]# ceph-fuse -V
> ceph-fuse[29094]: starting ceph client
> ceph-fuse[29094]: starting fuse
> FUSE library version: 2.7.4
> fusermount version: 2.7.4

Sage
any issue with the fuse client ? any solution for me for resolving
above error ?



