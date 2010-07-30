From: Sage Weil <sage@newdream.net>
Subject: Re: client-standalone/master-backport: "CEPH_VERSION" redefined
Date: Fri, 30 Jul 2010 10:50:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007301048490.28085@cobra.newdream.net>
References: <i2u3ju$hnt$2@dough.gmane.org> <Pine.LNX.4.64.1007300944210.28085@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51589 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932673Ab0G3Rrv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 13:47:51 -0400
In-Reply-To: <Pine.LNX.4.64.1007300944210.28085@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Fri, 30 Jul 2010, Sage Weil wrote:
> > what is the worklfow in client-standalone - not unstable to master? which 
> > one should be used for testing?
> 
> I have a script that mirrors just the commits affecting fs/ceph in the 
> kernel git tree (http://pastebin.org/433717), so the -standalone.git 
> unstable matches the ceph-client.git unstable branch.  Generally I don't 
> bother cleaning up and rebasing the unstable tree there until it's time to 
> send things upstream for the merge window or there is some other specific 
> reason to.  I'll do that as soon as 2.6.35 is out.  In the meantime, you 
> should be able to merge the -standalone.git unstable into master-backport 
> with minimal pain.

I just did a rebase and some cleanup for the merge window.  It'll get 
rebased once more after 2.6.35.

And the CEPH_VERSION warning can be ignored... it'll go away soon!

sage
