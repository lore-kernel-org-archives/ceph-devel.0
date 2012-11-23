From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: RBD fio Performance concerns
Date: Fri, 23 Nov 2012 12:03:56 +0100 (CET)
Message-ID: <3ed000f5-38d6-45dd-917e-5e29c5b7ff1a@mailpro>
References: <50AF54A6.4040805@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50037 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab2KWLE1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 06:04:27 -0500
In-Reply-To: <50AF54A6.4040805@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>

so correcly aligned...

Maybe try to use journal directly on the full partition, without xfs ?


----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Mark Nelson" <mark.nelson@inktank.com>, "ceph-devel" <ceph-devel@v=
ger.kernel.org>, "Mark Kampe" <mark.kampe@inktank.com>, "S=C3=A9bastien=
 Han" <han.sebastien@gmail.com>=20
Envoy=C3=A9: Vendredi 23 Novembre 2012 11:49:10=20
Objet: Re: RBD fio Performance concerns=20

Am 23.11.2012 11:47, schrieb Alexandre DERUMIER:=20
>>> when i switch the journal to the OSD Disk seperate partiton on each=
 disk=20
>>> (/dev/sdX1 for journal 1GB and /dev/sdX2 for OSD) i go down from 23=
=2E000=20
>>> iops to 200 iops random 4k.=20
> O_o , that's seem crazy...=20
> Are you sure that your partitions are correctly aligned ? (starting f=
irst partition at sector 2048 is best for ssd)=20

Model: ATA INTEL SSDSC2CW24 (scsi)=20
Disk /dev/sdb: 468862128s=20
Sector size (logical/physical): 512B/512B=20
Partition Table: gpt=20

Number Start End Size File system Name Flags=20
1 2048s 2342911s 2340864s xfs pri=20
2 2342912s 468860927s 466518016s xfs pri=20

Stefan=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
