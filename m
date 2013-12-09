From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Mon, 09 Dec 2013 17:45:21 +0100
Message-ID: <52A5F3A1.503@dachary.org>
References: <-7369304096744919226@unknownmsgid> <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch> <523C40B7.5060902@dachary.org> <alpine.DEB.2.00.1309200835110.25752@cobra.newdream.net> <523C7CAF.1020101@dachary.org>,<523DB725.2070104@dachary.org>,<3472A07E6605974CBC9BC573F1BC02E4A52727FF@PLOXCHG03.cern.ch> <3472A07E6605974CBC9BC573F1BC02E4AE69CCB4@PLOXCHG03.cern.ch> <52826E2D.2040503@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cWt0hS1whfKXW1cf5pfLfGo7LBke8r0oB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:35000 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934019Ab3LIQpY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Dec 2013 11:45:24 -0500
In-Reply-To: <52826E2D.2040503@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cWt0hS1whfKXW1cf5pfLfGo7LBke8r0oB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

Mark Nelson suggested we use perf ( linux-tools ) for benchmarking. It lo=
oks like something that would help indeed : the benchmark program would o=
nly concern itself with doing some work according to the options and let =
performances be collected from the outside, using tools that are familiar=
 to people doing benchmarking.

What do you think ?

Cheers

$ perf stat -e
  Error: switch `e' requires a value

 usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list availab=
le events
        --filter <filter>
                          event filter
    -i, --no-inherit      child tasks do not inherit counters
    -p, --pid <pid>       stat events on existing process id
    -t, --tid <tid>       stat events on existing thread id
    -a, --all-cpus        system-wide collection from all CPUs
    -g, --group           put the counters into a counter group
    -c, --scale           scale/normalize counters
    -v, --verbose         be more verbose (show counter open errors, etc)=

    -r, --repeat <n>      repeat command and print average + stddev (max:=
 100, forever: 0)
    -n, --null            null run - dont start any counters
    -d, --detailed        detailed run - start a lot of events
    -S, --sync            call sync() before starting a run
    -B, --big-num         print large numbers with thousands' separators
    -C, --cpu <cpu>       list of cpus to monitor in system-wide
    -A, --no-aggr         disable CPU count aggregation
    -x, --field-separator <separator>
                          print counts with custom separator
    -G, --cgroup <name>   monitor event in cgroup name only
    -o, --output <file>   output file name
        --append          append to the output file
        --log-fd <n>      log output to fd, instead of stderr
        --pre <command>   command to run prior to the measured command
        --post <command>  command to run after to the measured command
    -I, --interval-print <n>
                          print counts at regular interval in ms (>=3D 10=
0)
        --per-socket      aggregate counts per processor socket
        --per-core        aggregate counts per physical processor core


On 12/11/2013 19:06, Loic Dachary wrote:
> Hi Andreas,
>=20
> On 12/11/2013 02:11, Andreas Joachim Peters wrote:
>> Hi Loic,
>>
>> I am finally doing the benchmark tool and I found a bunch of wrong par=
ameter checks which can make the whole thing SEGV.
>>
>> All the RAID-6 codes have restrictions on the parameters but they are =
not correctly enforced for Liberation & Blaum-Roth codes in the CEPH wrap=
per class ... see text from PDF
>>
>> "Minimal Density RAID-6 codes are MDS codes based on binary matrices w=
hich satisfy a lower-bound on the number  of non-zero entries. Unlike Cau=
chy coding, the bit-matrix elements do not correspond to elements in GF (=
2 w ). Instead, the bit-matrix itself has the proper MDS property. Minima=
l Density RAID-6 codes perform faster than Reed-Solomon and Cauchy Reed-S=
olomon codes for the same parameters. Liberation coding, Liber8tion codin=
g, and Blaum-Roth coding are three examples of this kind of coding that a=
re supported in jerasure.
>>
>> With each of these codes, m must be equal to two and k must be less th=
an or equal to w. The value of w has restrictions based on the code:
>>
>> =95 With Liberation coding, w must be a prime number [Pla08b].
>> =95 With Blaum-Roth coding, w + 1 must be a prime number [BR99]. =95 W=
ith Liber8tion coding, w must equal 8 [Pla08a].
>>
>> ...
>>
>> Do you add this fixes?
>=20
> Nice catch. I created and assigned to myself : http://tracker.ceph.com/=
issues/6754
>>
>> For the benchmark suite it runs currently 308 different configurations=
 for the 2 algorithm which make sense from the performance point of view =
and provides this output:
>>
>>
>> # -----------------------------------------------------------------
>> # Erasure Coding Benchmark - (C) CERN 2013 - Andreas.Joachim.Peters@ce=
rn.ch
>> # Ram-Size=3D12614856704 Allocation-Size=3D100000000
>> # -----------------------------------------------------------------
>> # [ -BENCH- ] [       ] technique=3Dmemcpy                            =
                                speed=3D5.408 [GB/s] latency=3D9.245 ms
>> # [ -BENCH- ] [       ] technique=3Dd=3Da^b^c-xor                     =
                                  speed=3D4.377 [GB/s] latency=3D17.136 m=
s
>> # [ -BENCH- ] [001/304] technique=3Dcauchy_good:k=3D05:m=3D2:w=3D8:lp=3D=
0:packet=3D00064:size=3D50000000          speed=3D1.308 [GB/s] latency=3D=
038	[ms] size-overhead=3D40	[%]
>> ..
>> ..
>> # [ -BENCH- ] [304/304] technique=3Dliberation:k=3D24:m=3D2:w=3D29:lp=3D=
2:packet=3D65536:size=3D50000000          speed=3D0.083 [GB/s] latency=3D=
604	[ms] size-overhead=3D16	[%]
>> # -----------------------------------------------------------------
>> # Erasure Code Performance Summary::
>> # -----------------------------------------------------------------
>> # RAM:                   12.61 GB
>> # Allocation-Size        0.10 GB
>> # -----------------------------------------------------------------
>> # Byte Initialization:   29.35 MB/s
>> # Memcpy:                5.41 GB/s
>> # Triple-XOR:            4.38 GB/s
>> # -----------------------------------------------------------------
>> # Fastest RAID6          2.72 GB/s liber8tion:k=3D06:m=3D2:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
>> # Fastest Triple Failure 0.96 GB/s cauchy_good:k=3D06:m=3D3:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
>> # Fastest Quadr. Failure 0.66 GB/s cauchy_good:k=3D06:m=3D4:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
>> # -----------------------------------------------------------------
>> # .................................................................
>> # Top 1  RAID6          2.72 GB/s liber8tion:k=3D06:m=3D2:w=3D8:lp=3D0=
:packet=3D04096:size=3D50000000
>> # Top 2  RAID6          2.72 GB/s liber8tion:k=3D06:m=3D2:w=3D8:lp=3D0=
:packet=3D16384:size=3D50000000
>> # Top 3  RAID6          2.64 GB/s liber8tion:k=3D06:m=3D2:w=3D8:lp=3D0=
:packet=3D65536:size=3D50000000
>> # Top 4  RAID6          2.60 GB/s liberation:k=3D07:m=3D2:w=3D7:lp=3D0=
:packet=3D16384:size=3D50000000
>> # Top 5  RAID6          2.59 GB/s liberation:k=3D05:m=3D2:w=3D7:lp=3D0=
:packet=3D04096:size=3D50000000
>> # .................................................................
>> # Top 1  Triple         0.96 GB/s cauchy_good:k=3D06:m=3D3:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
>> # Top 2  Triple         0.94 GB/s cauchy_good:k=3D06:m=3D3:w=3D8:lp=3D=
0:packet=3D16384:size=3D50000000
>> # Top 3  Triple         0.93 GB/s cauchy_good:k=3D06:m=3D3:w=3D8:lp=3D=
0:packet=3D65536:size=3D50000000
>> # Top 4  Triple         0.89 GB/s cauchy_good:k=3D07:m=3D3:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
>> # Top 5  Triple         0.87 GB/s cauchy_good:k=3D05:m=3D3:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
>> # .................................................................
>> # Top 1  Quadr.         0.66 GB/s cauchy_good:k=3D06:m=3D4:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
>> # Top 2  Quadr.         0.65 GB/s cauchy_good:k=3D07:m=3D4:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
>> # Top 3  Quadr.         0.64 GB/s cauchy_good:k=3D06:m=3D4:w=3D8:lp=3D=
0:packet=3D16384:size=3D50000000
>> # Top 4  Quadr.         0.64 GB/s cauchy_good:k=3D05:m=3D4:w=3D8:lp=3D=
0:packet=3D04096:size=3D50000000
>> # Top 5  Quadr.         0.64 GB/s cauchy_good:k=3D06:m=3D4:w=3D8:lp=3D=
0:packet=3D65536:size=3D50000000
>> # .................................................................
>>
>> It takes around 30 second on my box.=20
>=20
>=20
> That looks great :-) If I understand correctly, it means https://github=
=2Ecom/ceph/ceph/pull/740 will no longer have benchmarks as they are move=
d to a separate program. Correct ?
>=20
>> I will add a measurement how the XOR and the 3 top algorithms scale wi=
th the number of cores and make the object-size configurable from the com=
mand line. Anything else ?=20
>=20
> It would be convenient to run this from a "workunit" ( i.e. a script in=
 ceph/qa/workunits/ ) so that it can later be run by teuthology integrati=
on tests. That could be used to show regression.
>=20
> Shall I add the possiblity to test a single user specified configuratio=
n via command line arguments?
>>
> I would need to play with it to comment usefully.
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--cWt0hS1whfKXW1cf5pfLfGo7LBke8r0oB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKl86EACgkQ8dLMyEl6F23xugCgos7AEiiNnw7JjbRinAJvGScP
k6wAn1fcsf7GgTeMGD3v1lx3/HW55a/U
=aBKS
-----END PGP SIGNATURE-----

--cWt0hS1whfKXW1cf5pfLfGo7LBke8r0oB--
