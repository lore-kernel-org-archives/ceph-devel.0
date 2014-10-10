From: Janne Grunau <j@jannau.net>
Subject: Re: ARM NEON optimisations for gf-complete/jerasure/ceph-erasure
Date: Fri, 10 Oct 2014 16:01:09 +0200
Message-ID: <20141010140109.GG2532@jannau.net>
References: <20140904144237.GK2591@jannau.net>
 <54088382.4070402@dachary.org>
 <CA+AFVBg1oKix1U=qYdLBQ+j4MPYek-npz5UkkFh+dtR_UADUxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:54897 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbaJJOBO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 10:01:14 -0400
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

I created a pull request with my neon optimisations, the SSE -> SIMD 
rename and some minor fixes.

The neon methods all reside in their own files, I didn't come up with 
good solution for the init / scratch_size functions, so I added 
arm-specific defines there.

> Also, there should be very little "SIMD" work with jerasure, as gf-complete
> is the Galois field backend, so I would not worry too much about that.

Yes, there was no SIMD work in jerasure.

Please have a look at 
https://bitbucket.org/jimplank/gf-complete/pull-request/25/arm-neon-optimisations 
I'll be available to address review comments and suggestions.

regards

Janne
