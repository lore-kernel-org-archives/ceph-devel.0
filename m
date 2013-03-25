From: Sage Weil <sage@inktank.com>
Subject: Re: crush changes via cli
Date: Sun, 24 Mar 2013 17:04:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303241629400.1736@cobra.newdream.net>
References: <alpine.DEB.2.00.1303221528240.18669@cobra.newdream.net> <CAPYLRzg2YUVBEL8oJ_N02w1dHwy7a9jpCAVkcRq8AhmyUMnuGw@mail.gmail.com> <alpine.DEB.2.00.1303221554130.32540@cobra.newdream.net> <43BCE0F438AB4C22AEEEFEDCD165068B@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41148 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab3CYAEZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 Mar 2013 20:04:25 -0400
In-Reply-To: <43BCE0F438AB4C22AEEEFEDCD165068B@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 24 Mar 2013, Gregory Farnum wrote:
> On Fri, Mar 22, 2013 at 3:58 PM, Sage Weil <sage@inktank.com (mailto:sage@inktank.com)> wrote:
> > On Fri, 22 Mar 2013, Gregory Farnum wrote:
> > > I suspect users are going to easily get in trouble without a more
> > > rigid separation between multi-linked and single-linked buckets. It's
> > > probably best if anybody who's gone to the trouble of setting up a DAG
> > > can't wipe it out without being very explicit ? so for instance "move"
> > > should only work against a bucket with a single parent.
> > > 
> > 
> > 
> > Good idea; I'll add that.
> > 
> > > Rather than
> > > defaulting to all ancestors, removals should (for multiply-linked
> > > buckets) require users to either specify a set of ancestors or to pass
> > > in a "--all" flag.
> > 
> > 'rm' only works on an empty bucket, so I'm not sure there is much danger
> > is removing all links (and the bucket) in that case?
> 
> Well, if "unlink" takes it out of the tree without requiring it to be empty then that would be one case.

Oh, right.  That's true.  I'm still not a fan of an --all flag, though.  
In almost all cases, users will have maps with only 1 link, so the 
required flag will be confusing.  It also breaks the current behavior 
(which already removes all links).

> > > Also, I suspect that "rm" actually deletes the bucket while "unlink"
> > > simply removes it from all parents (but leaves it in the tree); that
> > > distinction might need to be a little stronger (or is possibly not
> > > appropriate to leave in the CLI?).
> > > 
> > 
> > 
> > That's right. The "remove" versus "unlink" verbs make that pretty clear
> > to me, at least... Are you suggesting this be clarified in the docs, or
> > that the command set change? I think once we settle on the CLI, John can
> > make a pass through the crush docs and make sure these commands are
> > explained.
> > 
> 
> 
> That makes sense if you know the internal representation of the CRUSH 
> map; less so if you're thinking of it in terms from related fields like, 
> say, a filesystem. ;) I admit I don't have any better suggestions and 
> strong docs might be just fine, but the distinction is one that's very 
> visible to users *afterwards* but not beforehand. I'm imagining a lot of 
> crush maps with 5 unlinked parallel trees in our future.

It would be nice to make the link/unlink work for leaves too, but the 
problem is that the weight is a property of the link and not the 
target/device, so there is nothing to link 'to'.  (Buckets, OTOH, have 
actual content that is linked to, and a weight.)

> I guess mostly I'm just not sure what the use case is for keeping around 
> unlinked buckets so I'd rather keep the set of CLI options simpler. It's 
> not that hard to link a bucket into the tree where you want it and then 
> remove the other links.

Yeah, that isn't often useful in and of itself... but it is possible (and 
often required) to create independent trees, and if you can link them, you 
have to be able to unlink them.

sage
