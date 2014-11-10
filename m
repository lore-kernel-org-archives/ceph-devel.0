From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph & Cinder & HA
Date: Mon, 10 Nov 2014 11:51:49 +0100
Message-ID: <546098C5.4070709@dachary.org>
References: <545B9A53.4040502@dachary.org> <DAB091EE-E314-40D3-99F3-710E91ECC4D2@iweb.com> <545C927E.9010807@redhat.com> <CAOGLoJMMHZ3q9VxAG0B0ge6kaVdKZ1xVZLrjAFWZUGHf6kAeew@mail.gmail.com> <11F50ACF-55E9-4D2F-AD08-814FE5998089@enovance.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tWAqdbe1pAKnafJuBVpjv8K6vpVCsMAmk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34068 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752313AbaKJKv4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Nov 2014 05:51:56 -0500
In-Reply-To: <11F50ACF-55E9-4D2F-AD08-814FE5998089@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <sebastien.han@enovance.com>
Cc: Giulio Fidente <gfidente@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tWAqdbe1pAKnafJuBVpjv8K6vpVCsMAmk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/11/2014 11:34, Sebastien Han wrote:
> Indeed, that=E2=80=99s what we discussed with Giulio, using HAProxy for=
 the Monitors is a bit overkill since the client is natively able to swit=
ch between different monitor source.
>=20
> Loic, maybe you can elaborate a bit more on the usage of HAProxy for th=
e monitors?

Hi Sebastien,

I can't elaborate because I know nothing about HAProxy (well, close to no=
thing ;-). I'd like to learn more about how HA (via HAProxy or something =
else) can leverage Ceph in a meaningfull way thouhg, hence my interest fo=
r the topic.

Cheers

>=20
>> On 09 Nov 2014, at 22:54, Justin Erenkrantz <justin@erenkrantz.com> wr=
ote:
>>
>> On Fri, Nov 7, 2014 at 4:35 AM, Giulio Fidente <gfidente@redhat.com> w=
rote:
>>> The architecture we're considering is as follows:
>>>
>>>  keepalived
>>>    haproxy
>>>      ceph-mon
>>>
>>> where haproxy and ceph-mon are always up on all openstack 'controller=
' nodes
>>> (also running cinder) and keepalived is taking care of managing a vir=
tual ip
>>> hosted on one of those
>>
>> For Ceph, you almost certainly don't need to use keepalived or haproxy=

>> as all Ceph clients will fail over to the full set of monitor IPs (you=

>> need a way of distributing those IPs to the cluster -
>> chef/puppet/ansible/etc/etc can handle that).  Having
>> keepalived/haproxy in the loop for ceph-mon is one more thing that
>> could break.
>>
>> We do run cinder services behind the controller/headnodes nodes via
>> keepalived/haproxy - the "trick" such as it is for Ceph is to set all
>> the hostnames in cinder to being the same and it works okay.  See:
>>
>> https://github.com/bloomberg/chef-bcpc/blob/master/cookbooks/bcpc/temp=
lates/default/cinder.conf.erb
>>
>> We haven't seen any issues in an active/active configuration; though
>> there are some MySQL schema deadlocks that aren't necessarily related
>> to Ceph sitting in Cinder.
>>
>> Cheers.  -- justin
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> Cheers.
> =E2=80=93=E2=80=93=E2=80=93=E2=80=93=20
> S=C3=A9bastien Han=20
> Cloud Architect=20
>=20
> "Always give 100%. Unless you're giving blood."
>=20
> Phone: +33 (0)1 49 70 99 72=20
> Mail: sebastien.han@enovance.com=20
> Address : 11 bis, rue Roqu=C3=A9pine - 75008 Paris
> Web : www.enovance.com - Twitter : @enovance=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--tWAqdbe1pAKnafJuBVpjv8K6vpVCsMAmk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRgmMUACgkQ8dLMyEl6F22AvACfRw27xFpx2OC/s2DXv6uLLX6l
eOcAn0O9XHPwbVyYeVS0CITf4tsQkZl8
=N47d
-----END PGP SIGNATURE-----

--tWAqdbe1pAKnafJuBVpjv8K6vpVCsMAmk--
