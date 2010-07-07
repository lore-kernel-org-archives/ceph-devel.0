From: Sage Weil <sage@newdream.net>
Subject: Re: cmds segfault on startup (ceph.git/unstable)
Date: Wed, 7 Jul 2010 07:44:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007070743510.23002@cobra.newdream.net>
References: <i11j40$mk1$3@dough.gmane.org> <1278496830.1946.5.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2002872900-1278513856=:23002"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38475 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081Ab0GGOmp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jul 2010 10:42:45 -0400
In-Reply-To: <1278496830.1946.5.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@pcextreme.nl>
Cc: Thomas Mueller <thomas@chaschperli.ch>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2002872900-1278513856=:23002
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 7 Jul 2010, Wido den Hollander wrote:
> Hi Thomas,
>=20
> I just noticed the same, see my issue:
> http://tracker.newdream.net/issues/259
>=20
> Seems to be due to this commit: 83d1ea6636dd432dcbb6a0c6046d551bee7be5c6
>=20
> Rolling back one revision right now to see if it indeed is the problem.

Yeah, that was the one.  Fixed by 9432a958.

sage

>=20
> --=20
> Met vriendelijke groet,
>=20
> Wido den Hollander
> Hoofd Systeembeheer / CSO
> Telefoon Support Nederland: 0900 9633 (45 cpm)
> Telefoon Support Belgi=EB: 0900 70312 (45 cpm)
> Telefoon Direct: (+31) (0)20 50 60 104
> Fax: +31 (0)20 50 60 111
> E-mail: support@pcextreme.nl
> Website: http://www.pcextreme.nl
> Kennisbank: http://support.pcextreme.nl/
> Netwerkstatus: http://nmc.pcextreme.nl
>=20
>=20
> On Wed, 2010-07-07 at 09:58 +0000, Thomas Mueller wrote:
> > hi
> >=20
> > my tests fail today because cmds segfaults on start.
> >=20
> >=20
> > [116817.230467] cmds[2868]: segfault at 10 ip 0000000000686bee sp=20
> > 00007fc0a3831230 error 4 in cmds[400000+335000]
> >=20
> >=20
> >=20
> > Bad Rev: 83d1ea6636dd432dcbb6a0c6046d551bee7be5c6
> > Last known good: b0056ad0c09dd4e9cbd46f84a4123cdc9c4b7a02 (yesterday)
> >=20
> > - Thomas
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-2002872900-1278513856=:23002--
