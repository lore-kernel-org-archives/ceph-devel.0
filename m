From: Janne Grunau <j@jannau.net>
Subject: Re: ARM NEON optimisations for gf-complete/jerasure/ceph-erasure
Date: Thu, 18 Sep 2014 12:11:28 +0200
Message-ID: <20140918101128.GV2591@jannau.net>
References: <20140904144237.GK2591@jannau.net>
 <54088382.4070402@dachary.org>
 <CA+AFVBg1oKix1U=qYdLBQ+j4MPYek-npz5UkkFh+dtR_UADUxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:44930 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbaIRKLb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 06:11:31 -0400
Content-Disposition: inline
In-Reply-To: <CA+AFVBg1oKix1U=qYdLBQ+j4MPYek-npz5UkkFh+dtR_UADUxw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, Ethan Miller <elm@cs.ucsc.edu>

Hi Kevin,

On 2014-09-16 11:25:12 -0700, Kevin Greenan wrote:
> 
> I feel that separating the arch-specific implementations out and have a
> default 'generic' implementation would be a huge improvement.  Note that
> gf-complete was in active development for some time before including the
> SIMD code.  In hindsight, we should have done this separation back in 2012,
> but had some time pressure due to a paper deadline and limited time
> available to the contributors.
> 
> Also, I agree w.r.t. the preprocessor stuff.  Going with SIMD/NOSIMD is
> fine by me.

I'll rename than and start implementing neon optimized function in their 
own files.
 
> Also, there should be very little "SIMD" work with jerasure, as gf-complete
> is the Galois field backend, so I would not worry too much about that.

I noticed, I have hooked my neon code already locally in ceph with 
touching jerasure.

> That covers "clean-up" work.  We can discuss the best way to choose the
> underlying implementation (looks like we have a bunch of options) as this
> work is completed.
> 
> With this in mind, what work were you planning to do?  I can try to free up
> cycles to help, but that may not happen for a few weeks.

Primarily NEON optimisations for gf-complete/ceph. Shouldn't take more 
than a few days though.

> One last thing...  If you do have code you want to push upstream, please
> submit a pull request(s) to our main bitbucket repo.
> 
> Make sense?

yes, thanks.

Janne
