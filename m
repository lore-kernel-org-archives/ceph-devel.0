From: Sage Weil <sage@newdream.net>
Subject: Re: timed out in osd1 error in dmes
Date: Thu, 15 Mar 2012 08:47:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203150846180.21671@cobra.newdream.net>
References: <loom.20120313T083325-276@post.gmane.org> <4F5FACD8.8090902@dreamhost.com>
 <loom.20120314T051739-894@post.gmane.org> <Pine.LNX.4.64.1203141057030.11925@cobra.newdream.net>
 <loom.20120315T084452-832@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51534 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031252Ab2COPrH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Mar 2012 11:47:07 -0400
In-Reply-To: <loom.20120315T084452-832@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

> > These are harmless noise, BTW, you can ignore them.
> > 
> > Can you tell us how your OSDs are configured?  Where are the data 
> > directories and journals located?  (The [osd] section of ceph.conf would 
> > be helpful.)

Can you share your ceph.conf please?

> > Another useful piece of information would be the ceph-osd's raw 
> > performance writing to the local disk+journal, which you can get with
> > 
> >  $ ceph tell osd.0 bench
> > 
> > You might want to check it for several nodes to see if it's consistent, 
> > etc.
> > 
> Below are the results from above command run against all osd's
> 
> 
> 2012-03-15 13:06:19.980924 osd.0 -> 'bench: wrote 1024 MB in blocks of 
> 4096 KB in 67.474949 sec at 15540 KB/sec' (0)
> 2012-03-15 13:09:20.573176 osd.1 -> 'bench: wrote 1024 MB in blocks of 
> 4096 KB in 70.815932 sec at 14807 KB/sec' (0)
> 2012-03-15 13:11:57.895738 osd.2 -> 'bench: wrote 1024 MB in blocks of 
> 4096 KB in 60.370233 sec at 17369 KB/sec' (0)

This is pretty slow, and probably due to the way your osd journals are 
configured.  Please share your ceph.conf!

Thanks-
sage
