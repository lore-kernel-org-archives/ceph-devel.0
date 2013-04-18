From: Sage Weil <sage@inktank.com>
Subject: Re: erasure coding (sorry)
Date: Thu, 18 Apr 2013 14:26:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304181425070.10005@cobra.newdream.net>
References: <20130418162842.0c61d1e2@dieter-t420s> <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net> <517060B2.80706@inktank.com> <506B76E2-8814-45C8-8700-C4316E96FE30@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50298 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab3DRV0q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 17:26:46 -0400
In-Reply-To: <506B76E2-8814-45C8-8700-C4316E96FE30@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, "Plaetinck, Dieter" <dieter@vimeo.com>, ceph-devel@vger.kernel.org, cdl@asgaard.org, danm@annaisystems.com

On Thu, 18 Apr 2013, Noah Watkins wrote:
> On Apr 18, 2013, at 2:08 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> 
> > I talked to some folks interested in doing a more limited form of this
> > yesterday. They started a blueprint [1]. One of their ideas was to have
> > erasure coding done by a separate process (or thread perhaps). It would
> > use erasure coding on an object and then use librados to store the
> > rasure-encoded pieces in a separate pool, and finally leave a marker in
> > place of the original object in the first pool.
> 
> This sounds at a high-level similar to work out of Microsoft:
> 
>   https://www.usenix.org/system/files/conference/atc12/atc12-final181_0.pdf
> 
> The basic idea is to replicate first, then erasure code in the background.

FWIW, I think a useful (and generic) concept to add to rados would be a 
redirect symlink sort of thing that says "oh, this object is over there is 
that other pool", such that client requests will be transparently 
redirected or proxied.  This will enable generic tiering type operations, 
and probably simplify/enable migration without a lot of additional 
complexity on the client side.

sage
