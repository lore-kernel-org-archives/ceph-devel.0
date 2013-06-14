From: Joe Buck <jbbuck@gmail.com>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Fri, 14 Jun 2013 14:05:57 -0700
Message-ID: <51BB85B5.701@gmail.com>
References: <20130614201327.70240@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:61981 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab3FNVGA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jun 2013 17:06:00 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so933228pbb.14
        for <ceph-devel@vger.kernel.org>; Fri, 14 Jun 2013 14:06:00 -0700 (PDT)
In-Reply-To: <20130614201327.70240@gmx.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Flyvbjerg <martinflyvbjerg@gmx.com>
Cc: ceph-devel@vger.kernel.org

A recent paper out of Microsoft had an interesting twist on erasure 
coding (separately encoding each half and then the entire thing once, 
rather than the entire unit multiple times).
http://research.microsoft.com/en-us/um/people/yekhanin/papers/usenixatc_2012.pdf

it doesn't get at the math itself, but is something worth considering.

Best,
-Joe Buck

On 06/14/2013 01:13 PM, Martin Flyvbjerg wrote:
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

