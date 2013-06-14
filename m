From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Fri, 14 Jun 2013 15:29:28 -0500
Message-ID: <51BB7D28.20208@inktank.com>
References: <20130614201327.70240@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:64139 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab3FNU3Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jun 2013 16:29:25 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so2389107iea.18
        for <ceph-devel@vger.kernel.org>; Fri, 14 Jun 2013 13:29:25 -0700 (PDT)
In-Reply-To: <20130614201327.70240@gmx.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Flyvbjerg <martinflyvbjerg@gmx.com>
Cc: ceph-devel@vger.kernel.org

On 06/14/2013 03:13 PM, Martin Flyvbjerg wrote:
> Dear Community
> I am a young engineer (not software or math, please bare with me) with some suggestions regarding erasure codes. I never used Ceph before or any other distributed file system.
>
> I stumped upon the suggestion for adding erasure codes to Ceph, as
> described in this article
> http://wiki.Ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encoding_as_a_storage_backend
>
> first I would like to say great initiative to add erasure codes to Ceph.
> Ceph needs its own implementation and it have to be done right, I cannot stress this enough, suggested software mentioned in that article would result in very low performance.
>
> Why?
> Reed-Solomon is normally something regarded as being very slow compared to other erasure codes, because the underlying Galois-Field multiplication is slow. Please see video at usenix.org forexplanation.
>
> The implementations of Zfec library and other suggested software the others rely on the Vandermonde matrix, a matrix used in in Reed-Solomon erasure codes, a faster approach would be to use the Cauchy-Reed-Solomon implementation. Please see [1,2,3]
> Although there is something even better, by using the Intel SSE2/3 SIMD instructions it is possible to do the as fast as any other XOR based erasure codes (RaptorQ LT-codes, LDPC etc.).
>
> The suggested FECpp lib uses the optimisation but with a relative small Galois-field only 2^8, since Ceph aimes at unlimited scalability increasing the size of the Galois-Field would improve performance [4]. Of course the configured Ceph Object Size and/or Stripe width have to be taken into account.
> Please see
> https://www.usenix.org/conference/fast13/screaming-fast-galois-field-arithmetic-using-sse2-extensions
>
>
> The solution
> Using the GF-Complete open source library [4] to implement Reed-Solomon in Ceph in order to allow Ceph to scale to infinity.
> James S. Plank the author of GF-complete have developed a library implementing various Reed-Solomon codes called Jerasure. http://web.eecs.utk.edu/~plank/plank/www/software.html
> Jerasure 2.0 using the GF-complete artimetric based in Intel SSE SIMD instructions, is current in development expected release august 2013. Will be released under the new BSD license. Jerasure 2.0 also supports arbitrary Galois-field sizes 8,16,32,64 or 128 bit.
>
> The limit of this implementation would be the processors L2/L3 cache not the underlying arithmetic.

Thanks for all the info and the links Martin!  It would be useful to sit 
down and figure out how much overhead we'd expect to see with each 
implementation.  I'm definitely in favour of looking at 
Cauchy-Reed-Solomon (and any specific SSE/SIMD implementations) assuming 
there's not a lot of additional complexity or other downsides.  I won't 
be doing the development work though, so it's easy for me to say that. ;)

Mark

>
> Best Regards
> Martin Flyvbjerg
>
> [1] http://web.eecs.utk.edu/~plank/plank/papers/CS-05-569.pdf
> [2] http://web.eecs.utk.edu/~plank/plank/papers/CS-08-625.pdf
> [3] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2009.pdf
> [4] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2013-GF.pdf
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

