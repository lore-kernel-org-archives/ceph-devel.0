From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: unstable branch won't come online
Date: Fri, 16 Apr 2010 11:37:54 +0200
Message-ID: <1271410674.4441.1.camel@wido-desktop>
References: <1271365867.3520.7.camel@wido-laptop.pcextreme.nl>
	 <Pine.LNX.4.64.1004151420100.15369@cobra.newdream.net>
Reply-To: wido@pcextreme.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:37361 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226Ab0DPJh7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Apr 2010 05:37:59 -0400
In-Reply-To: <Pine.LNX.4.64.1004151420100.15369@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

The new version didn't fix it, but a mkcephfs seemed to fix it, right
now my cluster is online and working.

--=20
Met vriendelijke groet,

Wido den Hollander
Hoofd Systeembeheer / CSO
Telefoon Support Nederland: 0900 9633 (45 cpm)
Telefoon Support Belgi=C3=AB: 0900 70312 (45 cpm)
Telefoon Direct: (+31) (0)20 50 60 104
=46ax: +31 (0)20 50 60 111
E-mail: support@pcextreme.nl
Website: http://www.pcextreme.nl
Kennisbank: http://support.pcextreme.nl/
Netwerkstatus: http://nmc.pcextreme.nl


On Thu, 2010-04-15 at 21:49 +0000, Sage Weil wrote:
> On Thu, 15 Apr 2010, Wido den Hollander wrote:
> > Hi Sage,
> >=20
> > I tried "debug filestore =3D 20" but it didn't seem to change much,=
 see
> > that attached log.
> >=20
> > I also attach my ceph.conf, any errors on my side?
>=20
> Ok, the problem is that snap_1 already exists (probably others, too).=
  I=20
> just pushed a fix to unstable that makes the osd more carefully remov=
e old=20
> directories or subvols it finds during the mkfs process which should =
fix=20
> your problem.  Alternatively, you can mkfs.btrfs beforehand to make s=
ure=20
> there's nothing old in the osd data dir, or pass --mkbtrfs to mkcephf=
s and=20
> let it do the mkfs.btrfs for you.
>=20
> sage

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
