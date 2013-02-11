From: Loic Dachary <loic@dachary.org>
Subject: Re: chain_fsetxattr extra chunk removal
Date: Mon, 11 Feb 2013 21:08:20 +0100
Message-ID: <51194FB4.8010603@dachary.org>
References: <511415A4.5050203@dachary.org> <CAC-hyiFwyJ9mFKvhcOh0dzGMTM4bFXXphn3vzfJRNuZm90HGCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig17E84A29D7217B2131388FAC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:53524 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758792Ab3BKUIX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 15:08:23 -0500
In-Reply-To: <CAC-hyiFwyJ9mFKvhcOh0dzGMTM4bFXXphn3vzfJRNuZm90HGCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig17E84A29D7217B2131388FAC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 02/11/2013 06:13 AM, Yehuda Sadeh wrote:
> On Thu, Feb 7, 2013 at 12:59 PM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi,
>>
>> While writing unit tests for chain_xattr.cc I tried to understand how =
to create the conditions to trigger this part of the chain_fsetxattr func=
tion:
>>
>>   /* if we're exactly at a chunk size, remove the next one (if wasn't =
removed
>>      before) */
>>   if (ret >=3D 0 && chunk_size =3D=3D CHAIN_XATTR_MAX_BLOCK_LEN) {
>>     get_raw_xattr_name(name, i, raw_name, sizeof(raw_name));
>>     int r =3D sys_fremovexattr(fd, raw_name);
>>     if (r < 0 && r !=3D -ENODATA)
>>       ret =3D r;
>>   }
>>
>> I suspect this cleans up extra empty attributes created as a side effe=
ct of a previous version of the function. Or I just don't understand the =
case it addresses.
>>
>> I'd very much appreciate a hint :-)
>>
>=20
> Well, the code has changed a bit, but originally when a chain was
> overwritten we didn't bother to remove the xattrs tail. When we read
> the chain we stop either when we got a short xattr, or when the next
> xattr in the chain didn't exist.  So when writing an xattr that was
> perfectly aligned with the block len we had to remove the next xattr
> in order make sure that readers will not over-read. I'm not too sure
> whether that still the case, Sam might have a better idea.
> In any case, it might be a good idea to test the case where we have a
> big xattr that spans across multiple blocks (e.g., > 3) and being
> overwritten by a short xattr. Probably also need to test it with
> different combinations of aligned and non-aligned block sizes.

I understand now and I'll modify the pull request https://github.com/ceph=
/ceph/pull/40 accordingly.

Thanks :-)

>=20
> Thanks,
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig17E84A29D7217B2131388FAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEZT7QACgkQ8dLMyEl6F23XAACffuANzKgkYAWQe6jpZNSgDGa4
h30An0CN7itTAME3s2Rfeiy4FWvURD2c
=q4F6
-----END PGP SIGNATURE-----

--------------enig17E84A29D7217B2131388FAC--
