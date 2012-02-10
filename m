From: =?iso-8859-1?Q?Jo=E3o_Eduardo_Lu=EDs?= <jecluis@gmail.com>
Subject: Re: s3--object name with "%" questions
Date: Fri, 10 Feb 2012 19:27:20 +0000
Message-ID: <98824354-25F6-4EC9-9665-2872781D9D36@gmail.com>
References: <CABAwU-bsdR+kwbvUfTcw8AmiT8M_kJz8MKuFNBjpB3WfJ6OXgw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5-555006545"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37393 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759027Ab2BJT1a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2012 14:27:30 -0500
Received: by werb13 with SMTP id b13so2253638wer.19
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2012 11:27:29 -0800 (PST)
In-Reply-To: <CABAwU-bsdR+kwbvUfTcw8AmiT8M_kJz8MKuFNBjpB3WfJ6OXgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5-555006545
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=iso-8859-1


On Feb 10, 2012, at 9:06 AM, huang jun wrote:

> hi,list
> After testing the object-name include "+" in radosgw.now we tested
> object-name with "%",
> which was supported by the amazon's object-name rules, either in the
> underlayer FS btrfs .
> but it seems not  the case in radosgw, we can not create an object
> whoes name include "%",
>=20
> after we can create it, then the ListBucket result shows the name of
> the object "test%huang" is "test2608ang".
> we trace the debug log, the object-name was changed by "vsnprintf" in
> formatter.dump_format, because the "%" is a control character,
> so, there is any methods if user want to store an object  with name
> string include  "%".
>=20

Not sure if this would help at all, but have you tried to escape the %?

> --=20
> thanks,
> huangjun
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

---
Jo=E3o Eduardo Lu=EDs
gpg key: 477C26E5 from pool.keyserver.eu=20






--Apple-Mail-5-555006545
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.16 (Darwin)

iQEcBAEBAgAGBQJPNW+dAAoJEJ9vvxhHfCblXGsH/RBXtPo9JOMbMPrZKzf9yNcl
XUQR3gGrQcNk/leQxdtZKtgiXzSBrHhMql/LesgcY8ZxjZ3fij8e1VaYS4CnNUte
v9AVBiB/xsuvunCHBgt0KFutBuAmGtSnRchXEEoLoYacXxmXnbn2Q3ZBI6bYMY+f
aYay4stQfsv8WMDBABPxI+uNr+Ps3E371BI2/lJqb55NydNITWXtzRUYjswd2V5I
q7e2DbCvhEUkCXjmEC6FXkPZtjCYo8pzV1KxukviW33YX3N2JjkaSvvVoH67kF1G
GxYeCQ/+GsZHhsbV/9iFhIFgStuxWx59Ik45fBirhl5m2pCYwIbZ90wEm85fLdY=
=7Rgg
-----END PGP SIGNATURE-----

--Apple-Mail-5-555006545--
