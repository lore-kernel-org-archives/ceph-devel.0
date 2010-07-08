From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: "clocks not synchronized" warning message
Date: Thu, 08 Jul 2010 16:19:28 +0200
Message-ID: <1278598768.2253.18.camel@wido-laptop.pcextreme.nl>
References: <i14hq2$hn$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:59925 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512Ab0GHOTb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jul 2010 10:19:31 -0400
In-Reply-To: <i14hq2$hn$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi,

I'm experiencing the same. The default "mon lease wiggle room" is set
t .001, which gives the messages in my setup.

Right now i've set the room to 0.5, which gets rid of the messages, but
obviously this is imho not the way to go.

My nodes are running openntpd and a cron which runs ntpdate every hour.

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


On Thu, 2010-07-08 at 12:54 +0000, Thomas Mueller wrote:
> hi
>=20
> running ceph -w I see many of those warnings flying by:
>=20
> 10.07.08_14:36:49.897108   log 10.07.08_14:36:48.530057 mon1 192.168.=
1.52:6789/0 340 : [WRN] lease_expire from mon0 was sent from future tim=
e 10.07.08_14:36:48.886876, clocks not synchronized
> 10.07.08_14:36:49.897108   log 10.07.08_14:36:48.530076 mon1 192.168.=
1.52:6789/0 341 : [WRN]=20
>=20
> i've stopped ceph, ran ntpdate on every node, started ceph=20
> - the message is still there.=20
>=20
> date from the nodes:
> # for i in node001 node002 node003 node004; do ssh root@$i date; done
> Thu Jul  8 14:52:20 CEST 2010
> Thu Jul  8 14:52:20 CEST 2010
> Thu Jul  8 14:52:20 CEST 2010
> Thu Jul  8 14:52:21 CEST 2010
>=20
>=20
> this is on ceph.git/unstable from today.
>=20
> - Thomas
>=20
>=20
>=20
> ceph.conf:
>=20
>=20
> [global]
> 	; enable secure authentication
> 	; auth supported =3D cephx
>=20
> [mon]
> 	mon data =3D /ceph/mon$id
>=20
> 	; some minimal logging (just message traffic) to aid debugging
> 	;debug ms =3D 1
>=20
> [mon0]
> 	host =3D node001
> 	mon addr =3D 192.168.1.51:6789
>=20
> [mon1]
>         host =3D node002
>         mon addr =3D 192.168.1.52:6789
>=20
> [mon2]
>         host =3D node003
>         mon addr =3D 192.168.1.53:6789
>=20
> [mds]
> 	; where the mds keeps it's secret encryption keys
> 	keyring =3D /ceph/keyring.$name
>=20
> [mds.node001]
> 	host =3D node001
>=20
> [mds.node002]
> 	host =3D node002
>=20
> [mds.node003]
>         host =3D node003
>=20
> ; osd
> ;  You need at least one.  Two if you want data to be replicated.
> ;  Define as many as you like.
> [osd]
> 	; This is where the btrfs volume will be mounted.
> 	osd data =3D /ceph/osd$id
>=20
> 	; Ideally, make this a separate disk or partition.  A few GB
>  	; is usually enough; more if you have fast disks.  You can use
>  	; a file under the osd data dir if need be
>  	; (e.g. /ceph/osd$id/journal), but it will be slower than a
>  	; separate disk or partition.
> 	osd journal =3D /ceph/osd$id/journal
> 	osd journal size =3D 100
>=20
> [osd0]
> 	host =3D node001
>=20
> 	; if 'btrfs devs' is not specified, you're responsible for
> 	; setting up the 'osd data' dir.  if it is not btrfs, things
> 	; will behave up until you try to recover from a crash (which
> 	; usually fine for basic testing).
> 	;btrfs devs =3D /dev/sdx
>=20
> [osd1]
> 	host =3D node002
> 	;btrfs devs =3D /dev/sdy
>=20
> [osd2]
> 	host =3D node003
> 	;btrfs devs =3D /dev/sdx
>=20
> [osd3]
> 	host =3D node004
> 	;btrfs devs =3D /dev/sdy
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
