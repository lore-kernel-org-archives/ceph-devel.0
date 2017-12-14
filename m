From: Kai Wagner <kwagner@suse.com>
Subject: Re: Ceph Manager brag module
Date: Thu, 14 Dec 2017 14:04:03 +0100
Message-ID: <fbeeadf5-4976-d543-ac1d-f553a12a40e0@suse.com>
References: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
 <c55c2c37-22cc-543a-5950-b48add10bbb7@grimmer.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FqP1d2Oq0LxFNIqSSKmtvEtGVHKpThCvj"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:41438 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbdLNNER (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 14 Dec 2017 08:04:17 -0500
In-Reply-To: <c55c2c37-22cc-543a-5950-b48add10bbb7@grimmer.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lenz Grimmer <lenz@grimmer.com>, ceph-devel@vger.kernel.org
Cc: lvaz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FqP1d2Oq0LxFNIqSSKmtvEtGVHKpThCvj
Content-Type: multipart/mixed; boundary="mu6jmh6VmKM10EBGc7MFKOXKwmCkDAs3t";
 protected-headers="v1"
From: Kai Wagner <kwagner@suse.com>
To: Lenz Grimmer <lenz@grimmer.com>, ceph-devel@vger.kernel.org
Cc: lvaz@redhat.com
Message-ID: <fbeeadf5-4976-d543-ac1d-f553a12a40e0@suse.com>
Subject: Re: Ceph Manager brag module
References: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
 <c55c2c37-22cc-543a-5950-b48add10bbb7@grimmer.com>
In-Reply-To: <c55c2c37-22cc-543a-5950-b48add10bbb7@grimmer.com>

--mu6jmh6VmKM10EBGc7MFKOXKwmCkDAs3t
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hi Wido,


On 14.12.2017 12:44, Lenz Grimmer wrote:
> Hey Wido,
>
> On 12/14/2017 10:24 AM, Wido den Hollander wrote:
>
>> After discussing with Sage I started to work [0] on a 'brag' module fo=
r
>> Ceph Manager.
> Nice!
+1 great idea!
>> The intention of this module is to send (after a opt-in!) statistics
>> about a Ceph cluster back to the project every few days.
>>
>> My intention is to include:
>>
>> - fsid (as identifier)
>> - number of MONs
>> - number of OSDs
>> - FileStore / BlueStore
>> - number of pools / PGs
>> - data used in bytes
>> - data free
>> - number of objects,
>> - version(s)
> Not sure if that could actually be extracted, but how about "Services
> enabled", e.g. "RGW", "CephFS" or "RBD", with some additional insight
> (e.g. how many RBDs/buckets)?
>
> I think it would be valuable to obtain some (optional) insight into wha=
t
> that cluster is actually used for.
Two things. It would be really nice if the user could specify which of
those options they're willing to share, so these should be configurable.

Another thing I would like to add here is "performance" of the overall
cluster in general. So iop's/throughput/latency and so on. This way a
user could also check how the performance of their cluster evolved over
time.

Pretty nifty example: After a user upgraded their cluster to the newest
release was their a big performance win or drop maybe caused by this
update? This would be really helpful for everyone.
>
>> A admin can also say that the report is allowed to be 'public' where y=
ou
>> can then visit (for example) https://brag.ceph.com/public/<fsid> and
>> show off your Ceph cluster.
>>
>> You could then add a description and we could compile top lists about
>> Ceph systems.
>>
>> How do people think about this? Would this be interesting?
> Absolutely. One challenge I can see here (in addition to users actually=

> enabling it) is networking - I'd assume that many customers have
> restricted their networks, so the MGR cannot easily establish an
> outgoing connection without going through a proxy or before the admin
> has poked a hole into the firewall. This might require configuration
> options or corresponding documentation.
That true indeed, but I think customers who are willing to send reports
don't have a problem to route or open this port within their firewall.
>> I would try to convince most of my customers to send this information
>> back to the project. The more information we get, the better Ceph can
>> become.
>>
>> Wido
>>
>> [0]: https://github.com/wido/ceph/commits/mgr-brag
> Nice work!
>
> Lenz
>

--=20
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton=
, HRB 21284 (AG N=C3=BCrnberg)



--mu6jmh6VmKM10EBGc7MFKOXKwmCkDAs3t--

--FqP1d2Oq0LxFNIqSSKmtvEtGVHKpThCvj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJaMnbDAAoJEB6MkVYW48RucrYH/R2DfV4DxV6tWSAEKjOMRKcC
E4eTjUgXyCUriOlm6BBTX9cCX9x6UTnu9kobSwXHcrbJKC8DzBoIP9A70YWszOa/
JvfMPd8diX7CboKREvAILLkdRUWH2s7S0hrMV5yhMZv7/EtUJnVm6/wKJG53tmf2
iWNcL6/kKaXWZGKCBaYe6EAi/oc2EQY4hKB+KM8J7akljXPi4YPYvjraT3CxIB9c
9vI4V0zouLIJQnkG9ag8OYmgn4hVWECCmrOJGcfj+Q2HDj6v5PwVj+wpqeddzUC6
qBpYFvaOECN3j8aZ3I9Bl2mSpmtduAfRfXCDyNM5PVhWbGjH4HjhBHoHSsMccJw=
=RCOU
-----END PGP SIGNATURE-----

--FqP1d2Oq0LxFNIqSSKmtvEtGVHKpThCvj--
