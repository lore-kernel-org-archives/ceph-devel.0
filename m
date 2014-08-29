From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH] daemons: write pid file even when told not to daemonize
Date: Fri, 29 Aug 2014 10:40:43 +0200
Message-ID: <54003C8B.8090000@dachary.org>
References: <or4mxyuvo4.fsf@free.home> <53D9C379.9070904@dachary.org>	<alpine.DEB.2.00.1407302129530.18917@cobra.newdream.net>	<or7g1tawy9.fsf@free.home> <53FEE3B8.4070902@dachary.org> <oriolbajch.fsf@free.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mclFdW4AOjGFLTd7NT1GwF9VEpdMNGQeN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40243 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752288AbaH2Ikv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Aug 2014 04:40:51 -0400
In-Reply-To: <oriolbajch.fsf@free.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mclFdW4AOjGFLTd7NT1GwF9VEpdMNGQeN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 29/08/2014 08:41, Alexandre Oliva wrote:
> On Aug 28, 2014, Loic Dachary <loic@dachary.org> wrote:
>=20
>> Changing this behavior is not backward compatible but it is indeed mor=
e intuitive. Has it been a significant inconvenience so far ?
>=20
> Before I wrote the patch, it was very inconvenient: in order to stop
> ceph services, I had to dig up the PIDs from ps output and then kill th=
e
> processes manually, and I had to run ceph without my monitor that
> automatically restarted services that died (checking that the pid file
> was absent, or that the PID it named was not a running process).
>=20
> After I applied the patch in my local build, I could just forget about
> the earlier problems, and none surfaced because of the creation of the
> PID file.
>=20
> Is this what you were asking?

Hi Alexandre,

After a quick glance at the systemd man page http://www.freedesktop.org/s=
oftware/systemd/man/systemd.service.html#Options it seems possible to do =
something like

    https://github.com/dachary/ceph/compare/wip-systemd?expand=3D1

Alternatively, shouldn't systemctl kill ceph-osd@10.service be the canoni=
cal way of killing a process spawned by systemd ?

If both are impractical or frowned upon for some reason, it looks like yo=
ur patch is the only way to go, indeed.

Cheers

>=20
>> On 28/08/2014 09:35, Alexandre Oliva wrote:
>>> On Jul 31, 2014, Sage Weil <sweil@redhat.com> wrote:
>>>
>>>> On Thu, 31 Jul 2014, Loic Dachary wrote:
>>>>> Hi Alexandre,
>>>>>
>>>>> With this patch ceph-osd -f will try to create the default pid file=
 :=20
>>>>> this is a non backward compatible change. Maybe there is a way for =

>>>>> systemd to capture the pid of the process and store it instead of=20
>>>>> requiring the deamon to create the pid file ?
>>>
>>>> Do we need the pid file at all when we aren't using sysinit?
>>>
>>> My own monitoring scripts use it, and ceph stop use it as well.  I wa=
s
>>> surprised we were not creating them in spite of an explicit command l=
ine
>>> option to do so.
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--mclFdW4AOjGFLTd7NT1GwF9VEpdMNGQeN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQAPIwACgkQ8dLMyEl6F21uXgCbBDw33eUF2gqrKkQnLmf+6r5E
38YAn2BJSab0Jz7IqyBBEhJAf/8NfZBT
=wdVa
-----END PGP SIGNATURE-----

--mclFdW4AOjGFLTd7NT1GwF9VEpdMNGQeN--
