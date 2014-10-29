From: Loic Dachary <loic@dachary.org>
Subject: Re: Initializing paddles
Date: Thu, 30 Oct 2014 00:03:11 +0100
Message-ID: <5451722F.8010002@dachary.org>
References: <544B36D3.8050103@dachary.org>	<544C3238.7080305@dachary.org> <CAMfdg1MHsjbnGqGz3kLJAEOkU-QYN2oxwyvytSNkh+Bkg5UirA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3BaF1clwlLi7U6fU6K25JqRWNOBTGWLt2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55911 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756996AbaJ2XDO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 19:03:14 -0400
In-Reply-To: <CAMfdg1MHsjbnGqGz3kLJAEOkU-QYN2oxwyvytSNkh+Bkg5UirA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3BaF1clwlLi7U6fU6K25JqRWNOBTGWLt2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Zack,

On 29/10/2014 21:37, Zack Cerza wrote:
> You should actually be able to POST a json object with a 'name' key
> (and whichever other ones you want) to /nodes/ !

I completely missed that, thanks :-)

Cheers

> On Sat, Oct 25, 2014 at 5:28 PM, Loic Dachary <loic@dachary.org> wrote:=

>>
>>
>> On 24/10/2014 22:36, Loic Dachary wrote:
>>> Hi Zack,
>>>
>>> Now that I have a paddles server running, I'd like to populate it wit=
h two virtual machines I have running. Is there a script to do this or sh=
ould I just type  SQL statements to do that semi-intuitively ?
>>>
>>> $ curl 'http://localhost:8080/nodes/?machine_type=3Dvps&count=3D2'
>>> []
>>
>> I tried something like
>>
>> for id in 1 2 3 ; do sqlite3 dev.db "insert into nodes (id,name,machin=
e_type,is_container,is_vm,locked,up,locked_by) values ($id, 'container00$=
id', 'plana', 1, 0, 0, 1, 'scheduled');" ; done
>>
>> and it works so far (i.e. I'm making progress although I'm not to the =
point where a machine gets a job yet ;-)
>>
>> Cheers
>>
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


--3BaF1clwlLi7U6fU6K25JqRWNOBTGWLt2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRRcjAACgkQ8dLMyEl6F21YSQCfVilaIpaU8bRXwnPt4+NSKEMp
pcQAoIsuYoPSfZaZZIbGQnUj+PZEO/t5
=zPDN
-----END PGP SIGNATURE-----

--3BaF1clwlLi7U6fU6K25JqRWNOBTGWLt2--
