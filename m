From: Sage Weil <sage@newdream.net>
Subject: Re: ceph tree in linux-next
Date: Sat, 3 Mar 2012 14:27:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203031425270.15834@cobra.newdream.net>
References: <Pine.LNX.4.64.1203022138440.15833@cobra.newdream.net>
 <20120303182241.bbdb98825505b8632c742942@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40443 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab2CCW1T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Mar 2012 17:27:19 -0500
In-Reply-To: <20120303182241.bbdb98825505b8632c742942@canb.auug.org.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ceph-devel@vger.kernel.org

On Sat, 3 Mar 2012, Stephen Rothwell wrote:
> Hi Sage,
> 
> On Fri, 2 Mar 2012 21:41:00 -0800 (PST) Sage Weil <sage@newdream.net> wrote:
> >
> > The Ceph kernel tree has moved[1], and we've reworked the way we're 
> > managing commits in our tree.  Can you update linux-next to pull from
> > 
> > 	git://github.com/ceph/ceph-client.git#master
> > 
> > That'll ensure that anything we've tested and reviewed gets into -next 
> > without us having to remember to push a for-next branch.
> 
> Well, I can't really use your master branch because it has 3 commits on
> the top of it that modify btrfs and are also not signed and do not look
> like they are destined for Linus.
> 
> I need a clean branch that contains only what you will be sending to Linus.

Yeah, it works better if I update the branch first.  We switched over to 
the testing branch for review and qa a while back but forgot to reset 
master.  It's clean now.

Thanks!
sage
