From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure encoding as a storage backend
Date: Sat, 04 May 2013 21:26:45 +0200
Message-ID: <518560F5.3090306@dachary.org>
References: <5185428B.6070109@dachary.org> <C93B376E-72EF-4822-9559-ECF6F2962AA7@cs.ucsc.edu> <51855512.20207@dachary.org> <C38EEFE7-DC29-4325-B268-5BB85B1E4D9A@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7377D700005C5E9DE50E50A3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:43983 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab3EDT0s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 May 2013 15:26:48 -0400
In-Reply-To: <C38EEFE7-DC29-4325-B268-5BB85B1E4D9A@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7377D700005C5E9DE50E50A3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 05/04/2013 08:47 PM, Noah Watkins wrote:
>=20
> On May 4, 2013, at 11:36 AM, Loic Dachary <loic@dachary.org> wrote:
>=20
>>
>>
>> On 05/04/2013 08:27 PM, Noah Watkins wrote:
>>>
>>> On May 4, 2013, at 10:16 AM, Loic Dachary <loic@dachary.org> wrote:
>>>
>>>> it would be great to get feedback before the ceph summit to address =
the most prominent issues.
>>>
>>> One thing that has been in the back of my mind is how this proposal i=
s influenced (if at all) by a future that includes declustered per-file r=
aid in CephFS. I realize that may be a distant future, but it seems as th=
ough there could be a lot of overlap for the (non-client driven) rebuild/=
recovery component of such an architecture.
>>
>> Hi Noah,
>>
>> I'm not sure what declustered per-file raid is, which means it had no =
influence on this proposal ;-) Would you be so kind as to educate me ?
>=20
> I'm definitely far from an expert on the topic. But briefly the way I t=
hink about it is:
>=20
> Currently CephFS stripes a file byte stream across a set of objects (e.=
g. first MB in object 0, 2nd in object 1, etc..), and each of these objec=
ts is in turn replicated. Following a failure, PGs re-replicate objects.
>=20
> In client drive raid the striping algorithm is changed, and clients are=
 calculating and distributing parity. In this case the parity rather than=
 replication provides redundancy. So, one might consider storing objects =
in a pool with replication size 1. However, the standard PG that does rep=
lication wouldn't be able to handle faults correctly (parity rebuild, rat=
her than re-replication), and a smart PG like the ErasureCodedPG would be=
 needed.
>=20
> So it seems like the problems are related, but I'm not sure exactly how=
 much overlap there is :)

Do you refer to http://ceph.com/docs/master/architecture/#how-ceph-client=
s-stripe-data when talking about client drive raid ? My understanding is =
that it is designed to maximize throughout. This is done in the client li=
brary ( gateway, rbd or cephfs ). Since erasure encoding is about recover=
ing from failures and would be implemented in libosd ( next to Replicated=
PG ), I am under the impression that there is no overlap.

What do you think ?

>=20
> -Noah
>=20
>=20
>> Cheers
>>
>>> -Noah
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.



--------------enig7377D700005C5E9DE50E50A3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGFYPYACgkQ8dLMyEl6F20+4ACgonwu+iKh1OmiCWBzAiRsq95a
JmIAoMD0gWwHuSgNkwpWkAdA88KW7Q/z
=ikfp
-----END PGP SIGNATURE-----

--------------enig7377D700005C5E9DE50E50A3--
