From: Loic Dachary <loic@dachary.org>
Subject: Micro Ceph and OpenStack Design Summit November 3rd, 2014 11:40am
Date: Wed, 29 Oct 2014 18:54:21 +0100
Message-ID: <545129CD.3010303@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KRMTdvnSQ1moujKLfcchSPq4gUWUN9eBm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55750 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750918AbaJ2Ry2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 13:54:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KRMTdvnSQ1moujKLfcchSPq4gUWUN9eBm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

TL;DR: Register for the Micro Ceph and OpenStack Design Summit November 3=
rd, 2014 11:40am http://kilodesignsummit.sched.org/event/f2e49f4547a757cc=
3d51f5641b2000cb

November 3rd, 2014 11:40am, during the OpenStack summit in Paris[1], the =
present and the future of Ceph and OpenStack will be discussed with Ceph =
and OpenStack developers. The following agenda was prepared based on feed=
back from the participants[3]. It is however more of a guideline than a f=
ixed plan and everyone will be invited to participate.=20

* Ceph and OpenStack state & roadmap (30min)
  Josh Durgin and S=E9bastien Han

  * Glance
  * Nova
  * Cinder
  * Kilo Roadmap

* Ceph Performance tuning (30min)
  Josh Durgin

  Improved performances has become an increasingly important topic for Ce=
ph and it is discussed weekly with the community[4]. A short summary of e=
ach ongoing discussion topic will be presented. The latest action items d=
ecided during the Ceph Developer Summit[5] that happens this week will al=
so be discussed.

  * Async Messenger
  * XIO Messenger
  * RBD IOPS Performance
  * OSD Performance
  * Cache Tiering Performance
  * Monitor Performances
  * Sequential/Random Disk Throughput
  * LTTNG tracepoints
  * Erasure Code LRC, ISA and NEON

* OpenStack and Ceph Deployment automation (30min)
  S=E9bastien Han and Lo=EFc Dachary

  Ceph was improved to make it easier to write modules/recipes for all ki=
nds of deployment tools. They are at various stages of maturity and it is=
 often quite difficult to figure out which one is right in a given contex=
t. We will give a short tour of the current state of each tool, the devel=
opment effort behind them and what we can expect in the near future.

  * ansible
  * ceph-deploy
  * juju
  * puppet
  * chef

Cheers

[1] OpenStack Summit Paris https://www.openstack.org/summit/openstack-par=
is-summit-2014/
[2] Ceph for OpenStack Design Session http://kilodesignsummit.sched.org/e=
vent/f2e49f4547a757cc3d51f5641b2000cb
[3] Pad preparation https://etherpad.openstack.org/p/kilo-ceph
[4] Weekly Ceph Performance Meeting https://www.mail-archive.com/ceph-dev=
el@vger.kernel.org/msg20744.html and http://pad.ceph.com/p/performance_we=
ekly
[5] Ceph Developer Summit https://wiki.ceph.com/Planning/CDS/Hammer_%28Oc=
t_2014%29

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--KRMTdvnSQ1moujKLfcchSPq4gUWUN9eBm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRRKc0ACgkQ8dLMyEl6F232MQCdFH+CeuqNCpJ/GB3w4JeCTKxE
VcIAn2sLs7KsDyL2CkiB2v1yWqYmW77d
=5KzL
-----END PGP SIGNATURE-----

--KRMTdvnSQ1moujKLfcchSPq4gUWUN9eBm--
