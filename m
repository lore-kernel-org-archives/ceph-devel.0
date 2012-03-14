From: Sage Weil <sage@newdream.net>
Subject: Re: mount via ceph-fuse is failing
Date: Wed, 14 Mar 2012 09:35:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203140932510.7068@cobra.newdream.net>
References: <loom.20120309T081725-352@post.gmane.org>
 <Pine.LNX.4.64.1203090819310.11669@cobra.newdream.net>
 <loom.20120309T173712-992@post.gmane.org> <loom.20120314T060720-796@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55524 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab2CNQfh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Mar 2012 12:35:37 -0400
In-Reply-To: <loom.20120314T060720-796@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 14 Mar 2012, madhusudhana wrote:
> > > 
> > I sm running CentOS 5.6 with 3.0.9 version
> > 
> > [root <at> ceph-node-5 ~]# uname -a
> > Linux ceph-node-5 3.0.9 #3 SMP Tue Feb 21 16:59:41 IST 2012 x86_64 x86_
> 64 x86_64 
> > GNU/Linux
> > 
> > Below is fuse version
> > [root <at> ceph-node-5 ~]# ceph-fuse -V
> > ceph-fuse[29094]: starting ceph client
> > ceph-fuse[29094]: starting fuse
> > FUSE library version: 2.7.4
> > fusermount version: 2.7.4
> 
> Sage
> any issue with the fuse client ? any solution for me for resolving
> above error ?

I just pushed something to the 'next' branch that lets you disable this 
option with --no-fuse-big-writes.  That should resolve your problem.

sage
