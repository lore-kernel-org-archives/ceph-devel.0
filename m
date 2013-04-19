From: "Christopher LILJENSTOLPE" <cdl@asgaard.org>
Subject: Re: erasure coding (sorry)
Date: Thu, 18 Apr 2013 17:34:29 -0700
Message-ID: <4DC8DA7B-6BDC-4D2A-A152-113DDBF8C648@asgaard.org>
References: <20130418162842.0c61d1e2@dieter-t420s>
 <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net>
 <517060B2.80706@inktank.com>
 <506B76E2-8814-45C8-8700-C4316E96FE30@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_E3C9DA16-D5BE-47F9-80D6-64D624B4C398_=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.emailarray.com ([65.39.216.14]:59681 "EHLO
	smtp1.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967617Ab3DSAlM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 20:41:12 -0400
In-Reply-To: <506B76E2-8814-45C8-8700-C4316E96FE30@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Sage Weil <sage@inktank.com>, "Plaetinck, Dieter" <dieter@vimeo.com>, ceph-devel@vger.kernel.org, danm@annaisystems.com

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_E3C9DA16-D5BE-47F9-80D6-64D624B4C398_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Supposedly, on 2013-Apr-18, at 14.24 PDT(-0700), someone claiming to be N=
oah Watkins scribed:

> On Apr 18, 2013, at 2:08 PM, Josh Durgin <josh.durgin@inktank.com> wrot=
e:
>
>> I talked to some folks interested in doing a more limited form of this=

>> yesterday. They started a blueprint [1]. One of their ideas was to hav=
e
>> erasure coding done by a separate process (or thread perhaps). It woul=
d
>> use erasure coding on an object and then use librados to store the
>> rasure-encoded pieces in a separate pool, and finally leave a marker i=
n
>> place of the original object in the first pool.
>
> This sounds at a high-level similar to work out of Microsoft:

I've looked at that, and it would be somewhat similar (not completely, bu=
t borrow some ideas).

	Christopher

>
> https://www.usenix.org/system/files/conference/atc12/atc12-final181_0.p=
df
>
> The basic idea is to replicate first, then erasure code in the backgrou=
nd.
>
> - Noah


--
=E6=9D=8E=E6=9F=AF=E7=9D=BF
Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
Check my calendar availability: https://tungle.me/cdl
--=_MailMate_E3C9DA16-D5BE-47F9-80D6-64D624B4C398_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJRcJEVAAoJEGmx2Mt/+Iw/lugH+wYImj1tCRWlFusO4V+ief0l
Ee0yykS0TE6gNXTnzH6UMP9W9eV2n9NFsfjJ6CQDZeWOiIhfWV0WG1nUcp5ZT1bx
zAWVwafajwRksFCQfl1KZMueOAet3iRr56w2dVt3t5Ho1UBhmFPTaBqC2r5o4AY/
FiiSaow/PW3WWQnFs3Ovb6sEwIKLd1SFmp0usvUaGVvRta/BHwH4a7bpPJfGsLGK
b8MJucAy0LWJXbHbvk4Rgf1b+6kC/CkONNmcpWXZspTm9VAptFQqtcpD945ALV6x
DeEeLUciYI41DxhHYhnrJfTk2bJs7XPO7bS8PbfDaZdlm1wCd1ssNOdf+3qNCiA=
=ZVGg
-----END PGP SIGNATURE-----

--=_MailMate_E3C9DA16-D5BE-47F9-80D6-64D624B4C398_=--
