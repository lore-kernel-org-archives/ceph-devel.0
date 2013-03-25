From: Sage Weil <sage@inktank.com>
Subject: Re: crush changes via cli
Date: Mon, 25 Mar 2013 12:46:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303251135330.12444@cobra.newdream.net>
References: <alpine.DEB.2.00.1303221528240.18669@cobra.newdream.net> <CAPYLRzg2YUVBEL8oJ_N02w1dHwy7a9jpCAVkcRq8AhmyUMnuGw@mail.gmail.com> <alpine.DEB.2.00.1303221554130.32540@cobra.newdream.net> <43BCE0F438AB4C22AEEEFEDCD165068B@inktank.com>
 <alpine.DEB.2.00.1303241629400.1736@cobra.newdream.net> <CAPYLRzi4z1BMnhkENLyOoBRsDCcbsrnj5_bw+6CrWbP1Pws5NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51058 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932858Ab3CYTqV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 15:46:21 -0400
In-Reply-To: <CAPYLRzi4z1BMnhkENLyOoBRsDCcbsrnj5_bw+6CrWbP1Pws5NA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 24 Mar 2013, Gregory Farnum wrote:
> On Sun, Mar 24, 2013 at 5:04 PM, Sage Weil <sage@inktank.com> wrote:
> > On Sun, 24 Mar 2013, Gregory Farnum wrote:
> >> On Fri, Mar 22, 2013 at 3:58 PM, Sage Weil <sage@inktank.com (mailto:sage@inktank.com)> wrote:
> >> > On Fri, 22 Mar 2013, Gregory Farnum wrote:
> >> > > I suspect users are going to easily get in trouble without a more
> >> > > rigid separation between multi-linked and single-linked buckets. It's
> >> > > probably best if anybody who's gone to the trouble of setting up a DAG
> >> > > can't wipe it out without being very explicit ? so for instance "move"
> >> > > should only work against a bucket with a single parent.
> >> > >
> >> >
> >> >
> >> > Good idea; I'll add that.
> >> >
> >> > > Rather than
> >> > > defaulting to all ancestors, removals should (for multiply-linked
> >> > > buckets) require users to either specify a set of ancestors or to pass
> >> > > in a "--all" flag.
> >> >
> >> > 'rm' only works on an empty bucket, so I'm not sure there is much danger
> >> > is removing all links (and the bucket) in that case?
> >>
> >> Well, if "unlink" takes it out of the tree without requiring it to be empty then that would be one case.
> >
> > Oh, right.  That's true.  I'm still not a fan of an --all flag, though.
> > In almost all cases, users will have maps with only 1 link, so the
> > required flag will be confusing.  It also breaks the current behavior
> > (which already removes all links).
> 
> I was thinking that if there was only one link it would remove that
> one. I didn't realize it currently removed all links ? although I
> dimly remember a bug about just randomly taking the first one it
> finds. Is that new-ish behavior?

As far as I can tell it has always removed all instances.

> >> I guess mostly I'm just not sure what the use case is for keeping around
> >> unlinked buckets so I'd rather keep the set of CLI options simpler. It's
> >> not that hard to link a bucket into the tree where you want it and then
> >> remove the other links.
> >
> > Yeah, that isn't often useful in and of itself... but it is possible (and
> > often required) to create independent trees, and if you can link them, you
> > have to be able to unlink them.
> 
> Currently we just have "rm", right? And that removes the link and the
> bucket? Can't we just keep "rm" and for multiply-linked buckets
> require a specification of which ancestor to remove the link from (or
> a --all flag), and then delete the bucket when the final link is
> removed?

That would change current "rm" behavior.  (Even with the ancestor, it then 
removes all instances under that ancestor, so the '--all' for multiples is 
weird.)

Removing the bucket only when all instances is removed (and not when the 
users asks for it) is more confusing, IMO.  If they want to keep the 
bucket, unlink (and don't worry if it is empty or not). If they don't, 
rm, and get ENOTEMPTY if there are still children.

Unless there are other strong opinions here, I'm inclined to merge this as 
is.

sage
