From: Loic Dachary <loic@dachary.org>
Subject: Re: ObjectContext : check that all references are gone
Date: Tue, 16 Jul 2013 17:28:45 +0200
Message-ID: <51E566AD.100@dachary.org>
References: <51E44C97.8040902@dachary.org> <alpine.DEB.2.00.1307151452110.3857@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFE67C0D4169846B82B7A6F6C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:56855 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241Ab3GPP2t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jul 2013 11:28:49 -0400
In-Reply-To: <alpine.DEB.2.00.1307151452110.3857@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE67C0D4169846B82B7A6F6C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 15/07/2013 23:53, Sage Weil wrote:
> On Mon, 15 Jul 2013, Loic Dachary wrote:
>> Hi Sage,
>>
>> You mentionned that there is code somewhere checking the fact that all=
 references to an ObjectContext are gone and that replacing manual refere=
nce counting with shared_ptr should preserve this ( i.e. in relation to h=
ttps://github.com/ceph/ceph/pull/414 "replace ObjectContext pointers with=
 shared_ptr" ). However, I've not been able to find such code. Would you =
be so kind as to show me where it is ?
>>
>> Cheers
>=20
> It's in ReplicatedPG.cc:
>=20
> void ReplicatedPG::on_flushed()
> {
>   assert(object_contexts.empty());
> }
>=20
> which is called from the Reset state of the PG peering state machine.

It is still here:

https://github.com/dachary/ceph/blob/1a7e390965e6b03f72360f016b2e7d852c45=
5784/src/osd/ReplicatedPG.cc#L6659

and should be ok. Although the de-allocation happens after the last share=
d_ptr<> goes out of scope instead of being deleted by an explicit call to=
 put_object_context, I believe it happens before on_flushed() is invoked =
at

https://github.com/dachary/ceph/blob/1a7e390965e6b03f72360f016b2e7d852c45=
5784/src/osd/PG.cc#L5225

I can't imagine a case where it would assert with the proposed patch.=20

Cheers
>=20
> sage
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigFE67C0D4169846B82B7A6F6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHlZq0ACgkQ8dLMyEl6F208LwCaArLPg3HN5ep9kYTHQTJvZm0i
w8QAoJmFylVIaTvhj+L0WZJjnzfb1Axr
=06Kg
-----END PGP SIGNATURE-----

--------------enigFE67C0D4169846B82B7A6F6C--
