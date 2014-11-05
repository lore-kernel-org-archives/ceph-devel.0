From: Loic Dachary <loic@dachary.org>
Subject: Re: Consul
Date: Wed, 05 Nov 2014 09:38:06 +0100
Message-ID: <5459E1EE.90509@dachary.org>
References: <54597169.2040006@dachary.org> <CAGRK8cwq0WkSG98mavGRe4vFzwyK9dqTrgc9knQaE2n0e-YGjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="s67qd2O5tOIrHAbCHItWOUBQAQHKxtiaA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59451 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860AbaKEIiO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 03:38:14 -0500
In-Reply-To: <CAGRK8cwq0WkSG98mavGRe4vFzwyK9dqTrgc9knQaE2n0e-YGjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hunter Nield <hunter@acale.ph>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s67qd2O5tOIrHAbCHItWOUBQAQHKxtiaA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/11/2014 04:05, Hunter Nield wrote:
> I concur with Dan on Consul. It's a great tool.
>=20
> We use Consul in our Ceph environments but only as a layer above an
> installed Ceph installation. Health checks (for the mons/osds
> processes and ceph health) and service discovery (for the
> apps/services that run in Docker containers on top). We've started on
> an alerting tool if anyone has use for it -
> https://github.com/AcalephStorage/consul-alerts
>=20
> There is definitely some overlap on the cluster consensus side (Paxos
> vs Raft) and would be nice to reduce another moving part in our
> cluster but I would imagine the projects are too different internally
> to really combine the two of them.
>=20
> The one thing that we'd wished for in Ceph before Consul existed was
> an easily accessible distributed KV store. Ceph has parts of it but
> exposing something like that with an easy CLI/REST API might provide
> the primitives for building higher level functionality that Consul
> provides. More than likely a distraction though since Consul does such
> a good job now.

I guess using radosgw with the S3/Swift API is close enough in terms of w=
hat Consul needs to store key/values. But maybe I don't understand what y=
ou mean by "easily accessible distributed KV store" and wrongly assume ra=
dosgw is easy enough ;-)=20

> On a side note, I haven't spoken to Dan in a while but curious on his
> thoughts on the overlap on Consul in config management land. Service
> discovery, remote execution, etc have some overlap in Puppet, Chef,
> etc. Related to Ceph we're pondering it as alternative for deploying
> mons/osds (larger scale ceph-deploy perhaps)

Is there a framework for integration tests of some kind in Consul ? Altho=
ugh https://github.com/puppetlabs/beaker/ provides that for puppet, it is=
 still rarely used and it is painful because even when used to develop a =
module, it is likely to break in unpredictable ways because module depend=
encies have no integration tests and suffer from frequent regressions. It=
 would be great to see modern tools such as Consul encourage a more robus=
t approach to integration tests with proper tooling from the start.

Cheers

> On Wed, Nov 5, 2014 at 8:38 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Ceph,
>>
>> While at the OpenStack summit Dan Bode spoke highly of Consul ( https:=
//consul.io/intro/index.html ). Its scope is new to me. Each individual f=
eature is familiar but I'm not entirely sure if combining them into a sin=
gle software is necessary. And I wonder how it could relate to Ceph. It i=
s entirely possible that it does not even make sense to ask theses questi=
ons ;-)
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--s67qd2O5tOIrHAbCHItWOUBQAQHKxtiaA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRZ4e4ACgkQ8dLMyEl6F23u0wCguomDMhlOBwKO4LIFoHEO+Hnk
nqQAoMG7ca4awkMIqQ4I0GMzB8VetMqx
=ruHU
-----END PGP SIGNATURE-----

--s67qd2O5tOIrHAbCHItWOUBQAQHKxtiaA--
