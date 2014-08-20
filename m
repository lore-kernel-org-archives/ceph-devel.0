From: Sage Weil <sweil@redhat.com>
Subject: Re: size and depth of Tree Bucket
Date: Tue, 19 Aug 2014 21:00:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408192057500.28244@cobra.newdream.net>
References: <CANX6DakEDhAjfSTcb4vtRbW-yX_TnV7Vd=VCWHuBQE=Cbu-cDw@mail.gmail.com> <CAPYLRzjvTD_32-VLnCPH7TfPvpZVwdNCsVE_1F27=PUh_gSqNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38154 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbaHTEAB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Aug 2014 00:00:01 -0400
In-Reply-To: <CAPYLRzjvTD_32-VLnCPH7TfPvpZVwdNCsVE_1F27=PUh_gSqNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Viral Mehta <viral.vkm@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 19 Aug 2014, Gregory Farnum wrote:
> On Wed, Aug 13, 2014 at 4:09 AM, Viral Mehta <viral.vkm@gmail.com> wrote:
> > Hi,
> >
> > I was looking at ceph/crush/builder.c crush_make_tree_bucket() function,
> >
> > I would like to understand what "size" argument refers to ? Generally speaking
> > Tree Size is Total Number of the nodes. And this would be the same as number of
> > items.
> >
> > But, crush.h mentions that it is NOT true. Can someone shed some light ?
> 
> This is some pretty opaque code, and I don't spend much time in it,
> but just looking at the surroundings the argument is just the "size"
> of the following array (int *items). It's the number of entries there
> are within this bucket.

Sorry I missed this thread earlier!

Normally size is the number of items.  In the tree bucket case, it is the 
power of 2 that is 2x the number of items (or something similar), as it is 
mixed up with the internal implementation (which puts items at the leaves 
and has internal nodes with weights).

Note that I believe there is a bug in the tree mapping code that hasn't 
been addressed just because nobody ever users it.  The default is straw 
and that is usually the right choice...

sage

