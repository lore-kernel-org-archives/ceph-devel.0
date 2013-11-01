From: charles L <charlesboy009@hotmail.com>
Subject: RE: [ceph-users] testing ceph
Date: Fri, 1 Nov 2013 10:59:55 +0100
Message-ID: <DUB116-W1263FA276C8EDDD6DE93ADDE0F50@phx.gbl>
References: <DUB116-W523C6A38229410FEA98789E00B0@phx.gbl>,<397629797.926085.1383229622556.JavaMail.zimbra@csc.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dub0-omc4-s13.dub0.hotmail.com ([157.55.2.88]:11228 "EHLO
	dub0-omc4-s13.dub0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751371Ab3KAJ74 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Nov 2013 05:59:56 -0400
In-Reply-To: <397629797.926085.1383229622556.JavaMail.zimbra@csc.fi>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karan Singh <ksingh@csc.fi>
Cc: "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Karan/All,

Thanks.I guess Joao Eduardo=A0missunderstood me too.


1. yes there is 1 SSD on each server. There is also 4 data drive on eac=
h server. so i will have 4 OSD's on each server.

2. I want to know if its a good idea to use 1 partition on the SSD for =
the journals of the 4 OSD's.

3. considering if the SSD FAILS WHAT HAPPENS TO THE OSD's? if i have 3 =
replicas set, what is a good PLACEMENT GROUP NUMBER for the data pool, =
THAT ENSURES the 3 replicas don't end up on the same node.=A0
because if it does then crush map etc can never recover the my data.

Any idea?

/regards

Charles.

________________________________
> Date: Thu, 31 Oct 2013 16:27:02 +0200=20
> From: ksingh@csc.fi=20
> To: charlesboy009@hotmail.com=20
> CC: majordomo@vger.kernel.org; ceph-users@ceph.com=20
> Subject: Re: [ceph-users] testing ceph=20
>=20
> Hello Charles=20
>=20
> Need some more clarification with your setup , Did you mean=20
>=20
> 1) There is 1 SSD ( 60 GB ) on each server i.e 6 SSD on all 6 servers=
 ?=20
>=20
> 2) your osd.3 , osd.4 , osd.5 uses same journal ( /dev/sdf2 ) ?=20
>=20
> Regards=20
> Karan Singh=20
>=20
> ________________________________=20
> From: "charles L" <charlesboy009@hotmail.com>=20
> To: "ceph dev" <majordomo@vger.kernel.org>, ceph-users@ceph.com=20
> Sent: Thursday, 31 October, 2013 6:24:13 AM=20
> Subject: [ceph-users] testing ceph=20
>=20
> Hi,=20
> Pls is this a good setup for a production environment test of ceph? M=
y=20
> focus is on the SSD ... should it be partitioned(sdf1,2 ,3,4) and=20
> shared by the four OSDs on a host? or is this a better configuration=20
> for the SSD to be just one partition(sdf1) while all osd uses that on=
e=20
> partition?=20
> my setup:=20
> - 6 Servers with one 250gb boot disk for OS(sda),=20
> four-2Tb Disks each for the OSDs i.e Total disks =3D 6x4 =3D 24 disks=
 (sdb -sde)=20
> and one-60GB SSD for Osd Journal(sdf).=20
> -RAM =3D 32GB on each server with 2 GB network link.=20
> hostname for servers: Server1 -Server6=20
>=20
> [osd.0]=20
> host =3D server1=20
> devs =3D /dev/sdb=20
> osd journal =3D /dev/sdf1=20
> [osd.1]=20
> host =3D server1=20
> devs =3D /dev/sdc=20
> osd journal =3D /dev/sdf2=20
>=20
> [osd.3]=20
> host =3D server1=20
> devs =3D /dev/sdd=20
> osd journal =3D /dev/sdf2=20
>=20
> [osd.4]=20
> host =3D server1=20
> devs =3D /dev/sde=20
> osd journal =3D /dev/sdf2=20
> [osd.5]=20
> host =3D server2=20
> devs =3D /dev/sdb=20
> osd journal =3D /dev/sdf2=20
> ...=20
> [osd.23]=20
> host =3D server6=20
> devs =3D /dev/sde=20
> osd journal =3D /dev/sdf2=20
>=20
> Thanks.=20
>=20
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users@lists.ceph.com=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
> 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
