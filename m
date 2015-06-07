From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Caching the erasure code decoding matrix
Date: Sun, 7 Jun 2015 12:30:03 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AF075313@CERNXCHG43.cern.ch>
References: <55511543.3040603@dachary.org>,<5573774E.9010105@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:21622 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbbFGMfd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Jun 2015 08:35:33 -0400
In-Reply-To: <5573774E.9010105@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,
ec_init_table is not the function to invert the matrix!
The loop to construct the inverted matrix is in isa_decode.

Or maybe I don't understand your email.

The performance of the jerasure plug-in for decoding was already very g=
ood and probably they construct and therefore invert the matrix in a di=
fferent way than in the INTEL library. Without caching the decoding mat=
rix the performance of the ISA library was a desaster using the benchma=
rk tool.

Cheers Andreas.
________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 07 June 2015 00:42
To: Andreas Joachim Peters
Cc: Ceph Development
Subject: Re: Caching the erasure code decoding matrix

Hi Andreas,

After discussing this a little with a few people, I'm tempted to conclu=
de caching the decoding matrix is probably not worth the complexity. It=
's even difficult for me to know if maintaining the cache is cheaper th=
an computing the decoding matrix.

Cheers

On 11/05/2015 22:46, Loic Dachary wrote:
> Hi Andreas,
>
> I gave a shot at implementing a cache to avoid computing the decoding=
 matrix every time a 4KB stripe needs it, for the jerasure plugin, in t=
he same way you did it for the ISA plugin.
>
> The draft is at https://github.com/dachary/ceph/commit/a6fb5257fabd81=
0704405c8bc13743d1592ecc54 if you're curious. Then I did some benchmark=
ing and was quite disappointed. It looks like whenever the matrix needs=
 to be computed jerasure_invert_matrix needs ~4000 cycles. Compared to =
the cost of galois_w08_region_multiply (~4 millions cycles), it is very=
 small [1].
>
> With the ISA plugin ec_init_table is less expensive than jerasure_inv=
ert_matrix with ~1200 cycles as well as the the function ec_encode_data=
_avx (1.5 millions cycles) [2].
>
> In both cases though the order of magnitude remains (1000 to 1) and m=
akes me wonder if I'm not missing something.
>
> What do you think ?
>
> Cheers
>
> [1] jerasure profiling: make -j4 ceph_erasure_code_benchmark && rm be=
nch.callgrind &&  valgrind --tool=3Dcallgrind --callgrind-out-file=3Dbe=
nch.callgrind      ./ceph_erasure_code_benchmark      --plugin jerasure=
      --parameter directory=3D.libs --workload decode --verbose      --=
parameter technique=3Dreed_sol_van      --parameter k=3D4      --parame=
ter m=3D2      --iterations 1024 --erased 1 --erased 2 && kcachegrind b=
ench.callgrind
> [2] isa profiling: make -j4 ceph_erasure_code_benchmark && rm bench.c=
allgrind &&  valgrind --tool=3Dcallgrind --callgrind-out-file=3Dbench.c=
allgrind      ./ceph_erasure_code_benchmark      --plugin isa      --pa=
rameter directory=3D.libs --workload decode --verbose      --parameter =
technique=3Dreed_sol_van      --parameter k=3D4      --parameter m=3D2 =
     --iterations 1024 --erased 1 --erased 2 && kcachegrind bench.callg=
rind
>

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
