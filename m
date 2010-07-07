From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: cmds segfault on startup (ceph.git/unstable)
Date: Wed, 07 Jul 2010 12:00:30 +0200
Message-ID: <1278496830.1946.5.camel@wido-desktop>
References: <i11j40$mk1$3@dough.gmane.org>
Reply-To: wido@pcextreme.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:37138 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab0GGKAc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jul 2010 06:00:32 -0400
In-Reply-To: <i11j40$mk1$3@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

I just noticed the same, see my issue:
http://tracker.newdream.net/issues/259

Seems to be due to this commit: 83d1ea6636dd432dcbb6a0c6046d551bee7be5c=
6

Rolling back one revision right now to see if it indeed is the problem.

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


On Wed, 2010-07-07 at 09:58 +0000, Thomas Mueller wrote:
> hi
>=20
> my tests fail today because cmds segfaults on start.
>=20
>=20
> [116817.230467] cmds[2868]: segfault at 10 ip 0000000000686bee sp=20
> 00007fc0a3831230 error 4 in cmds[400000+335000]
>=20
>=20
>=20
> Bad Rev: 83d1ea6636dd432dcbb6a0c6046d551bee7be5c6
> Last known good: b0056ad0c09dd4e9cbd46f84a4123cdc9c4b7a02 (yesterday)
>=20
> - Thomas
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
