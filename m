From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology : 70 workers need more than 8GB RAM / 2 CPUS
Date: Mon, 20 Jul 2015 19:03:56 +0200
Message-ID: <55AD29FC.7080607@dachary.org>
References: <55AB9671.7050509@dachary.org> <55ABBD01.3070002@dachary.org> <1465341299.749891.1437406687557.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cV5Cbx593UGG901qnC1oDt2L9qKiDDsXu"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53168 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751534AbbGTRD7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 13:03:59 -0400
In-Reply-To: <1465341299.749891.1437406687557.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Andrew Schoen <aschoen@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cV5Cbx593UGG901qnC1oDt2L9qKiDDsXu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback. I'll try with postgresql as it seems the sqlite =
modifications did nothing really significant.

On 20/07/2015 17:38, Zack Cerza wrote:
> Hi Loic,
>=20
> This is definitely something to keep an eye on. It's actually a bit sur=
prising to me, though - I haven't seen ansible-playbook use any significa=
nt resources in sepia.
>=20
> I wouldn't really recommend running paddles on the same host as teuthol=
ogy though, to do any serious amount of testing; some teuthology tasks do=
 use large amounts of RAM and/or CPU, and severe load issues could feasib=
ly cause requests to time out, affecting other jobs.
>=20
> That's all theory though, as I've always used separate hosts for the tw=
o services.
>=20
> Zack
>=20
> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Zack Cerza" <zack@redhat.com>, "Andrew Schoen" <aschoen@redhat.co=
m>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Sunday, July 19, 2015 9:06:41 AM
>> Subject: Re: teuthology : 70 workers need more than 8GB RAM / 2 CPUS
>>
>> Hi again,
>>
>> I had the same problem when 50 workers kick in at the same time. I've =
lowered
>> the number of workers down to 25 and it went well. During a few minute=
s (~8
>> minutes) the load average stayed around 25 (CPU bound, mainly the ansi=
ble
>> playbook competing, see the screenshot of htop). But did not see any e=
rror /
>> timeout. then I added 15 workers, wait for the load to go back to < 2 =
(10
>> minutes), then 15 more (10 minutes) to get to 55.
>>
>> That sound like a log of CPU used by a single playbook run. Is there a=
 known
>> way to reduce that ? If not I'll just upgrade the machine. Just want t=
o make
>> sure I'm not missing a simple solution ;-)
>>
>> Cheers
>>
>> On 19/07/2015 14:22, Loic Dachary wrote:
>>> Hi,
>>>
>>> For the record, I launched a rados suite on an idle teuthology cluste=
r,
>>> with 70 workers running on a 8GB RAM / 2 CPUS / 40GB SSD disk. The lo=
ad
>>> average reached 40 within a minute or two and some jobs started faili=
ng /
>>> timeouting. I had pulpito running on the same machine and it failed o=
ne
>>> time out of two because of the load (see the top image).
>>>
>>> On friday I was able to run 70 workers because I gradually added them=
=2E The
>>> load peak is when a job starts and all workers kick in a the same tim=
e.
>>>
>>> Cheers
>>>
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


--cV5Cbx593UGG901qnC1oDt2L9qKiDDsXu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWtKfwACgkQ8dLMyEl6F23KGQCeL3r9+qOydoXc0Eka7yUzXNxu
4rEAn3njoJSDC4Zzo5yI6FfgJg8tUijQ
=7r3U
-----END PGP SIGNATURE-----

--cV5Cbx593UGG901qnC1oDt2L9qKiDDsXu--
