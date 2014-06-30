From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology task waiting for machines (> 8h)
Date: Mon, 30 Jun 2014 17:10:33 +0200
Message-ID: <53B17DE9.2040700@dachary.org>
References: <53AE987A.6080500@dachary.org> <CAMfdg1M5JxNjeg=1KOaqe7MAVLtGq8Fd_oEd5exZKqauesY8KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kTn7IDB35n7uwm9PJ0SGLMvH0AaV9Cl47"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60911 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750815AbaF3PKk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 11:10:40 -0400
In-Reply-To: <CAMfdg1M5JxNjeg=1KOaqe7MAVLtGq8Fd_oEd5exZKqauesY8KQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack.cerza@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kTn7IDB35n7uwm9PJ0SGLMvH0AaV9Cl47
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Zack,

Thanks for the tip, I'll try it next time :-)

Cheers

On 30/06/2014 16:10, Zack Cerza wrote:
> Hi Loic,
>=20
> At this point I don't really have a way to look back in time to see
> what was going on, but in the future when jobs are blocked waiting for
> machines for unreasonable periods it's useful to know what is holding
> them:
>=20
> teuthology-lock --brief -a --machine-type plana | sort -k +4
>=20
> Thanks,
> Zack
>=20
> On Sat, Jun 28, 2014 at 4:27 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Zack,
>>
>> http://pulpito.ceph.com/loic-2014-06-27_18:45:37-upgrade:firefly-x:str=
ess-split-wip-8475-testing-basic-plana/329515/
>>
>> seems to indicate that the tasks cannot obtain the machines it needs:
>>
>> 2014-06-27T17:55:19.072 INFO:teuthology.task.internal:Locking machines=
=2E..
>> 2014-06-27T17:55:19.110 INFO:teuthology.task.internal:waiting for more=
 machines to be free (need 3 see 5)...
>> 2014-06-27T17:55:29.175 INFO:teuthology.task.internal:waiting for more=
 machines to be free (need 3 see 5)...
>> ...
>> 2014-06-28T03:22:13.745 INFO:teuthology.task.internal:waiting for more=
 machines to be free (need 3 see 0)...
>> 2014-06-28T03:22:23.787 INFO:teuthology.task.internal:waiting for more=
 machines to be free (need 3 see 0)...
>>
>> Is it something expected (for instance when tasks with a higher priort=
y take precedence) ? If it is then all that's needed is patience right ?
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--kTn7IDB35n7uwm9PJ0SGLMvH0AaV9Cl47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOxfekACgkQ8dLMyEl6F23XlQCggISOqIs2fr6z/Ce2y2lDXEvx
ZHkAoLPI3N40rP3KlpMH/ASJ1Y58y5f/
=k40j
-----END PGP SIGNATURE-----

--kTn7IDB35n7uwm9PJ0SGLMvH0AaV9Cl47--
