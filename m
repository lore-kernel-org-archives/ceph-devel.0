From: Sage Weil <sage@inktank.com>
Subject: Re: Does radosgw really need to talk to an MDS?
Date: Mon, 2 Jul 2012 07:51:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207020750550.23342@cobra.newdream.net>
References: <CAPUexz9T+qzyDwSs6f-Bq7_1d_jMfBBEwBHUpY+QdhZYTekmsQ@mail.gmail.com>
 <4FF1898E.7000202@widodh.nl> <CAPUexz9G7Y2dsyU3cTj19tAsVOhGx_fViHYJmnbeEVZJuCheVQ@mail.gmail.com>
 <4FF1A09A.7010900@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33189 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab2GBOv3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 10:51:29 -0400
In-Reply-To: <4FF1A09A.7010900@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Florian Haas <florian@hastexo.com>, ceph-devel@vger.kernel.org, john.wilkins@inktank.com

On Mon, 2 Jul 2012, Wido den Hollander wrote:
> On 02-07-12 13:56, Florian Haas wrote:
> > On Mon, Jul 2, 2012 at 1:44 PM, Wido den Hollander <wido@widodh.nl> wrote:
> > > You are not allowing the RADOS Gateway to do anything on the MDS.
> > > 
> > > There is no 'r',  'w' or 'x' permission which you are allowing. So there
> > > is
> > > nothing the rgw has access to on the MDS.
> > 
> > Yep, so we might as well leave off "--cap mds 'allow'"?
> 
> I think so. You can always give it a try.
> 
> The RGW doesn't talk to the MDS anyway, so probably nothing will break.

Yep, that's an error in the documentation!  The mds cap should be left 
off.

sage
