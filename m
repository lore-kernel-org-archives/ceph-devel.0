From: Sage Weil <sage@inktank.com>
Subject: Re: Very unbalanced storage
Date: Fri, 31 Aug 2012 09:43:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208310943170.2525@cobra.newdream.net>
References: <50409BDC.5010006@gmail.com> <5040D179.5000008@aktzero.com> <alpine.DEB.2.00.1208310908520.1531@cobra.newdream.net> <5040E532.6040306@aktzero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47350 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab2HaQn1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 12:43:27 -0400
In-Reply-To: <5040E532.6040306@aktzero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Thompson <andrewkt@aktzero.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 31 Aug 2012, Andrew Thompson wrote:
> On 8/31/2012 12:10 PM, Sage Weil wrote:
> > On Fri, 31 Aug 2012, Andrew Thompson wrote:
> > > Have you been reweight-ing osds? I went round and round with my cluster a
> > > few days ago reloading different crush maps only to find that it
> > > re-injecting a crush map didn't seem to overwrite reweights. Take a look
> > > at `ceph osd tree` to see if the reweight column matches the weight
> > > column. 
> > Note that the ideal situation is for reweight to be 1, regardless of what
> > the crush weight is.  If you find the utilizations are skewed, I would
> > look for other causes before resorting to reweight-by-utilization; it is
> > meant to adjust the normal statistical variation you expect from a
> > (pseudo)random placement, but if the variance is high there is likely
> > another cause.
> 
> So if someone(me, guilty) had been messing with reweight, will setting them
> all to 1 return it to a normal un-reweight-ed state?

Yep!  :)

sage

