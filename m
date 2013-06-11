From: Loic Dachary <loic@dachary.org>
Subject: Re: PGLog::rewind_divergent_log use case
Date: Tue, 11 Jun 2013 21:51:41 +0200
Message-ID: <51B77FCD.2060607@dachary.org>
References: <51B2E84D.6090001@dachary.org> <CA+4uBUZRPfQKpXodEZnHWH8G=LjpEkcGQxe=qTksRSoA6+ZMtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig30D6B1F34FE43A3EFA37EACC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:56521 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab3FKTvr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jun 2013 15:51:47 -0400
In-Reply-To: <CA+4uBUZRPfQKpXodEZnHWH8G=LjpEkcGQxe=qTksRSoA6+ZMtQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig30D6B1F34FE43A3EFA37EACC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I took a look at calc_acting and I can't figure out enough to create a bu=
g report. There are checks based on last_update and tail but it is diffic=
ult go infer how it relates to the rewind_divergent_log function. If you =
can connect the dots for me I'd be happy to write down a proper bug repor=
t ;-)

Cheers

On 06/11/2013 01:02 AM, Samuel Just wrote:
> I think that case may be possible, and that the assert may be wrong.
> We have probably never seen a problem there due to
> osd_min_pg_log_entries.  It's also possible that there is a subtle bug
> between there and calc_acting().
> -Sam
>=20
> On Sat, Jun 8, 2013 at 1:16 AM, Loic Dachary <loic@dachary.org> wrote:
>> [Note: ceph-devel cc'ed]
>>
>> Hi Sam,
>>
>> While trying to create the conditions for the following to happen in P=
GLog::rewind_divergent_log:
>>
>>     if (p =3D=3D log.log.begin()) {
>>       // yikes, the whole thing is divergent!
>>       divergent.swap(log.log);
>>       break;
>>     }
>>
>> https://github.com/ceph/ceph/blob/master/src/osd/PGLog.cc#L355
>>
>> I created this ( matching the drawing attached ), and the test case wo=
rks.
>>
>>     {
>>       pg_log_entry_t e;
>>
>>       info.log_tail =3D log.tail =3D eversion_t(1, 1);
>>       newhead =3D eversion_t(1, 3);
>>       e.version =3D divergent_version =3D eversion_t(1, 5);
>>       e.soid.hash =3D 0x9;
>>       divergent_object =3D e.soid;
>>       e.op =3D pg_log_entry_t::DELETE;
>>       e.prior_version =3D prior_version =3D eversion_t(0, 2);
>>       log.log.push_back(e);
>>       log.head =3D e.version;
>>     }
>>
>> https://github.com/dachary/ceph/commit/d592d7f10968c56139cb470a4111ddf=
be08a4030#L0R136
>>
>> But it does not look like a situation that is actually going to happen=
=2E I feel something is missing and a hint would be much appreciated :-)
>>
>> Cheers
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig30D6B1F34FE43A3EFA37EACC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlG3f80ACgkQ8dLMyEl6F21NOwCfahzWFPo9EQUCnUvAkqNiwqWN
AFIAn1GLQI3Rr6PNfv3bt4FEcLKmp1ZA
=hYCt
-----END PGP SIGNATURE-----

--------------enig30D6B1F34FE43A3EFA37EACC--
