From: Alfredo Deza <adeza@redhat.com>
Subject: Re: pulpito slowness
Date: Mon, 20 Jul 2015 08:05:16 -0400 (EDT)
Message-ID: <777209038.608223.1437393916818.JavaMail.zimbra@redhat.com>
References: <55ABD6AC.3030903@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:55193 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbbGTMGX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 08:06:23 -0400
In-Reply-To: <55ABD6AC.3030903@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Alfredo Deza" <adeza@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Sunday, July 19, 2015 12:56:12 PM
> Subject: pulpito slowness
>=20
> Hi Alfredo,
>=20
> After installing pulpito and run from sources with:
>=20
>         virtualenv ./virtualenv
>         source ./virtualenv/bin/activate
>         pip install -r requirements.txt
>         python run.py &
>=20
> I run a rados suite with 40 workers and 218 jobs. All is well except =
a
> slowness from pulpito that I don't quite understand. It takes 9 secon=
ds to
> load although the load average of the machine is low, the CPU are not=
 all
> busy, there is plenty of free ram.

There are pieces of the setup that might be causing this. Pulpito on it=
s own doesn't do much, it is stateless
and just serves HTML.

I would look into paddles (pulpito feeds from it) and see how that is d=
oing. Ideally, paddles would be setup with
PostgreSQL as well, I remember that at some point the queries became ve=
ry complex in paddles and some investigation
was done to improve their speed.



>=20
> ubuntu@teuthology:~$ curl
> http://localhost:8081/ubuntu-2015-07-19_15:57:13-rados-hammer---basic=
-openstack/
> > /dev/null  % Total    % Received % Xferd  Average Speed   Time    T=
ime
> Time  Current
>                                  Dload  Upload   Total   Spent    Lef=
t  Speed
> 100  391k  100  391k    0     0  42774      0  0:00:09  0:00:09 --:--=
:--
> 96305
>=20
> Do you have an idea of the reason for this slowness ?
>=20
> Cheers
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
