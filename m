From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology task waiting for machines (> 8h)
Date: Sat, 28 Jun 2014 18:51:28 +0200
Message-ID: <53AEF290.5040603@dachary.org>
References: <53AE987A.6080500@dachary.org> <CAJBxG-v3u0PyJkbYv2zEwLJqBfUu4hAOwL3Pv0XhoNj+=0iPrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VHDRnkUV3q9bpQAVBuNsGw5Iut9fixUeR"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59539 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751200AbaF1Qvg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Jun 2014 12:51:36 -0400
In-Reply-To: <CAJBxG-v3u0PyJkbYv2zEwLJqBfUu4hAOwL3Pv0XhoNj+=0iPrQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VHDRnkUV3q9bpQAVBuNsGw5Iut9fixUeR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 28/06/2014 17:47, Yuri Weinstein wrote:
> Technically yes.
>=20
> If queue is busy - patience is needed.
>=20
> Assuming that there are no runs in the queue which are hung.  Zack is
> diligently looking and fixing to prevent hung tests.  If we see runs
> older then say one day, we kill them (altho 'teuthology-kill' is not
> working for me today :( )

Hi Yuri,

This is reassuring :-) Patience is easy during the week-ends.

> Another option to speed up run - use PRIO (for priority) when
> scheduling it and/or use not plana machines as they are in high
> demand.

Unless there is a specific reason to run rados / upgrade suites on plana =
machines, which other types of machine do you recommend ?

Cheers

>=20
> Thx
> YuriW
>=20
> On Sat, Jun 28, 2014 at 3:27 AM, Loic Dachary <loic@dachary.org> wrote:=

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


--VHDRnkUV3q9bpQAVBuNsGw5Iut9fixUeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOu8pAACgkQ8dLMyEl6F20BAwCfRge9MLIS+LZcl7UBe906FKQ5
9hAAoLXh0pdAMvfRdaNDaiGHhOiAqq27
=g961
-----END PGP SIGNATURE-----

--VHDRnkUV3q9bpQAVBuNsGw5Iut9fixUeR--
