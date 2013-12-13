From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Fri, 13 Dec 2013 17:42:23 +0100
Message-ID: <52AB38EF.2010503@dachary.org>
References: <-7369304096744919226@unknownmsgid> <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch> <523C40B7.5060902@dachary.org> <alpine.DEB.2.00.1309200835110.25752@cobra.newdream.net> <523C7CAF.1020101@dachary.org>,<523DB725.2070104@dachary.org>,<3472A07E6605974CBC9BC573F1BC02E4A52727FF@PLOXCHG03.cern.ch> <3472A07E6605974CBC9BC573F1BC02E4AE69CCB4@PLOXCHG03.cern.ch> <52826E2D.2040503@dachary.org> <52A5F3A1.503@dachary.org>,<52A6D41A.3060205@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE6A9C22@PLOXCHG03.cern.ch> <52A85A6C.9050709@dachary.org>,<52A861FB.6000901@inktank.com> <3472A07E6605974CBC9BC573F1BC02E4AE6AB62C@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cfbH6T6OWSGibPjVdec1eUdqus3T1Mc9T"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:39548 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab3LMQmZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Dec 2013 11:42:25 -0500
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE6AB62C@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cfbH6T6OWSGibPjVdec1eUdqus3T1Mc9T
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 13/12/2013 16:47, Andreas Joachim Peters wrote:> Hi Loic,=20
>=20
> I (re-)pushed/fixed wip-bpc-01 in my GIT repository.
>=20

There still seem to be an issue as https://github.com/ceph/ceph/pull/740 =
show to be unmergeable ( if such a word exists ;-).

> There is one commit of general interest to 'galois.c' which gives me a =
factor 1.5 speed improvement (I exchanged the region XOR loop with vector=
 operations if available) in the Jerasure code base.
>=20

Great.

> I have also replaced the parity implementation to use SSE registers (vi=
a assembler) ... (seen in snapraid) which gives a factor 2.5 for the BPC =
part ...=20

Great.

> I needed to add a test for this in arch/intel.c like it was for the crc=
32c register .

Ok.=20

It also occurs to me that the benchmark should show the erasure code over=
head. I.e. 10 + 4 by default means + 40% and with BPC using 5 chunks at a=
 time it would be + 60%.

Cheers

> Cheers Andreas.
>=20
> ________________________________________
> From: Mark Nelson [mark.nelson@inktank.com]
> Sent: 11 December 2013 14:00
> To: Loic Dachary
> Cc: Andreas Joachim Peters; ceph-devel@vger.kernel.org
> Subject: Re: CEPH Erasure Encoding + OSD Scalability
>=20
> On 12/11/2013 06:28 AM, Loic Dachary wrote:
>>
>>
>> On 11/12/2013 10:49, Andreas Joachim Peters wrote:> Hi Loic,
>>> I am a little bit confused which kind of tool you actually want. You =
want a simple benchmark to check for degradation or you want a full profi=
ler tool?
>>>
>>
>> I was not sure, hence the confusion.
>>
>>> Most of the external tools have the problem that you measure the whol=
e thing including buffer allocation and initialization. We probably don't=
 want to measure how long it takes to allocate memory and write random nu=
mbers into it.
>>>
>>> I would just o:
>>>
>>> < prepare memory>
>>> <take CPU/realtime>
>>> < run algorithm >
>>> <take CPU/realtime>
>>> < print result>
>>>
>>
>> Ok, I'll do that.
>>
>> I'm glad I learnt about the other tools in the process, even if only t=
o conclude that they are not needed.
>=20
> Certainly things like perf are useful for profiling but may be overkill=

> in the general case depending on what you are trying to do.  Collectl i=
s
> pretty low overhead though if you are just looking for per-process CPU
> utilization stats.
>=20
>>
>> Cheers
>>
>>> Now one can also add to run the perf-stat tool after <prepare memory>=
 and start it from within the test program pointing to the PID running <r=
un alogorithm>, so the benchmark would be:
>>>
>>> < prepare memory>
>>> < take CPU/realtime>
>>> < fork=3D>"perf stat -p <mypid>";
>>> < run algorithm n times>
>>> < take CPU/realtime>
>>> < SIGINT to fork>
>>> < print results>
>>>
>>> As an extension one could also add to have <run algorithm> with <n> t=
hreads in a thread pool.
>>>
>>> Cheers Andreas.
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--cfbH6T6OWSGibPjVdec1eUdqus3T1Mc9T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKrOO8ACgkQ8dLMyEl6F23hsQCfcn6yaFdRctF2yQrMPDTmhQnT
mOgAnRiJ5ndB2i3Z3Bn6GMQTiSAPPxps
=rE7Y
-----END PGP SIGNATURE-----

--cfbH6T6OWSGibPjVdec1eUdqus3T1Mc9T--
