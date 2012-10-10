From: Sage Weil <sage@inktank.com>
Subject: Re: Determining RBD storage utilization
Date: Wed, 10 Oct 2012 13:37:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210101336460.19773@cobra.newdream.net>
References: <CACkq2mr17KKvgE0tWTvfs0UqpwtBaEMo84Twfs+26duUmC62Mw@mail.gmail.com> <CAFtEh-fk1NHEOnmnG1aHpZhiNjApqyrsJOhrTrg9nWKxAiXG2Q@mail.gmail.com> <CAPYLRzja7=nnk4pp0=YGL4AhxVKdnM91U1W4GD5qcoORw+oKDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39735 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180Ab2JJUh3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 16:37:29 -0400
In-Reply-To: <CAPYLRzja7=nnk4pp0=YGL4AhxVKdnM91U1W4GD5qcoORw+oKDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Damien Churchill <damoxc@gmail.com>, Travis Rhoden <trhoden@gmail.com>, ceph-devel@vger.kernel.org

On Wed, 10 Oct 2012, Gregory Farnum wrote:
> I don't know the ext4 internals at all, but filesystems tend to
> require allocation tables of various sorts (for managing extents,
> etc). 7.5GB out of 500GB seems a little large for that metadata, but
> isn't ridiculously so...

ext3/4 are particularly bad about this, with lots of space statically set 
aside for inodes and allocation metadata.

s


> 
> On Wed, Oct 10, 2012 at 10:28 AM, Damien Churchill <damoxc@gmail.com> wrote:
> > On 10 October 2012 18:10, Travis Rhoden <trhoden@gmail.com> wrote:
> >> Additionally, 500G - 7.5G != 467G (the number shown as Avail).  Why
> >> the huge discrepancy?  I don't expect the numbers to add up exact due
> >> to rounding from kB, MB, GB, etc, but they should be darn close, a la
> >
> > ext4 keeps some reserved space, 5% by default, for when the disk is
> > full so you are still able to use the filesystem and clean it up.
> >
> > 500G * 0.05 = 25G
> > 500G - (25G + 7.5G) = 467G
> >
> > Can't tell you where the 7.5G comes from though!
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
