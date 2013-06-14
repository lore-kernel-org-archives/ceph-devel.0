From: "Martin Flyvbjerg" <martinflyvbjerg@gmx.com>
Subject: Comments on Ceph distributed parity implementation
Date: Fri, 14 Jun 2013 22:13:26 +0200
Message-ID: <20130614201327.70240@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:63078 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753611Ab3FNUNb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 14 Jun 2013 16:13:31 -0400
Received: from mailout-eu.gmx.com ([10.1.101.212]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0M6PTB-1UObfm07Vz-00yR8H for
 <ceph-devel@vger.kernel.org>; Fri, 14 Jun 2013 22:13:29 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear Community
I am a young engineer (not software or math, please bare with me) with some suggestions regarding erasure codes. I never used Ceph before or any other distributed file system.

I stumped upon the suggestion for adding erasure codes to Ceph, as
described in this article
http://wiki.Ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encoding_as_a_storage_backend

first I would like to say great initiative to add erasure codes to Ceph.
Ceph needs its own implementation and it have to be done right, I cannot stress this enough, suggested software mentioned in that article would result in very low performance.

Why?
Reed-Solomon is normally something regarded as being very slow compared to other erasure codes, because the underlying Galois-Field multiplication is slow. Please see video at usenix.org forexplanation.

The implementations of Zfec library and other suggested software the others rely on the Vandermonde matrix, a matrix used in in Reed-Solomon erasure codes, a faster approach would be to use the Cauchy-Reed-Solomon implementation. Please see [1,2,3]
Although there is something even better, by using the Intel SSE2/3 SIMD instructions it is possible to do the as fast as any other XOR based erasure codes (RaptorQ LT-codes, LDPC etc.).

The suggested FECpp lib uses the optimisation but with a relative small Galois-field only 2^8, since Ceph aimes at unlimited scalability increasing the size of the Galois-Field would improve performance [4]. Of course the configured Ceph Object Size and/or Stripe width have to be taken into account.
Please see
https://www.usenix.org/conference/fast13/screaming-fast-galois-field-arithmetic-using-sse2-extensions


The solution
Using the GF-Complete open source library [4] to implement Reed-Solomon in Ceph in order to allow Ceph to scale to infinity.
James S. Plank the author of GF-complete have developed a library implementing various Reed-Solomon codes called Jerasure. http://web.eecs.utk.edu/~plank/plank/www/software.html
Jerasure 2.0 using the GF-complete artimetric based in Intel SSE SIMD instructions, is current in development expected release august 2013. Will be released under the new BSD license. Jerasure 2.0 also supports arbitrary Galois-field sizes 8,16,32,64 or 128 bit.

The limit of this implementation would be the processors L2/L3 cache not the underlying arithmetic. 

Best Regards
Martin Flyvbjerg

[1] http://web.eecs.utk.edu/~plank/plank/papers/CS-05-569.pdf
[2] http://web.eecs.utk.edu/~plank/plank/papers/CS-08-625.pdf
[3] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2009.pdf
[4] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2013-GF.pdf
