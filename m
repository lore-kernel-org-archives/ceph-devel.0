From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] Ceph v0.79 Firefly RC :: erasure-code-profile
 command set not present
Date: Tue, 8 Apr 2014 08:01:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1404080801250.28550@cobra.newdream.net>
References: <3423E02F-D2A2-4E7A-99BF-9B277FF3AB19@csc.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-375775867-1396969299=:28550"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45388 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756780AbaDHPBk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 11:01:40 -0400
In-Reply-To: <3423E02F-D2A2-4E7A-99BF-9B277FF3AB19@csc.fi>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karan Singh <karan.singh@csc.fi>
Cc: ceph-users <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-375775867-1396969299=:28550
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Apr 2014, Karan Singh wrote:
> Thanks Developers for 0.79 , happy to see its announcement.
> I have been using 0.78 in order to test EC and TP , with 0.78 i was not=
 able
> to test erasure code profile feature =A0( #=A0ceph osd erasure-code-pro=
file
> set=A0myprofile=A0??) as erasure-code-profile command set is not=A0pres=
ent in 0.78 but
> its mentioned in documentation.
>=20
> http://ceph.com/docs/master/dev/erasure-coded-pool/#interface
> https://ceph.com/docs/v0.78/dev/erasure-coded-pool/#interface
> https://ceph.com/docs/v0.79/dev/erasure-coded-pool/#interface
>=20
> I tried the same thing on 0.79 , but again looks like ?=A0ceph osd
> erasure-code-profile=A0?=A0command set is not implemented here as well.
>=20
> Do we need to wait for 0.80 release to test erasure-code-profile =A0fea=
ture
> ??=A0
>=20
>=20
> # cat /etc/redhat-release
> CentOS release 6.4 (Final)
>=20
> # ceph -v
> ceph version 0.79 (4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)
>=20
> # ceph osd erasure-code-profile
> no valid command found; 10 closest matches:

Did you restart the ceph-mon daemons?

sage


> osd tier add-cache <poolname> <poolname> <int[0-]>
> osd tier set-overlay <poolname> <poolname>
> osd tier remove-overlay <poolname>
> osd tier remove <poolname> <poolname>
> osd tier cache-mode <poolname> none|writeback|forward|readonly
> osd thrash <int[0-]>
> osd tier add <poolname> <poolname> {--force-nonempty}
> osd stat
> osd reweight-by-utilization {<int[100-]>}
> osd pool stats {<name>}
> Error EINVAL: invalid command
> #
>=20
>=20
>=20
> ****************************************************************
> Karan Singh=A0
> CSC - IT Center for Science,
> Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
> mobile: +358 503 812758
> tel. +358 9 4572001
> fax +358 9 4572302
> http://www.csc.fi/
> ****************************************************************
>=20
>=20
>=20
--557981400-375775867-1396969299=:28550--
