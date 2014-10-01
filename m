From: Loic Dachary <loic@dachary.org>
Subject: Re: librados AIO problem diagnostic
Date: Wed, 01 Oct 2014 15:08:27 +0200
Message-ID: <542BFCCB.4000203@dachary.org>
References: <542BA6D4.4070207@dachary.org>	 <1412148537.6822.11.camel@sebmain.cern.ch> <542BBBE7.4000806@dachary.org> <1412163429.6822.20.camel@sebmain.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="M2k9NFTDGeruI1GPtjn7qGcgVc2pdbjI4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35768 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750861AbaJANIf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Oct 2014 09:08:35 -0400
In-Reply-To: <1412163429.6822.20.camel@sebmain.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Ponce <sebastien.ponce@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M2k9NFTDGeruI1GPtjn7qGcgVc2pdbjI4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 01/10/2014 13:37, Sebastien Ponce wrote:
> I've tried it on the RHEL6 like machine, but no luck. Or should I say I=

> was lucky ? Anyway no crash.
>=20
> Discussing with Dan Van Der Ster, he told me that he had once the case
> where the crash was there or not depending on the libc version. Just in=

> case, what are you using ? On the machine I've used this morning, it's
> glibc-2.12-1.107.el6.x86_64

I'm using=20

ii  libc-bin                                              2.19-0ubuntu3=20

and I do not have glibc installed. I'm quite sure you can reproduce the p=
roblem on a fresh Ubuntu 14.04 with the following

=2E/autogen.sh ; ./configure --disable-static --with-debug CFLAGS=3D"-Wal=
l -g" CXXFLAGS=3D"-Wall -g"

it fails consistently in my container. When I try with ./configure it doe=
s not fail. Something is going on when there is -g instead of the default=
 flags. I checked that --disable-static and --with-debug make no differen=
ce.

Cheers

>=20
> Sebastien
>=20
> On Wed, 2014-10-01 at 10:31 +0200, Loic Dachary wrote:
>> Hi,
>>
>> On 01/10/2014 09:28, Sebastien Ponce wrote:
>>> Thanks for this effort !
>>> I'll look at all that this afternoon (it's mid morning here).
>>
>> Same here : I'm in Paris ;-)
>>
>>> Concerning configure and autogen, I do the standard (naive ?)
>>> "./autogen.sh; ./configure; make" given by the readme.
>>
>> Could you try with
>>
>> ./autogen.sh ; ./configure --disable-static --with-debug CC=3D'ccache =
gcc' CXX=3D'ccache g++' CFLAGS=3D"-Wall -g" CXXFLAGS=3D"-Wall -g" ; make
>>
>> and let me know if you see a problem when running
>>
>> cd src
>> rm -fr dev out ;  mkdir -p dev ; CEPH_NUM_MON=3D1 CEPH_NUM_OSD=3D3 ./v=
start.sh -d -n -X -l mon osd
>> ./ceph_test_rados_striper_api_aio
>>
>> I'm trying with your "./configure" on my end to check if this changes =
something.
>>
>> It's going to be a fun one ;-)
>>
>> Cheers
>>
>>>
>>> Sebastien
>>>
>>>
>>> On Wed, 2014-10-01 at 09:01 +0200, Loic Dachary wrote:
>>>> Hi Sebastien,
>>>>
>>>> In the context of http://tracker.ceph.com/issues/9356 I'm trying to =
collect as much information as I can in an environment that can be recons=
tructed to avoid interferences. Could you please let me know which ./conf=
igure line you are using ? Or which do_autogen.sh command you are using.
>>>>
>>>> Thanks in advance :-)
>>>>
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
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--M2k9NFTDGeruI1GPtjn7qGcgVc2pdbjI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQr/MsACgkQ8dLMyEl6F22v3ACfdxQu+sHQ2/IICeYHsD5SgXeq
pFQAoMIXF+LQNiBaj1DJF0G3ewqPpCEC
=XnNQ
-----END PGP SIGNATURE-----

--M2k9NFTDGeruI1GPtjn7qGcgVc2pdbjI4--
