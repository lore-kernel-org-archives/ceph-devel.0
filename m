From: Loic Dachary <loic@dachary.org>
Subject: Re: failed to open http://apt-mirror.front.sepia.ceph.com
Date: Wed, 23 Sep 2015 19:01:20 +0200
Message-ID: <5602DAE0.4000403@dachary.org>
References: <56027EE3.5080909@gmail.com> <56027F1D.90508@gmail.com> <56028812.1050207@dachary.org> <alpine.DEB.2.00.1509230611360.11876@cobra.newdream.net> <5602C398.7000905@dachary.org> <5602D83C.5090901@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="37rJvOGHbgDGNOQs0WTxs3tHe2WNQ5N40"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60104 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932126AbbIWRBY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 13:01:24 -0400
In-Reply-To: <5602D83C.5090901@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: wangsongbo <songbo1227@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--37rJvOGHbgDGNOQs0WTxs3tHe2WNQ5N40
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23/09/2015 18:50, wangsongbo wrote:
> Sage and Loic,
> Thanks for your reply.
> I am running teuthology in our testing.I can send a traceroute to 64.90=
=2E32.37.
> but when ceph-cm-ansible run the " yum-complete-transaction --cleanup-o=
nly" command,
> it got such a response :"http://apt-mirror.front.sepia.ceph.com/misc-rp=
ms/repodata/repomd.xml: [Errno 14] PYCURL ERROR 7 - "Failed connect to ap=
t-mirror.front.sepia.ceph.com:80; Connection timed out"
> And I replace "apt-mirror.front.sepia.ceph.com"  to "64.90.32.37" in re=
po file, then run "yum-complete-transaction --cleanup-only" command,
> I got a response like this:"http://64.90.32.37/misc-rpms/repodata/repom=
d.xml: [Errno 14] PYCURL ERROR 22 - "The requested URL returned error: 50=
2 Bad Gateway""
> I do not know whether it was affected by the last week's attack.

Querying the IP directly won't get you where the mirror is (it's a vhost)=
=2E I think ansible fails because it queries the DNS and does not use the=
 entry you set in the /etc/hosts file. The OpenStack teuthology backend s=
ets a specific entry in the DNS to workaround the problem (see https://gi=
thub.com/ceph/teuthology/blob/master/teuthology/openstack/setup-openstack=
=2Esh#L318)

Cheers

>=20
> Thanks and Regards,
> WangSongbo
>=20
> On 15/9/23 =E4=B8=8B=E5=8D=8811:22, Loic Dachary wrote:
>>
>> On 23/09/2015 15:11, Sage Weil wrote:
>>> On Wed, 23 Sep 2015, Loic Dachary wrote:
>>>> Hi,
>>>>
>>>> On 23/09/2015 12:29, wangsongbo wrote:
>>>>> 64.90.32.37 apt-mirror.front.sepia.ceph.com
>>>> It works for me. Could you send a traceroute
>>>> apt-mirror.front.sepia.ceph.com ?
>>> This is a private IP internal to the sepia lab.  Anythign outside the=
 lab
>>> shouldn't be using it...
>> This is the public facing IP and is required for teuthology to run out=
side of the lab (http://tracker.ceph.com/issues/12212).
>>
>> 64.90.32.37 apt-mirror.front.sepia.ceph.com
>>
>> suggests the workaround was used. And a traceroute will confirm if the=
 resolution happens as expected (with the public IP) or with a private IP=
 (meaning the workaround is not in place where it should).
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--37rJvOGHbgDGNOQs0WTxs3tHe2WNQ5N40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYC2uAACgkQ8dLMyEl6F226mwCguQ8lgC5HR80Y+rjsPNiHkxxF
PigAn3uUlOeRG9y0rZA8tnPnwDilLaAC
=7zQa
-----END PGP SIGNATURE-----

--37rJvOGHbgDGNOQs0WTxs3tHe2WNQ5N40--
