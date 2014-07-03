From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Checking of Reed-Solomon Vandermonde parameter combinations
Date: Thu, 3 Jul 2014 10:27:35 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE747EDC@CERNXCHG44.cern.ch>
References: <53B52EC8.5030708@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:51493 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030184AbaGCK1j convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jul 2014 06:27:39 -0400
In-Reply-To: <53B52EC8.5030708@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,=20
as much as I understood for now it should not happen in Jerasure, but i=
t will happen with the default Vandermonde matrix in the Intel library.=
 The reason is the way these matrices are constructed.

But to verify this you have to make millions of iterations not only 1 b=
ecause for large (k,m) there many failure scenario (chunk combinations)=
 to test.

Cheers Andreas.

________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 03 July 2014 12:22
To: Andreas Joachim Peters
Cc: Ceph Development
Subject: Checking of Reed-Solomon Vandermonde parameter combinations

Hi Andreas,

There are some combinations of K/M parameters for which Reed-Solomon Va=
ndermonde may not be able to recover from the loss of M chunks. Reed-So=
lomon Cauchy does not suffer from this problem. (I'm paraphrasing a con=
versation we had in private, feel free to correct me if I'm wrong).

In the context of Ceph we are interested in a limited range of paramete=
rs so I ran a test with:

https://github.com/ceph/ceph/blob/master/src/test/erasure-code/ceph_era=
sure_code_benchmark.cc#L40

for k in $(seq 2 50) ; do for m in $(seq 1 $k) ; do echo -n "k=3D$k m=3D=
$m " ; ./ceph_erasure_code_benchmark      --plugin jerasure      --para=
meter directory=3D.libs      --parameter technique=3Dreed_sol_van      =
--parameter k=3D$k      --parameter m=3D$m --erasures $m      --iterati=
ons 1 --workload decode ; done ; done

and it does not throw an error. It basically take a range of parameters=
 K=3D2,M=3D2 up to K=3D50,M=3D50 and decode with M erasures for each of=
 them. Should some of them fail ?

Cheers
--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
