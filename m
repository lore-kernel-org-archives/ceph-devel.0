From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Re: TOO SLOW data write speed and delete.. NEED HELP
Date: Wed, 14 Mar 2012 17:05:35 +0000 (UTC)
Message-ID: <loom.20120314T180310-823@post.gmane.org>
References: <loom.20120313T113524-750@post.gmane.org> <4F5FA114.7070806@gmail.com> <loom.20120314T052312-964@post.gmane.org> <5BBEBFD4-B55F-4B62-A6A9-03BD4652B07C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42712 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756209Ab2CNRFt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Mar 2012 13:05:49 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S7rdy-0001Ca-Bv
	for ceph-devel@vger.kernel.org; Wed, 14 Mar 2012 18:05:46 +0100
Received: from Static-152.106.96.14.tataidc.co.in ([Static-152.106.96.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 14 Mar 2012 18:05:46 +0100
Received: from madhusudhana.u.acharya by Static-152.106.96.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 14 Mar 2012 18:05:46 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> I am yet to fully understand Ceph's behavior, thus you should not take my word 
on it, but I believe Ceph will
> automatically take snapshots as a checkpointing mechanism. So, until someone 
(*looks at Sage*)
> declares I am completely and utterly wrong, I'm going with that assumption.
> 
> Also, I am not sure if the slowdown you're suffering is Btrfs-related, but 
just in case...
> 
> > 
> > One more concern is 'rm' command is also TOO slow. I am a newbie here and 
> > i don't know to much about ceph working. I configured it in a simple way.
> > Install ceph and run mkcephfs and start ceph in all the servers in the 
> > cluster.
> > 
> > I want to understand why basic operations like 'cp' and 'rm' are slow bcz 
> > my actual workload does a lot of copy and delete operation. If I find the
> > reason for the slowness and get a fix, then I think i can better compare and 
> > complete my ceph evaluation. 
> 
> My follow up questions: 
> 
> - Are you copying into Ceph? From within Ceph, into Ceph? Or are you simply 
copying from Ceph to somewhere else?
Am copying data from a linux machine to ceph. Bot cp and rsync are really
really slow
> 
> - Under which conditions do these slowdowns happen? Are you performing *a lot* 
of cp's / rm's in a short
> amount of time?
Its doesn't matter whether i am doing cp/rm in a short. Whenever i run those 
commands they run really slow.
> 
> Cheers,
> Joao
 




