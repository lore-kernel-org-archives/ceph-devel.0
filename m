From: Janne Grunau <j@jannau.net>
Subject: Re: ARM NEON optimisations for gf-complete/jerasure/ceph-erasure
Date: Fri, 5 Sep 2014 09:51:30 +0200
Message-ID: <20140905075130.GM2591@jannau.net>
References: <20140904144237.GK2591@jannau.net>
 <54088C03.10900@dachary.org>
 <CAMMD=N2GhtqrJvayV2WB7nmWPhV=ygcxrk555xFSx0gAMJQg-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:43906 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbaIEHvc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Sep 2014 03:51:32 -0400
Content-Disposition: inline
In-Reply-To: <CAMMD=N2GhtqrJvayV2WB7nmWPhV=ygcxrk555xFSx0gAMJQg-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elm@cs.ucsc.edu
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, Kevin Greenan <kmgreen2@gmail.com>, Ethan Miller <elm@soe.ucsc.edu>

Hi,

On 2014-09-04 17:27:16 -0700, Ethan L. Miller wrote:
> Yes, it's possible to use CPU flags to allow the use of advanced
> instruction sets automatically.

runtime detection of supported instructions sets is with the current 
function pointer approach possible too.

>  The difficulty is that, if those
> instructions aren't available, it's not clear which of the "basic"
> approaches to use, since performance can vary based on a lot of
> factors.  Even with advanced instructions, there are often multiple
> reasonable approaches to take, as Janne's email makes clear, so it's
> impossible to say "this algorithm is always best".

I agree that the current approach fits the model of implementations with 
different cpu/memory use better. Using ifunc would be mostly orthogonal 
to the issue of badly structured code.
 
> We can certainly set up a default approach if we want, though, that
> can be overridden by compile-time flags.

I don't think this would be an improvement.

> Incidentally, I'm starting to work on coding a version of gf-complete
> (and associated erasure coding functions) in C++ using templates,
> which will hopefully allow us to better separate out different
> implementations.  We could still have run-time dispatch for the
> desired routines, but templates should allow for more compact code and
> better isolation of architecture-specific code.  The big drawback is
> that C++ code isn't typically used in the kernel....

One possible simplification for the carry less multiplication would be 
relying on inlining and optimisations of compile time constants.  

Implement one function which does a variable number of polynomial 
reductions. The current functions would then just be thin wrappers which 
call the general function with a compile time constant for the number of 
reductions. Forced inlining and dead code removal will optimize branches 
away. The same method could be used to avoid the duplication of the 
inner loop for the optional xor with the destination.

Janne
