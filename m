From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: Re: Kernel crashes with RBD
Date: Sat, 14 Apr 2012 01:03:50 +0200
Message-ID: <4F88B0D6.6030401@bisect.de>
References: <4F860619.5040802@bisect.de> <4F88670A.7080709@dreamhost.com> <4F886E09.7040801@bisect.de> <4F8892E4.6030504@dreamhost.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE381B17EF2923C743E60DAAC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:43834 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756262Ab2DMXEG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 Apr 2012 19:04:06 -0400
In-Reply-To: <4F8892E4.6030504@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@dreamhost.com>, Alex Elder <elder@dreamhost.com>, Danny Kukawka <dkukawka@suse.de>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE381B17EF2923C743E60DAAC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 13.04.2012 22:56, schrieb Josh Durgin:
> On 04/13/2012 11:18 AM, Danny Kukawka wrote:
>> Hi
>>
>> Am 13.04.2012 19:48, schrieb Josh Durgin:
>>> On 04/11/2012 03:30 PM, Danny Kukawka wrote:
>> [...]
>>>
>>> This looks similar to http://tracker.newdream.net/issues/2261. What d=
o
>>> you think Alex?
>>
>> Not sure about that, since this crashes only the clients and not the
>> OSDs. We see no crashes in the cluster.
>=20
> These are both rbd kernel client crashes, but looking again they seem
> like different underlying issues, so I opened
> http://tracker.newdream.net/issues/2287 to track this problem.
>=20
>>
>> I analyzed it a bit more and found that the last working version was
>> 0.43. Any later released version leads to this crash sooner or later,
>> but as I already said only on a 10Gbit (FC) network. I didn't see any
>> crash on the 1Gbit net on the same machines.
>>
>> What kind of network do you use at dreamhost for testing?
>=20
> Mostly 1Gbit, some 10Gbit, but I don't think we've tested the kernel
> client on 10Gbit yet.

That's what I assumed ;-)

>> If you need more info, let me known.
>=20
> Do the crashes always have the same stack trace? When you say 10Gbit
> for the cluster, does that include the client using rbd, or just the
> osds?

It's always the same stack trace (sometimes a address is different, but
everything else looks identical).

We tested basically the following setups and the crash happend with all
of them:
1) OSD, MON and Clients in the same 10Gbit network
2) OSD, MON and Clients in different public/cluster 10Gbit networks
3) OSD and Clients in the same 10Gbit network, MON in 1Gbit network
3) OSD and Clients in the same 10Gbit network, MON in 1Gbit network
   different public/cluster networks

The number of OSDs (tested 4 nodes with 10 OSDs per node, each one
physical harddisk) didn't matter in this case. If I use 2 clients
running fio tests against one 50GByte RBD per client, I hit the problem
faster than with one client. If you need information about the used fio
tests, let me know.

As already I said: we didn't hit this problem with 1Gbit networks yet.

Danny


--------------enigE381B17EF2923C743E60DAAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iJwEAQECAAYFAk+IsOEACgkQ9DHLX79LmTJTCwQAmJBD0h5WCEhAuP4x1BtACluF
OdssX5M9w64eEOFBSv8/Ddk/IMrXmZEqp+Fxxb5QAvVEI3/NAzjgrRm5DNoqtCPV
zspMEjURfoosrZOvRALpLWHfKpNHForCtBEU981oQAq1gfVN/OSurlsuq2Lwf8+W
CwYA//OsjqhMRTeFEpw=
=Oyio
-----END PGP SIGNATURE-----

--------------enigE381B17EF2923C743E60DAAC--
