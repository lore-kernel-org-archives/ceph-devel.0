From: Sage Weil <sage@newdream.net>
Subject: Re: rbd
Date: Fri, 13 May 2011 12:11:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105131208450.12286@cobra.newdream.net>
References: <201105121353.44166.ufm@ufm.su> <Pine.LNX.4.64.1105120833410.19492@cobra.newdream.net>
 <Pine.LNX.4.64.1105121001160.19492@cobra.newdream.net>
 <Pine.LNX.4.64.1105130850400.12286@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41953 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab1EMTKV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2011 15:10:21 -0400
In-Reply-To: <Pine.LNX.4.64.1105130850400.12286@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Fyodor,

On Fri, 13 May 2011, Sage Weil wrote:
> On Thu, 12 May 2011, Sage Weil wrote:
> > On Thu, 12 May 2011, Sage Weil wrote:
> > > equation.  I'm running iozone on ext3 now and not having any problems.
> > 
> > I take it back.. I just reproduced a similar error on ext2:
> > 
> >                                                             random  random    
> > bkwd   record   stride                                   
> >               KB  reclen   write rewrite    read    reread    read   write    
> > read  rewrite     read   fwrite frewrite   fread  freread
> >          4194304      64    3570    3040    12640    13725
> > 
> > Error in file: Found ?aaaaaaaaaaaaaaaa? Expecting ?3838383838383838? addr 
> > 40a00000
> > Error in file: Position 2813329408 
> > Record # 42928 Record size 64 kb 
> > where 40a00000 loop 0
> > 
> > I opened a tracker issue http://tracker.newdream.net/issues/1086
> 
> Just an update: we've identified the problem but a fix is still in the 
> works.  The bio coming down is spanning an object boundary, and we're 
> having trouble getting the block layer to either not do that or to handle 
> the bio splitting properly.

Can you try the req_coll branch of 
git://ceph.newdream.net/git/ceph-client.git and see if that fixes things 
for you?  There's a memory leak fix and a fix for the split bio completion 
stuff.  If it checks out I want to send this to Linus quickly so it'll be 
included in 2.6.39 (which is imminent).

Thanks!
sage
