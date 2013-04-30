From: "Christopher LILJENSTOLPE" <cdl@asgaard.org>
Subject: Re: fecpp C++ forward error correction library
Date: Mon, 29 Apr 2013 17:12:47 -0700
Message-ID: <1E89ABED-10DD-4932-83C3-CF13EAC052D2@asgaard.org>
References: <sfid-H20130422-141929-+033.82-1@marduk.tchpc.tcd.ie>
 <517538D7.6050706@dachary.org>
 <DCA8968A-375A-4E51-84D3-425E22E81375@tchpc.tcd.ie>
 <517E8268.8030109@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_2AEF492E-3F20-4A19-9C6C-B30AE2A646AF_=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.emailarray.com ([69.28.212.198]:42721 "EHLO
	smtp2.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759321Ab3D3AMv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 20:12:51 -0400
In-Reply-To: <517E8268.8030109@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Jimmy Tang <jtang@tchpc.tcd.ie>, Ceph Development <ceph-devel@vger.kernel.org>, Jack Lloyd <lloyd@randombit.net>

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_2AEF492E-3F20-4A19-9C6C-B30AE2A646AF_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Supposedly, on 2013-Apr-29, at 07.23 PDT(-0700), someone claiming to be L=
oic Dachary scribed:

> On 04/29/2013 04:06 PM, Jimmy Tang wrote:
>>
>> On 22 Apr 2013, at 14:19, Loic Dachary wrote:
>>
>>> Hi Christopher,
>>>
>>> Jack Lloyd is the author of fecpp ( http://www.randombit.net/code/fec=
pp/ ) and he tells me someone sent him a new SIMD approach a few weeks ag=
o. I'm not sure what SIMD means yet, but I'll figure it out ;-). I tend t=
o favor fecpp because it is more self contained and may be easier to embe=
d than https://pypi.python.org/pypi/zfec
>>>
>>> Cheers
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>>
>>
>> Having played with zfec (more the underlying fec.[c,h] file) it's well=
 written and self-contained as I remember it; but you will need to write =
a bunch of wrapper functions to chunk up data and pad out blocks and of c=
ourse turn it into a library before you can use the underlying zfec imple=
mentation for ceph. If my memory is right, zfec's c code requires a C90 o=
r C99 compiler to build it, I'm not sure if you care about that.
>
> Hi Jimmy,
>
> fecpp and zfec compile and run using g++ 4.7 . The requirements for htt=
p://code.google.com/p/holostor/ may be different but I suspect it also wo=
rks.

Greetings - just looked at holostor - some concerns, it looks like it cap=
s out (per the comments) at 17:21.  As I know of at least one case where =
I needed to do something like 10:18, that might already violate holostor =
(n-m > 4) or definitely push up to its m boundary.

	Christopher


>
> Cheers
>
>>
>> Regards,
>> Jimmy Tang
>>
>> --
>> Senior Software Engineer, Digital Repository of Ireland (DRI)
>> High Performance & Research Computing, IS Services
>> Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
>> http://www.tchpc.tcd.ie/ | jtang@tchpc.tcd.ie
>> Tel: +353-1-896-3847
>>
>
> -- =

> Lo=C3=AFc Dachary, Artisan Logiciel Libre


--
=E6=9D=8E=E6=9F=AF=E7=9D=BF
Check my PGP key here: http://www.asgaard.org/cdl/cdl.asc
Current vCard here: http://www.asgaard.org/cdl/cdl.vcf
--=_MailMate_2AEF492E-3F20-4A19-9C6C-B30AE2A646AF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJRfwx/AAoJEGmx2Mt/+Iw/UvAH+wWcP6/1EwgSykJw6ArVV+q+
abr5EQTwUbXEDWxLCE6ekLliSoHB7UEB5XCrdhIrwTUA743h95pwZ1tTXCP0Mtz4
dqgeAUH+Wss/Yby1IeihilpCAO6KIygrLfhQ9UqwvZ2fy+qVDfg8V2NA/hrFsKjC
KQyaLCHPZ5oZa+zcfhxE7VBsh5OjkiqbLWiHSilV/BGb5pDHnGruRkgW/gZSVlUp
jWxUIgn0JK12FVCDnc2VrxzDzSyMohsHhq92YiGUB0Z7xN4VKcrYUwwEqfMJKoyc
tD2r35cDUVoyg+07vyNGAYAseNbYF7VKxPGWyif+RhlJy8hz3Tw5HVpDCUAJLxE=
=pgjk
-----END PGP SIGNATURE-----

--=_MailMate_2AEF492E-3F20-4A19-9C6C-B30AE2A646AF_=--
