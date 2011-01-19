From: Sage Weil <sage@newdream.net>
Subject: Re: cephfs set_layout on filesystem root?
Date: Wed, 19 Jan 2011 09:52:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101190952080.6864@cobra.newdream.net>
References: <1295455606.6777.23.camel@sale659.sandia.gov>
 <AANLkTi=LNa0AyiT4UfyrJLQrUCrPDACBocsiQV=yw7GQ@mail.gmail.com>
 <1295457888.6777.33.camel@sale659.sandia.gov> <Pine.LNX.4.64.1101190929290.6864@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41739 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab1ASRwP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 12:52:15 -0500
In-Reply-To: <Pine.LNX.4.64.1101190929290.6864@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregf@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 19 Jan 2011, Sage Weil wrote:
> On Wed, 19 Jan 2011, Jim Schutt wrote:
> > Hi Greg,
> > 
> > On Wed, 2011-01-19 at 10:00 -0700, Gregory Farnum wrote:
> > > On Wed, Jan 19, 2011 at 8:46 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> > > > Hi,
> > > >
> > > > I've been experimenting with using cephfs to set
> > > > the object/stripe size on a Ceph filesystem root,
> > > > and it seems to not persist across a filesystem
> > > > restart.  Is that expected behavior?

Fixed in commit 457e3e09bc, pushed to the testing branch.

Thanks!
sage
