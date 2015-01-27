From: Loic Dachary <loic@dachary.org>
Subject: Re: Article about Object Store API
Date: Tue, 27 Jan 2015 23:17:06 +0100
Message-ID: <54C80E62.5030300@dachary.org>
References: <871tmgvtje.fsf@irq0.org> <CAC6JEv8qv-tTiJW4Rdu_bd-fJSZuwdKd_UC_KJyHzb06n9t9Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0JoRhjrViKmFjxVpMdcBd1Ge3BNxPw1IC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48140 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759775AbbA0WRJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jan 2015 17:17:09 -0500
In-Reply-To: <CAC6JEv8qv-tTiJW4Rdu_bd-fJSZuwdKd_UC_KJyHzb06n9t9Ww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcel Lauhoff <ml@irq0.org>
Cc: Gregory Farnum <greg@gregs42.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0JoRhjrViKmFjxVpMdcBd1Ge3BNxPw1IC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

I'll bookmark this: useful high level view to get oriented when going bac=
k to this part of the code. I have the same question as Greg actually. It=
 looks like you're tempted to try a new objectstore backend, that's my be=
t :-)

Cheers

On 27/01/2015 22:03, Gregory Farnum wrote:
> Nifty; it's good to have that sort of blog-style documentation about
> the interface. Are you planning to do some work with it that you can
> show off as well? :)
> -Greg
>=20
> On Tue, Jan 27, 2015 at 12:48 PM, Marcel Lauhoff <ml@irq0.org> wrote:
>>
>> Hi,
>>
>> I wrote an article about the object store API - How it works and looks=

>> like with a focus on how to add something new.
>>
>> http://irq0.org/articles/ceph/objectstore
>>
>> Maybe its useful for somebody.. Feedback is greatly appreciated!
>>
>>
>>
>> [ I'm working on a Master's Thesis about Cold Storage / Archives using=
 Ceph
>> and will probably write something more about other parts of Ceph
>> crossing my way in the near future :) ]
>>
>>
>> ~marcel
>>
>>
>> --
>> Marcel Lauhoff
>> Mail/XMPP: ml@irq0.org
>> http://irq0.org
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--0JoRhjrViKmFjxVpMdcBd1Ge3BNxPw1IC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTIDmMACgkQ8dLMyEl6F23w+ACfftEyiEPrmQrT7dc4kkka+jrG
r8IAn0DwuJIwUZmGeCDi3v05U2Tt6Kp7
=QlLE
-----END PGP SIGNATURE-----

--0JoRhjrViKmFjxVpMdcBd1Ge3BNxPw1IC--
