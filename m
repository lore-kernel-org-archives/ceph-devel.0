From: Sage Weil <sage@newdream.net>
Subject: Re: rbd layering
Date: Wed, 2 Feb 2011 09:47:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102020942240.18507@cobra.newdream.net>
References: <Pine.LNX.4.64.1101312141360.8040@cobra.newdream.net>
 <AANLkTikk_pm2JHQy5+sqSPK_vi-NYaxhUSr=YNYsUSw=@mail.gmail.com>
 <AANLkTimeL7W-1uz3m2HOJn-b-kGkLDBnOFYdhx56uFM3@mail.gmail.com>
 <AANLkTi=sAOdCZ7KeS2RJ89a4Fzjoy+NPvGrWEfG6b+y0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60343 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab1BBRqc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Feb 2011 12:46:32 -0500
In-Reply-To: <AANLkTi=sAOdCZ7KeS2RJ89a4Fzjoy+NPvGrWEfG6b+y0@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

On Tue, 1 Feb 2011, Colin McCabe wrote:
> Yehuda is probably right though... it's not 100% clear that the
> benefits outweigh the disadvantages, given that it would need an extra
> lookup for every operation. In the end it's something that probably
> will take some experimentation to get right.

Right.  The nice thing about RBD is it's simplicity: there is almost no 
metadata.  Just the block size, image size, and object name prefix.  
That's enough to name the object with the data you want, and that object 
may or may not exist, depending on whether it's been written to.  There 
are no consistency concerns.

When I mentioned allocation bitmap before, I meant simply a bitmap 
specifying whether the block exists, that would let us avoid looking for 
an object in the parent image.  In its simplest form, you would mark the 
image read-only, then generate the bitmap once.  

Anything more complicated with that and you have to worry about keeping 
the metadata consistent with the data.  CAS, for example, requires lots of 
metadata: if I want to read block 1234, I have to look up in some table 
that says 1234 has sha1 FOO, and then go read that object.  Then writing 
is a whole other story.  Again, doing CAS on a read-only image simplifies 
things greatly, but I don't think we should go down that road now.

Mainly I'm interested in feedback on the simple layering use-case...

sage
